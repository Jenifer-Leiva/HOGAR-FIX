import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditarPerfilCliente extends StatefulWidget {
  const EditarPerfilCliente({super.key});

  @override
  State<EditarPerfilCliente> createState() => _EditarPerfilClienteState();
}

class _EditarPerfilClienteState extends State<EditarPerfilCliente> {
  // Controladores para capturar los datos ingresados
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController correoController = TextEditingController();
  final TextEditingController celularController = TextEditingController();

  // ID del cliente a actualizar (se obtiene dinámicamente)
  String? clienteId;

  @override
  void initState() {
    super.initState();
    _cargarUserId(); // Cargar el userId
  }

  // Método para cargar el userId desde SharedPreferences
  Future<void> _cargarUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    clienteId = prefs.getString('userId'); // Obtiene el userId desde SharedPreferences
    if (clienteId != null) {
      _cargarDatos(); // Llamamos a cargar los datos del usuario si el userId está disponible
    } else {
      print("Error: No se pudo obtener el userId.");
    }
  }

  // Método para cargar datos iniciales desde Firestore
  Future<void> _cargarDatos() async {
    if (clienteId == null) return; // Verifica si el userId está disponible

    try {
      final doc = await FirebaseFirestore.instance
          .collection('Clientes')
          .doc(clienteId)
          .get();
      if (doc.exists) {
        final data = doc.data()!;
        nombreController.text = data['Nombre'] ?? '';
        correoController.text = data['Correo'] ?? '';
        celularController.text = data['Celular'] ?? '';
      }
    } catch (e) {
      print("Error al cargar datos: $e");
    }
  }

  // Método para actualizar los datos en Firestore
  Future<void> _actualizarDatos() async {
    if (clienteId == null) return; // Verifica si el userId está disponible

    try {
      await FirebaseFirestore.instance.collection('Clientes').doc(clienteId).update({
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
                        Navigator.pushNamed(context, '/perfilcliente'); // Luego navega a la página deseada
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
