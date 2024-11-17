import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilProveedor extends StatefulWidget {
  const PerfilProveedor({super.key});

  @override
  _PerfilProveedorState createState() => _PerfilProveedorState();
}

class _PerfilProveedorState extends State<PerfilProveedor> {
   TextEditingController _precioController = TextEditingController();
String? precio = '';
  String? selectedService;
  String? hojaDeVidaUrl;
  String? certificacionUrl;
  Map<String, String?> selectedTimes = {
    "Lunes": null,
    "Martes": null,
    "Miércoles": null,
    "Jueves": null,
    "Viernes": null,
    "Sábado": null,
    "Domingo": null,
  };

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  // Cargar datos desde SharedPreferences
 Future<void> _loadPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences userPrefs = await SharedPreferences.getInstance();
  
  String? userId = prefs.getString('userId');
  
  if (userId != null) {
    setState(() {
      selectedService = userPrefs.getString('${userId}_selectedService');
      // Cargar horarios por cada día con el userId como prefijo
      selectedTimes = Map.fromIterable(
        ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'],
        key: (day) => day,
        value: (day) => userPrefs.getString('${userId}_$day'),
      );
      // Cargar el precio guardado
      precio = userPrefs.getString('${userId}_precio') ?? ''; 
      _precioController.text = precio ?? ''; // Asigna el valor del precio al controller del TextField
    });
  }
}


// Guardar los datos en SharedPreferences
Future<void> _savePreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences userPrefs = await SharedPreferences.getInstance();
  
  String? userId = prefs.getString('userId');
  
  if (userId != null) {
    if (selectedService != null && selectedService!.isNotEmpty) {
      userPrefs.setString('${userId}_selectedService', selectedService!);
    }
    selectedTimes.forEach((day, time) {
      if (time != null && time.isNotEmpty) {
        userPrefs.setString('${userId}_$day', time!);
      }
    });

    // Guardar el precio solo si se ha ingresado un valor
    if (precio != null && precio!.isNotEmpty) {
      userPrefs.setString('${userId}_precio', precio!); // Guardar el precio en SharedPreferences
    }
  }
}



