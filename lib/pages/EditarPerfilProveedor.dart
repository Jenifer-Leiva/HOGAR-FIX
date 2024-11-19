import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfilProveedor extends StatefulWidget {
  const EditarPerfilProveedor({super.key});

  @override
  State<EditarPerfilProveedor> createState() => _EditarPerfilProveedorState();
}

class _EditarPerfilProveedorState extends State<EditarPerfilProveedor> {
  // Controladores para capturar los datos ingresados
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController celularController = TextEditingController();

  // Variables para almacenar el ID del usuario autenticado y el tipo de usuario
  String? userId;
  String? userType;

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario();
  }

  // Método para cargar datos del usuario autenticado desde SharedPreferences
  Future<void> _cargarDatosUsuario() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
      userType = prefs.getString('userType');

      if (userId != null) {
        await _cargarDatosFirestore();
      }
    } catch (e) {
      print("Error al cargar datos del usuario: $e");
    }
  }

  // Método para cargar datos iniciales desde Firestore
  Future<void> _cargarDatosFirestore() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection(userType == 'Proveedor' ? 'Proveedores' : 'Clientes')
          .doc(userId)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          nombreController.text = data['Nombre'] ?? '';
          correoController.text = data['Correo'] ?? '';
          celularController.text = data['Celular'] ?? '';
        });
      }
    } catch (e) {
      print("Error al cargar datos desde Firestore: $e");
    }
  }

  // Método para actualizar los datos en Firestore
  Future<void> _actualizarDatos() async {
    if (userId == null || userType == null) return;

    try {
      await FirebaseFirestore.instance
          .collection(userType == 'Proveedor' ? 'Proveedores' : 'Clientes')
          .doc(userId)
          .update({
        'Nombre': nombreController.text,
        'Correo': correoController.text,
        'Celular': celularController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos actualizados correctamente')),
      );
    } catch (e) {
      print("Error al actualizar datos: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al actualizar los datos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Sección de Foto de Perfil
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

            // Nombre del Cliente
            const Text(
              "Editar Perfil",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Sección de información personal
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Información personal"),
                  const SizedBox(height: 10),

                  // Campo de texto: Nombre
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Campo de texto: Correo
                  TextField(
                    controller: correoController,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Campo de texto: Celular
                  TextField(
                    controller: celularController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Celular',
                      border: OutlineInputBorder(),
                      prefixText: '+57 ',
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón Guardar
                  Center(
                    child: ElevatedButton(
                       onPressed: () async {
                     await _actualizarDatos(); // Llama al método para actualizar los datos
                 Navigator.pushNamed(context, '/perfilproveedor'); // Luego navega a la página deseada
                },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Guardar"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método auxiliar para construir títulos de sección
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

  @override
  void dispose() {
    // Liberar los controladores cuando el widget se destruya
    nombreController.dispose();
    correoController.dispose();
    celularController.dispose();
    super.dispose();
  }
}
