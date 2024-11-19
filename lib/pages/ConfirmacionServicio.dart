import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ConfirmacionServicio extends StatelessWidget {
  const ConfirmacionServicio({super.key});

  // Función para obtener los detalles del servicio y proveedor
  Future<Map<String, String>> _fetchServiceDetails(String serviceId) async {
    try {
      // Recuperar el documento del servicio basado en el serviceId
      final serviceSnapshot = await FirebaseFirestore.instance
          .collection('Servicios')
          .doc(serviceId)
          .get();

      if (serviceSnapshot.exists) {
        // Obtener providerUserId y otros detalles del servicio
        String providerUserId = serviceSnapshot['proveedor'];
       

        // Obtener el nombre del proveedor
        final providerSnapshot = await FirebaseFirestore.instance
            .collection('Proveedores')
            .doc(providerUserId)
            .get();

        String providerName = providerSnapshot.exists
            ? providerSnapshot['Nombre']
            : 'Proveedor no encontrado';

        // Devolver todos los detalles del servicio y proveedor
        return {
          'providerName': providerName,
          'serviceId': serviceId,
        };
      } else {
        return {}; // Si no existe el documento del servicio
      }
    } catch (e) {
      return {}; // Error al obtener los detalles
    }
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el serviceId del argumento enviado
    final String serviceId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmación de Servicio"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Map<String, String>>(
          future: _fetchServiceDetails(serviceId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Indicador de carga
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No se encontraron detalles del servicio'));
            }

            final serviceDetails = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                _buildHeader(),
                const SizedBox(height: 20),
                _buildServiceDetails(context, serviceDetails),
                const Spacer(),
              ],
            );
          },
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

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          '¡Tu servicio ha sido aceptado por el\nproveedor!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDetails(BuildContext context, Map<String, String> serviceDetails) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.person, color: Colors.black),
              SizedBox(width: 8),
              Text(
                serviceDetails['providerName']!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text('Tipo de servicio: ${serviceDetails['tipoServicio']}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('ID del servicio: ${serviceDetails['serviceId']}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('Fecha del servicio: ${serviceDetails['fechaServicio']}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('La franja horaria elegida fue de ${serviceDetails['horaServicio']}', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          Text('El precio estimado por hora es de \$--', style: TextStyle(fontSize: 16)),
          SizedBox(height: 8),
          const Text(
            'Recuerda que esto es un estimado, el precio puede variar dependiendo de la consideración del proveedor. Si tienes dudas respecto al precio final, por favor contacta al proveedor.',
            style: TextStyle(fontSize: 14, color: Colors.orange),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
  onPressed: () async {
    try {
      // Actualizar el estado a "en progreso" en la colección "Servicios"
      await FirebaseFirestore.instance
          .collection('Servicios')
          .doc(serviceDetails['serviceId'])
          .update({
        'estado': 'en progreso',
      });

      // Navegar a la pantalla de progreso del servicio y pasar el serviceId
      Navigator.pushNamed(
        context,
        '/progresoservicio',
        arguments: serviceDetails['serviceId'],  // Pasamos el serviceId
      );
    } catch (e) {
      // Mostrar un mensaje de error si la actualización falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al iniciar el servicio: $e')),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
  ),
  child: const Text("Iniciar servicio"),
),
             ElevatedButton(
  onPressed: () async {
    try {
      // Eliminar el servicio de la colección "Servicios"
      await FirebaseFirestore.instance
          .collection('Servicios')
          .doc(serviceDetails['serviceId'])
          .delete();

      // Mostrar un mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Servicio cancelado correctamente')),
      );

      // Navegar a la pantalla inicial o cualquier otra que consideres
      Navigator.pushNamed(context, '/iniciocliente');
    } catch (e) {
      // Mostrar un mensaje de error si la eliminación falla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cancelar el servicio: $e')),
      );
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
  child: const Text(
    'Cancelar',
    style: TextStyle(fontSize: 16, color: Colors.white),
  ),
),

            ],
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
