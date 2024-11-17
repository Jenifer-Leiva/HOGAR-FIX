import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultadosBusqueda extends StatelessWidget {
  const ResultadosBusqueda({super.key});

  // Método para construir el encabezado
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          '¡ESTOS SON LOS SERVICIOS QUE TENEMOS PARA TI!',
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

  // Método para construir la tarjeta del proveedor
  Widget _buildProviderCard(BuildContext context, String providerName) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.photo_camera, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  providerName, // Aquí se muestra el nombre del proveedor
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < 4 ? Colors.orange : Colors.grey,
                      size: 20,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Se encuentra a 0km de ti!",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            const Text(
              "dia y hora!",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 4),
            const Text(
              "\$--",
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/confirmacionservicio');
                  },
                  child: const Text(
                    "Pedir este servicio",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/detallesproveedor');
                  },
                  child: const Text(
                    "Ver detalles",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: const Text(
                    "Enviar mensaje",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    //////////////de inicio
    final Map<String, dynamic>? selectedServiceDetails =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String selectedService = selectedServiceDetails?['service'] ?? 'Ninguno';







    return Scaffold(
      appBar: AppBar(
        title: const Text("Resultados de Búsqueda"),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('Proveedores')
              .where('Servicio', isEqualTo: selectedService)
              .get(), // Realiza la consulta
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error al cargar datos"));
            }
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var providerData = snapshot.data!.docs[index];
                  String providerName = providerData['Nombre']; // Nombre del proveedor
                  return _buildProviderCard(context, providerName);
                },
              );
            } else {
              return const Center(child: Text("No se encontraron proveedores"));
            }
          },
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
