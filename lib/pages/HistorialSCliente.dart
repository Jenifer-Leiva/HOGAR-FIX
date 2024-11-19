import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistorialSCliente extends StatelessWidget {
  const HistorialSCliente({super.key});

  // Function to get client's user ID from SharedPreferences
  Future<String> _getClientUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userIdCliente') ?? 'No ID'; // Return a default value if not found
  }

  // Function to fetch the provider name from the "Proveedores" collection
  Future<String> _fetchProviderName(String providerUserId) async {
    try {
      final providerSnapshot = await FirebaseFirestore.instance
          .collection('Proveedores')  // Now fetching from "Proveedores"
          .doc(providerUserId)
          .get();

      if (providerSnapshot.exists) {
        return providerSnapshot['Nombre'] ?? 'Nombre no disponible';
      } else {
        return 'Proveedor no encontrado';
      }
    } catch (e) {
      return 'Error al cargar proveedor';
    }
  }

  // Function to fetch services from Firestore and return the list of providers for the client
  Future<List<Map<String, String>>> _fetchProviderDetails(String clientUserId) async {
    try {
      final serviceSnapshot = await FirebaseFirestore.instance
          .collection('Servicios')
          .where('cliente', isEqualTo: clientUserId) // Filtering by client user ID
          .get();

      List<Map<String, String>> providerDetails = [];
      for (var doc in serviceSnapshot.docs) {
        String providerUserId = doc['proveedor'];  // Now fetching provider details
        String providerName = await _fetchProviderName(providerUserId);
        providerDetails.add({
          'providerUserId': providerUserId,
          'providerName': providerName,
        });
      }

      return providerDetails; // Return the list of provider details
    } catch (e) {
      return []; // Return an empty list in case of error
    }
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Mis proveedores',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Builds the service history list for providers
  Widget _buildServiceHistory(BuildContext context) {
    return FutureBuilder<String>(
      future: _getClientUserId(),  // Get client user ID
      builder: (context, clientSnapshot) {
        if (clientSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching client ID
        }

        if (clientSnapshot.hasError) {
          return Text('Error: ${clientSnapshot.error}');
        }

        String clientUserId = clientSnapshot.data ?? 'No ID';

        return FutureBuilder<List<Map<String, String>>>(
          future: _fetchProviderDetails(clientUserId), // Fetch provider details for the client
          builder: (context, providerSnapshot) {
            if (providerSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator while fetching providers
            }

            if (providerSnapshot.hasError) {
              return Text('Error al cargar proveedores');
            }

            List<Map<String, String>> providerDetails = providerSnapshot.data ?? [];

            if (providerDetails.isEmpty) {
              return Text('No hay proveedores asociados');
            }

            return Column(
              children: providerDetails.map((provider) {
                return _buildServiceCard(context, provider['providerName']!, provider['providerUserId']!);
              }).toList(),
            );
          },
        );
      },
    );
  }

  // Builds each service card for provider details
 Widget _buildServiceCard(BuildContext context, String providerName, String providerUserId) {
  return Card(
    color: Colors.orange[200],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    margin: const EdgeInsets.symmetric(vertical: 8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Expande el texto a la izquierda
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'dd/mm/aa, 00:00', // Placeholder para la fecha
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  providerName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'por confirmar', // Estado del servicio
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          
          // Espacio para el botón a la derecha
          Expanded(
            flex: 2, // Hace que el botón ocupe menos espacio
            child: Align(
              alignment: Alignment.centerRight, // Alinea el botón a la derecha
              child: TextButton(
                onPressed: () {
                  // Aquí puedes agregar la lógica para confirmar el servicio
                  Navigator.pushNamed(context, '/confirmacionservicio'); // Llamar a la función de confirmación
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange, // Color de fondo para el botón
                  foregroundColor: Colors.white, // Color del texto
                ),
                child: const Text('Confirmar servicio'),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
  // Builds navigation buttons for the bottom navigation bar
  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Servicios"),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildServiceHistory(context),
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
              label: 'Servicios',
              onPressed: () {
                Navigator.pushNamed(context, '/iniciocliente');  // Adjust navigation path for cliente
              },
            ),
            _buildNavButton(
              icon: Icons.history,
              label: 'Historial',
              onPressed: () {
                Navigator.pushNamed(context, '/historialcliente');  // Adjust navigation path for cliente
              },
            ),
            _buildNavButton(
              icon: Icons.person,
              label: 'Mi perfil',
              onPressed: () {
                Navigator.pushNamed(context, '/perfilcliente');  // Adjust navigation path for cliente
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
}
