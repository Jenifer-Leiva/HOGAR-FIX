import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InicioProveedor extends StatefulWidget {
  const InicioProveedor({super.key});

  @override
  _InicioProveedorState createState() => _InicioProveedorState();
}

class _InicioProveedorState extends State<InicioProveedor> {
  // Lista de solicitudes de servicio
  List<Map<String, dynamic>> serviceRequests = [];

  @override
  void initState() {
    super.initState();
    _loadServiceRequests();
  }

  // Función para obtener el nombre del cliente desde Firebase usando un userId
  Future<String?> _getClientNameFromFirebase(String userIdCliente) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot clientDoc = await firestore.collection('Clientes').doc(userIdCliente).get();

    if (clientDoc.exists) {
      return clientDoc['Nombre']; // Asegúrate de que 'nombre' sea la clave correcta en la base de datos
    } else {
      return null;
    }
  }

  // Función para obtener la lista de userIds desde SharedPreferences
  Future<List<String>> _getUserIdsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('userIdsCliente') ?? [];
  }

  // Función para obtener las solicitudes ya aceptadas
  Future<List<String>> _getAcceptedRequestsFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('acceptedRequests') ?? [];
  }

  // Función para cargar las solicitudes de servicio desde SharedPreferences
  Future<void> _loadServiceRequests() async {
    List<String> userIds = await _getUserIdsFromSharedPreferences();
    List<String> acceptedRequests = await _getAcceptedRequestsFromSharedPreferences(); // Obtener las solicitudes aceptadas

    List<Map<String, dynamic>> requests = [];

    for (String userId in userIds) {
      // Verificar si la solicitud ya ha sido aceptada
      if (acceptedRequests.contains(userId)) {
        continue; // Si ya ha sido aceptada, la omitimos
      }

      // Obtener el nombre del cliente desde Firebase
      String? clientName = await _getClientNameFromFirebase(userId);

      if (clientName != null) {
        // Suponiendo que las solicitudes de servicio son fijas para cada cliente. Cambia según tus necesidades.
        requests.add({
          "clientName": clientName,
          "userId": userId, // Agregamos el userId del cliente
          "requestDate": "12/11/2024",
          "requestTime": "10:30 AM",
          "address": "Calle Falsa 123",
        });
      }
    }

    // Guardamos las solicitudes de servicio en SharedPreferences para mantener el estado
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serviceRequestStrings = requests
        .map((request) =>
            '${request["clientName"]}|${request["userId"]}|${request["requestDate"]}|${request["requestTime"]}|${request["address"]}')
        .toList();
    await prefs.setStringList('serviceRequests', serviceRequestStrings);

    // Actualizar el estado para reflejar los datos cargados
    setState(() {
      serviceRequests = requests;
    });
  }

  // Función para guardar el servicio en Firestore
  Future<void> saveServiceRequest(String userIdCliente) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? providerUserId = prefs.getString('providerUserId'); // Obtener providerUserId desde SharedPreferences

    if (providerUserId == null) {
      print('No se encontró el ID del proveedor en SharedPreferences');
      return;
    }

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Obtener el nombre del cliente
      DocumentSnapshot clientDoc = await firestore.collection('Clientes').doc(userIdCliente).get();
      String? clientName = clientDoc.exists ? clientDoc['Nombre'] : null;

      // Obtener el nombre del proveedor
      DocumentSnapshot providerDoc = await firestore.collection('Proveedores').doc(providerUserId).get();
      String? providerName = providerDoc.exists ? providerDoc['Nombre'] : null;

      if (clientName == null || providerName == null) {
        print('No se pudieron obtener los nombres del cliente o proveedor');
        return;
      }

      // Guardar el servicio en Firestore
      await firestore.collection('Servicios').add({
        'cliente': userIdCliente, // Nombre del cliente
        'proveedor': providerUserId, // Nombre del proveedor
        'estado': 'pendiente',
        'fechaCreacion': FieldValue.serverTimestamp(), // Fecha/hora automática del servidor
      });

      print('Servicio guardado exitosamente.');
    } catch (e) {
      print('Error al guardar el servicio: $e');
    }
  }

  // Función para eliminar una solicitud de servicio
  Future<void> _removeServiceRequest(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Eliminar la solicitud de servicio
    String userId = serviceRequests[index]["userId"];
    serviceRequests.removeAt(index);

    // Guardar la lista actualizada de solicitudes en SharedPreferences
    List<String> serviceRequestStrings = serviceRequests
        .map((request) =>
            '${request["clientName"]}|${request["userId"]}|${request["requestDate"]}|${request["requestTime"]}|${request["address"]}')
        .toList();
    await prefs.setStringList('serviceRequests', serviceRequestStrings);

    // Agregar el userId de la solicitud aceptada a la lista de solicitudes aceptadas
    List<String> acceptedRequests = await _getAcceptedRequestsFromSharedPreferences();
    acceptedRequests.add(userId);
    await prefs.setStringList('acceptedRequests', acceptedRequests);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, color: Colors.black),
            Text(
              'CL 00 #0a-00',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Contenedor naranja para el texto "¡TIENES NUEVOS SERVICIOS POR ACEPTAR!"
          Container(
            width: double.infinity,
            color: Colors.orange,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Text(
              '¡TIENES NUEVOS SERVICIOS POR ACEPTAR!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // Lista de solicitudes de servicio en un ListView
          Expanded(
            child: serviceRequests.isEmpty
                ? const Center(child: Text("No tienes nuevos servicios"))
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: serviceRequests.length,
                    itemBuilder: (context, index) {
                      final request = serviceRequests[index];
                      return ServiceRequestCard(
                        clientName: request["clientName"]!,
                        requestDate: request["requestDate"]!,
                        requestTime: request["requestTime"]!,
                        address: request["address"]!,
                        onAccept: () async {
                          // Guardar servicio en Firestore al aceptar
                          await saveServiceRequest(serviceRequests[index]["userId"]);

                          // Eliminar la solicitud de la lista después de aceptarla
                          await _removeServiceRequest(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Servicio aceptado y guardado.')),
);
                      },
              onDecline: () async {
                        // Eliminar la solicitud de la lista después de rechazarla
                        await _removeServiceRequest(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Solicitud rechazada y eliminada.')),      

                            
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
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
                Navigator.pushNamed(context, '/inicioproveedor');
              },
            ),
            _buildNavButton(
  icon: Icons.history,
  label: 'Historial',
  onPressed: () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? providerUserId = prefs.getString('providerUserId');

    if (providerUserId != null) {
      Navigator.pushNamed(
        context,
        '/historialproveedor',
        arguments: {'providerUserId': providerUserId},
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No se encontró el ID del proveedor.')),
      );
    }
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

class ServiceRequestCard extends StatelessWidget {
  final String clientName;
  final String requestDate;
  final String requestTime;
  final String address;
  final VoidCallback onAccept;
   final VoidCallback onDecline;

  const ServiceRequestCard({
    super.key,
    required this.clientName,
    required this.requestDate,
    required this.requestTime,
    required this.address,
    required this.onAccept,
    required this.onDecline, // Se recibe el callback para "No Aceptar"
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              clientName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text('Ha solicitado tu servicio para el $requestDate a las $requestTime'),
            Text(address),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: onAccept,
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                TextButton(
                  onPressed:  onDecline, // Acción para "No Aceptar"
                    // Acción para no aceptar el servicio
                  
                  child: const Text(
                    'No aceptar',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Acción para enviar mensaje
                  },
                  child: const Text('Enviar mensaje'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
