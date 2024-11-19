import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilCliente extends StatefulWidget {
  const PerfilCliente({super.key});

  @override
  State<PerfilCliente> createState() => _PerfilClienteState();
}

class _PerfilClienteState extends State<PerfilCliente> {
  late Future<Map<String, dynamic>?> _userDataFuture;

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdCliente = prefs.getString('userIdCliente');
    
    if (userIdCliente != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('Clientes')
          .doc(userIdCliente)
          .get();
      if (userDoc.exists) {
        return userDoc.data() as Map<String, dynamic>?;
      }
    }
    return null;
  }

  // Método para eliminar el usuario
  Future<void> _deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userIdCliente = prefs.getString('userIdCliente');
    
    if (userIdCliente != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Clientes')
            .doc(userIdCliente)
            .delete(); // Elimina el documento de la base de datos
        prefs.remove('userId'); // Opcionalmente, puedes eliminar el userId guardado en SharedPreferences
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false); // Redirige al inicio
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
      body: SingleChildScrollView(
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
            FutureBuilder<Map<String, dynamic>?>( 
              future: _userDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text("Error al cargar los datos");
                } else if (snapshot.data == null) {
                  return const Text("Usuario no encontrado");
                } else {
                  Map<String, dynamic> userData = snapshot.data!;
                  return Column(
                    children: [
                      Text(
                        userData['Nombre'] ?? 'Nombre',
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      _buildSectionTitle("Información personal"),
                      _buildInfoRow("Correo", userData['Correo']),
                      _buildInfoRow("Dirección", userData['Dirección']),
                      _buildInfoRow("Celular", userData['Celular']),
                    ],
                  );
                }
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
                // Acción para cerrar sesión
              },
              child: const Text("Cerrar sesión", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: _showDeleteConfirmationDialog, // Llamamos al método para mostrar el diálogo
              child: const Text("Eliminar cuenta", style: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/editarperfilcliente');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
              child: const Text("Editar info"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            _buildNavButton(
              icon: Icons.home_repair_service,
              label: 'servicios',
              onPressed: () {
                Navigator.pushNamed(context, '/iniciocliente');
              },
            ),
            _buildNavButton(
              icon: Icons.history,
              label: 'Historial',
              onPressed: () {
                Navigator.pushNamed(context, '/historialcliente');
              },
            ),
            _buildNavButton(
              icon: Icons.person,
              label: 'Mi perfil',
              onPressed: () {
                Navigator.pushNamed(context, '/perfilcliente');
              },
            ),
            _buildNavButton(
              icon: Icons.support_agent,
              label: 'Soporte',
              onPressed: () {
                Navigator.pushNamed(context, '/soporte');
              },
            ),
          ],
        ),
      ),
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

  Widget _buildInfoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          Text(
            value ?? '',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
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
