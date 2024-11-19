import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultadosBusqueda extends StatelessWidget {
  const ResultadosBusqueda({super.key});

  // Método para construir la tarjeta del proveedor
  Widget _buildProviderCard(
      BuildContext context, String providerName, String diasYHoras, double price,  dynamic providerUserId, ) {
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
                  providerName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
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
            Text(
  "Horarios:\n ${diasYHoras.toString()}",
  style: const TextStyle(color: Colors.black54),
),
            
            const SizedBox(height: 4),
            Text(
              "precio: \$${price.toStringAsFixed(2)}",
              style: const TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
 TextButton(
  onPressed: () async {
    // Mostrar un Snackbar de espera
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Esperando respuesta del proveedor..."),
        duration: Duration(seconds: 3),  // Duración del mensaje
      ),
    );

    // Obtener el userId del cliente
    String userIdCliente = await _getUserIdCliente();
    
    // Guardar el providerUserId en SharedPreferences
    final providerUserId = providerName;  // Utilizamos el nombre como el userId del proveedor
    await _guardarUserIdEnSharedPrefs(providerUserId);  // Guardamos el userId del proveedor
    
    // Guardar el userId del cliente en una lista en SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Recuperar la lista de userIds ya almacenados
    List<String> userIds = prefs.getStringList('userIdsCliente') ?? [];
    
    // Si no existe el userId del cliente en la lista, lo agregamos
    if (!userIds.contains(userIdCliente)) {
      userIds.add(userIdCliente);
    }
    
    // Guardamos la lista actualizada de userIds
    await prefs.setStringList('userIdsCliente', userIds);

    // Navegar a la pantalla de inicio del cliente sin pasar la información directamente
    Navigator.pushNamed(
      context, 
      '/iniciocliente',  // Solo navegas al inicio del cliente
    );
  },
  child: const Text(
    "Pedir este servicio",
    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
  ),
),




                
     TextButton(
  onPressed: () async {
    
    Navigator.pushNamed(
      context, 
      '/detallesproveedor', 
      arguments: providerUserId,  // Pasamos el userId como argumento
    );
  },
  child: const Text(
    "Ver detalles",
    style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
  ),
),










                TextButton(
                  onPressed: () async {
                    final providerUserId = providerName;  // Utilizamos el nombre como el userId del proveedor
                    await _guardarUserIdEnSharedPrefs(providerUserId);  // Guardamos el userId
                    Navigator.pushNamed(context, '/chat');
                  },
                  child: const Text(
                    "Enviar mensaje",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para obtener proveedores según el servicio seleccionado
  Future<List<Map<String, dynamic>>> _getProveedoresPorServicio(String service) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Proveedores')
          .where('Servicio', isEqualTo: service)
          .get();

      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return {
          'Nombre': data['Nombre'] ?? 'Sin nombre',
          'Precio': data['Precio'] ?? 0.0,
          'providerUserId': doc.id,  // Obtenemos el ID del documento en Firestore como el userId
        };
      }).toList();
    } catch (e) {
      print("Error al obtener proveedores: $e");
      return [];
    }
  }

  // Método para obtener datos de SharedPreferences (precio, horarios)
  Future<Map<String, dynamic>> _getProviderDataFromSharedPrefs(String providerUserId) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? selectedService = prefs.getString('${providerUserId}_selectedService');
  String? precio = prefs.getString('${providerUserId}_precio');

  // Crear un mapa para almacenar los días y sus horarios
  Map<String, String> diasYHoras = {};
  List<String> dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

  // Obtener los horarios por cada día
 for (String dia in dias) {
    String? hora = prefs.getString('${providerUserId}_$dia');
    if (hora != null && hora.isNotEmpty) {
      diasYHoras[dia] = hora;  // Solo agregamos días con horario disponible
    }
  }

  return {
    'Servicio': selectedService ?? 'Ninguno',
    'Precio': double.parse(precio ?? '0.0'),
    'Horarios': diasYHoras,  // Devolver todos los días y horarios
  };
}
  // Método para guardar el userId en SharedPreferences
  Future<void> _guardarUserIdEnSharedPrefs(String providerUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('providerUserId', providerUserId);  // Guardamos el userId del proveedor
  }

// Método para guardar el userId  cliente en SharedPreferences
Future<String> _getUserIdCliente() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('userIdCliente') ?? '';  // Devuelve un string vacío si no se encuentra
}















  // Método para construir el botón de la barra de navegación inferior
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

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder<List<Map<String, dynamic>>>(  // FutureBuilder para obtener los proveedores
          future: _getProveedoresPorServicio(selectedService),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error al cargar los datos"));
            }

            final proveedores = snapshot.data ?? [];
            if (proveedores.isEmpty) {
              return const Center(child: Text("No se encontraron proveedores para este servicio."));
            }

            return ListView.builder(
              itemCount: proveedores.length,
              itemBuilder: (context, index) {
                final proveedor = proveedores[index];
                final providerUserId = proveedor['providerUserId'] as String;  // Obtenemos el userId del proveedor (doc.id de Firestore)

                return FutureBuilder<Map<String, dynamic>>(
                  future: _getProviderDataFromSharedPrefs(providerUserId),
                  builder: (context, prefsSnapshot) {
                    if (prefsSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (prefsSnapshot.hasError) {
                      return const Center(child: Text("Error al cargar los datos del proveedor"));
                    }

                    final providerData = prefsSnapshot.data ?? {};
final providerPrice = providerData['Precio'] as double;
final providerDayAndTime = providerData['Horarios'] as Map<String, String>? ?? {}; // Asignar un mapa vacío si es null

// Si 'Horarios' está presente y tiene el tipo correcto, entonces procesamos los días y horas.
String formattedSchedule = providerDayAndTime.entries.map((entry) {
  return "${entry.key}: ${entry.value}";  // Combina el día y la hora
}).join(' , ');  // Une los horarios con saltos de línea

return _buildProviderCard(
  context,
  proveedor['Nombre'] as String,
  formattedSchedule,
  providerPrice, 
  providerUserId, // Utilizamos el precio desde SharedPreferences
    // Pasamos el horario formateado a la tarjeta
);

                  },
                );
              },
            );
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