// Método para eliminar el usuario
 Future<void> _deleteUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  SharedPreferences userPrefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId');
  
  if (userId != null) {
    try {
      // Eliminar el documento en Firestore
      await FirebaseFirestore.instance
          .collection('Proveedores')
          .doc(userId)
          .delete();
      
      // Eliminar preferencias del usuario
      userPrefs.remove('${userId}_selectedService');
      selectedTimes.forEach((day, _) {
        userPrefs.remove('${userId}_$day');
      });
      userPrefs.remove('${userId}_precio');
      prefs.remove('userId'); // Eliminar el userId de SharedPreferences

      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); // Redirigir al inicio
    } catch (e) {
      print('Error al eliminar la cuenta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al eliminar la cuenta"))
      );
    }
  }
}

  










  // Método para mostrar un diálogo de confirmación
  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("¿Estás seguro?"),
          content: const Text("Esta acción eliminará permanentemente tu cuenta."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                 _deleteUser(); // Eliminar el usuario si se confirma
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text("Eliminar"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: _fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar los datos"));
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("No se encontraron datos"));
          }

          var proveedorData = snapshot.data!;
          String nombre = proveedorData['Nombre'] ?? 'Sin nombre';
          String correo = proveedorData['Correo'] ?? 'Sin correo';
          String celular = proveedorData['Celular'] ?? 'Sin celular';

          // Acceder a los datos con data()
          var data = proveedorData.data() as Map<String, dynamic>;
          String? hojaDeVidaUrl = data['HojaDeVidaUrl'];
          String? certificacionUrl = data['CertificacionUrl'];

          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: Colors.orange,
                  padding: const EdgeInsets.all(40),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.orange,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  nombre,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle("Información personal"),
                      const SizedBox(height: 10),
                      Text(
                        "Correo: $correo\nCelular: $celular",
                        style: const TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      _buildSectionTitle("Acerca de tu servicio"),
                      _buildServiceDropdown(),
                      _buildSectionTitle("Tus horarios"),
                      const SizedBox(height: 10),
                      _buildDropdownTimeIntervals(),
                      const SizedBox(height: 10),
                      _buildSectionTitle("Tus certificaciones"),
                      _buildDocumentUploadSection("Hoja de vida", hojaDeVidaUrl),
                      _buildDocumentUploadSection("Certificación técnica", certificacionUrl),
                     const SizedBox(height: 10),
                      _buildSectionTitle("Tu precio estimado"),
            TextField(
  controller: _precioController,
  decoration: InputDecoration(
    hintText: "Ingresa el precio por hora",
    prefixText: "\$ ", // Agregar símbolo de peso antes del valor
    border: OutlineInputBorder(),
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  // No actualizamos el estado hasta que el usuario presione el botón

),
ElevatedButton(
  onPressed: () {
    setState(() {
      precio = _precioController.text; // Asignamos el texto ingresado en el TextField
    });
    _savePreferences(); // Ahora guardamos el precio
  },
  child: Text('Guardar Precio'),
),

            ///////////////////////////
            const SizedBox(height: 10),
            const Divider(color: Colors.orange, thickness: 1),
            const SizedBox(height: 10),
            const Divider(color: Colors.orange, thickness: 1),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text("Cerrar sesión", style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed:  _showDeleteConfirmationDialog,
                        child: const Text("Eliminar cuenta", style: TextStyle(color: Colors.grey)),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/editarperfilproveedor');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text("Editar info"),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavButton(
              icon: Icons.home_repair_service,
              label: 'Servicios',
              onPressed: () {
                Navigator.pushNamed(context, '/inicioproveedor');
              },
            ),
            _buildNavButton(
              icon: Icons.history,
              label: 'Historial',
              onPressed: () {
                Navigator.pushNamed(context, '/historialproveedor');
              },
            ),
            _buildNavButton(
              icon: Icons.person,
              label: 'Mi perfil',
              onPressed: () {
                Navigator.pushNamed(context, '/perfilproveedor');
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<DocumentSnapshot> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null) {
      return await FirebaseFirestore.instance
          .collection('Proveedores')
          .doc(userId)
          .get();
    } else {
      throw Exception("No se encontró el userId.");
    }
  }


  Widget _buildServiceDropdown() {
  const services = [
    "Plomería", "Electricidad", "Carpintería", "Pintura", "Albañilería", 
    "Cerrajería", "Jardinería", "Impermeabilización", "Herrería",
    "Aire acondicionado", "Limpieza de cisternas", "Fontanería", 
    "Desinfección y fumigación", "Limpieza de fachadas", "Reparación de electrodomésticos",
    "Instalación de cortinas", "Vidriería", "Mudanza y transporte", 
    "Sistemas de seguridad", "Redes y telecomunicaciones"
  ];

  return DropdownButton<String>(
    value: selectedService,
    hint: const Text("Selecciona un servicio"),
    items: services.map((String service) {
      return DropdownMenuItem<String>(
        value: service,
        child: Text(service),
      );
    }).toList(),
    onChanged: (String? newValue) async {
  // Solo actualizar si el nuevo valor no es null ni vacío
  if (newValue != null && newValue.isNotEmpty) {
    setState(() {
      selectedService = newValue;
    });

    // Guardar en SharedPreferences
    _savePreferences();

    // Actualizar Firebase solo si el valor es válido
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    
    if (userId != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Proveedores')
            .doc(userId)
            .update({'Servicio': newValue}); // Actualiza el campo "servicio"
        print('Servicio actualizado en la base de datos');
      } catch (e) {
        print('Error al actualizar el servicio: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al actualizar el servicio')),
        );
      }
    }
  }
},
  );
} 

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Colors.orange, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          const Expanded(child: Divider(color: Colors.orange, thickness: 1)),
        ],
      ),
    );
  }



  Widget _buildDropdownTimeIntervals() {
    const timeIntervals = [
      "7:00 - 8:00 am", "8:00 - 9:00 am", "9:00 - 10:00 am", 
      "10:00 - 11:00 am", "11:00 - 12:00 pm", "12:00 - 1:00 pm", 
      "1:00 - 2:00 pm", "2:00 - 3:00 pm", "3:00 - 4:00 pm", 
      "4:00 - 5:00 pm", "5:00 - 6:00 pm"
    ];

    return Column(
      children: selectedTimes.keys.map((day) {
        return Row(
          children: [
            Text(day, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 20),
            DropdownButton<String>(
              value: selectedTimes[day],
              hint: const Text("Selecciona hora"),
              items: timeIntervals.map((String time) {
                return DropdownMenuItem<String>(
                  value: time,
                  child: Text(time),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTimes[day] = newValue;
                  _savePreferences(); // Guardar el horario seleccionado
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }

Widget _buildDocumentUploadSection(String label, String? currentUrl) {
    return Row(
      children: [
        Text("$label: "),
        IconButton(
          onPressed: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();

            if (result != null) {
              File file = File(result.files.single.path!);
              String fileName = result.files.single.name;
              UploadTask uploadTask = FirebaseStorage.instance
                  .ref("documents/$fileName")
                  .putFile(file);

              TaskSnapshot snapshot = await uploadTask;
              String downloadUrl = await snapshot.ref.getDownloadURL();

              setState(() {
                if (label == "Hoja de vida") {
                  hojaDeVidaUrl = downloadUrl;
                } else if (label == "Certificación técnica") {
                  certificacionUrl = downloadUrl;
                }
              });

              // Guardar la URL del archivo en Firestore
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String? userId = prefs.getString('userId');
              if (userId != null) {
                FirebaseFirestore.instance
                    .collection('Proveedores')
                    .doc(userId)
                    .update({
                  label == "Hoja de vida" ? "HojaDeVidaUrl" : "CertificacionUrl": downloadUrl
                });
              }
            }
          },
          icon: const Icon(Icons.upload_file),
        ),
      ],
    );
  }
  


 Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, size: 28, color: Colors.orange),
          onPressed: onPressed,
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}