import 'package:flutter/material.dart';


class PerfilCliente extends StatefulWidget {
  const PerfilCliente({super.key});

  @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<PerfilCliente> {
  // Índice actual de la página seleccionada
  int _selectedIndex = 2;

  // Método para cambiar la página
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Realiza la navegación a las rutas según el índice seleccionado
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/iniciocliente');
        break;
      case 1:
        Navigator.pushNamed(context, '/historial');
        break;
      case 2:
        Navigator.pushNamed(context, '/perfilcliente');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          // Las pantallas de ejemplo (reemplázalas con tus pantallas reales)
          PlaceholderWidget(color: Colors.green, text: 'Servicios'),
          PlaceholderWidget(color: Colors.blue, text: 'Historial'),
          PerfilClienteContent(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_repair_service),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Mi perfil',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 153, 0),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Pantalla de Servicios
class ServiciosScreen extends StatelessWidget {
  const ServiciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Servicios")),
      body: const Center(child: Text('Pantalla de Servicios')),
    );
  }
}

// Pantalla de Historial
class HistorialScreen extends StatelessWidget {
  const HistorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Historial")),
      body: const Center(child: Text('Pantalla de Historial')),
    );
  }
}

// Contenido de la página "Mi perfil"
class PerfilClienteContent extends StatelessWidget {
  const PerfilClienteContent({super.key});

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
              "Nombre",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            // Sección de Información Personal
            _buildSectionTitle("Información personal"),
            _buildInfoRow("Correo"),
            _buildInfoRow("Dirección"),
            _buildInfoRow("Celular"),
            const SizedBox(height: 15),

            const Divider(
              color: Colors.orange, // Color de la línea
              thickness: 1.5,       // Grosor de la línea
            ),

            // Sección de Soporte
            _buildInfoRow("Soporte"),
            _buildInfoRow("Cerrar sesión"),
            _buildInfoRow("Eliminar cuenta"),
            const SizedBox(height: 20),

            // Botón Editar Información
            ElevatedButton(
              onPressed: () {},
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

  // Método auxiliar para construir cada fila de información
  Widget _buildInfoRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

// PlaceholderWidget es una vista temporal que se muestra para cada sección
class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String text;

  const PlaceholderWidget({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: color,
        child: Text(
          text,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
