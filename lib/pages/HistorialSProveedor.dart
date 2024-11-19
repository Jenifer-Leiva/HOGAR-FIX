import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistorialSProveedor extends StatelessWidget {
  const HistorialSProveedor({super.key});

  // Function to get provider's user ID from SharedPreferences
  Future<String> _getProviderUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('providerUserId') ?? 'No ID'; // Return a default value if not found
  }

  // Function to fetch the client name from the "Clientes" collection
  Future<String> _fetchClientName(String clientUserId) async {
    try {
      final clientSnapshot = await FirebaseFirestore.instance
          .collection('Clientes')
          .doc(clientUserId)
          .get();

      if (clientSnapshot.exists) {
        return clientSnapshot['Nombre'] ?? 'Nombre no disponible';
      } else {
        return 'Cliente no encontrado';
      }
    } catch (e) {
      return 'Error al cargar cliente';
    }
  }

  // Function to fetch services from Firestore and return the list of clients for the provider
  Future<List<Map<String, String>>> _fetchClientDetails(String providerUserId) async {
    try {
      final serviceSnapshot = await FirebaseFirestore.instance
          .collection('Servicios')
          .where('proveedor', isEqualTo: providerUserId)
          .get();

      List<Map<String, String>> clientDetails = [];
      for (var doc in serviceSnapshot.docs) {
        String clientUserId = doc['cliente'];
        String clientName = await _fetchClientName(clientUserId);
        clientDetails.add({
          'clientUserId': clientUserId,
          'clientName': clientName,
        });
      }

      return clientDetails; // Return the list of client details
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
          'Mis servicios',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Builds the service history list
  Widget _buildServiceHistory(BuildContext context) {
    return FutureBuilder<String>(
      future: _getProviderUserId(),  // Get provider user ID
      builder: (context, providerSnapshot) {
        if (providerSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while fetching provider ID
        }

        if (providerSnapshot.hasError) {
          return Text('Error: ${providerSnapshot.error}');
        }

        String providerUserId = providerSnapshot.data ?? 'No ID';

        return FutureBuilder<List<Map<String, String>>>(
          future: _fetchClientDetails(providerUserId), // Fetch client details for the provider
          builder: (context, clientSnapshot) {
            if (clientSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator while fetching clients
            }

            if (clientSnapshot.hasError) {
              return Text('Error al cargar clientes');
            }

            List<Map<String, String>> clientDetails = clientSnapshot.data ?? [];

            if (clientDetails.isEmpty) {
              return Text('No hay clientes asociados');
            }

            return Column(
              children: clientDetails.map((client) {
                return _buildServiceCard(context, client['clientName']!, client['clientUserId']!);
              }).toList(),
            );
          },
        );
      },
    );
  }

  // Builds each service card
  Widget _buildServiceCard(BuildContext context, String clientName, String clientUserId) {
    return Card(
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'dd/mm/aa, 00:00', // Placeholder for dynamic date
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  clientName,
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'en progreso', // Replace with your service status
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
              ],
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
}
