import 'package:flutter/material.dart';

class InicioProveedor extends StatelessWidget {
  const InicioProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ServiceProviderHomePage(),
    );
  }
}

class ServiceProviderHomePage extends StatelessWidget {
   ServiceProviderHomePage({super.key});

  // Lista de datos simulados para las solicitudes de servicio
  final List<Map<String, String>> serviceRequests = [
    {
      "clientName": "Juan Pérez",
      "requestDate": "12/11/2024",
      "requestTime": "10:30 AM",
      "address": "Calle Falsa 123"
    },
    {
      "clientName": "María Gómez",
      "requestDate": "13/11/2024",
      "requestTime": "03:00 PM",
      "address": "Avenida Siempreviva 742"
    },
    {
      "clientName": "Carlos Martínez",
      "requestDate": "14/11/2024",
      "requestTime": "09:00 AM",
      "address": "Calle Primavera 456"
    },
  ];

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

 ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/monitoreoservicio'),
              child: const Text("ir a monitoreoservicio ")
              ),
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
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: serviceRequests.length,
              itemBuilder: (context, index) {
                final request = serviceRequests[index];
                return ServiceRequestCard(
                  clientName: request["clientName"]!,
                  requestDate: request["requestDate"]!,
                  requestTime: request["requestTime"]!,
                  address: request["address"]!,
                );
              },
            ),
          ),
        ],
      ),
            
      // Barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
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

class ServiceRequestCard extends StatelessWidget {
  final String clientName;
  final String requestDate;
  final String requestTime;
  final String address;

  const ServiceRequestCard({
    super.key,
    required this.clientName,
    required this.requestDate,
    required this.requestTime,
    required this.address,
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
                  onPressed: () {
                    // Acción para aceptar el servicio
                  },
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Acción para no aceptar el servicio
                  },
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