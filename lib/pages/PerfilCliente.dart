import 'package:flutter/material.dart';


class PerfilCliente extends StatelessWidget {
  const PerfilCliente({super.key});

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

      // Barra de navegación inferior
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavButton(
              icon: Icons.home_repair_service,
              label: 'Servicios',
              onPressed: () {
                Navigator.pushNamed(context, '/iniciocliente');
              },
            ),
            _buildNavButton(
              icon: Icons.history,
              label: 'Historial',
              onPressed: () {
                Navigator.pushNamed(context, '/historialservicios');
              },
            ),
            _buildNavButton(
              icon: Icons.person,
              label: 'Mi perfil',
              onPressed: () {
                Navigator.pushNamed(context, '/perfilcliente');
              },
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

  // Método para construir un botón de navegación con icono
  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.orange,
        elevation: 5, // Mayor elevación para hacerlo más prominente
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Botones más grandes
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Bordes menos redondeados
        ),
        minimumSize: const Size(100, 50), // Tamaño mínimo de los botones
      ),
      icon: Icon(
        icon,
        size: 28, // Iconos más grandes
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 14, // Fuente un poco más grande
        ),
      ),
    );
  }
}
