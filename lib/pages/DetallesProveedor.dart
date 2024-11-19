import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetallesProveedor extends StatelessWidget {
  const DetallesProveedor({super.key});

 Future<Map<String, String>> _getProviderDetails(String providerUserId) async {
    try {
      // Consultar el proveedor usando el userId
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('Proveedores').doc(providerUserId).get();
      if (doc.exists) {
        // Devolver el nombre del proveedor y servicio
        String nombre = doc['Nombre'] ?? 'Nombre no disponible';
        String servicio = doc['Servicio'] ?? 'Servicio no disponible';
        return {'Nombre': nombre, 'Servicio': servicio};
      } else {
        return {'Nombre': 'Proveedor no encontrado', 'Servicio': 'Servicio no disponible'};
      }
    } catch (e) {
      print("Error al obtener los detalles del proveedor: $e");
      return {'Nombre': 'Error al cargar nombre', 'Servicio': 'Error al cargar servicio'};
    }
  }


  Future<Map<String, dynamic>> _getProviderDataFromSharedPrefs(String providerUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? precio = prefs.getString('${providerUserId}_precio');
    Map<String, String> diasYHoras = {};
    List<String> dias = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];

    for (String dia in dias) {
      String? hora = prefs.getString('${providerUserId}_$dia');
      if (hora != null && hora.isNotEmpty) {
        diasYHoras[dia] = hora;
      }
    }

    return {
      'Precio': double.parse(precio ?? '0.0'),
      'Horarios': diasYHoras,
    };
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el userId pasado como argumento
    final String? providerUserId = ModalRoute.of(context)?.settings.arguments as String?;

    // Verificar si userId es nulo
    if (providerUserId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Detalles del Proveedor"),
          backgroundColor: Colors.orange,
        ),
        body: const Center(
          child: Text('No se proporcionó un ID de proveedor'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del Proveedor"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<Map<String, String>>(
         future: _getProviderDetails(providerUserId),  // Llamar al método para obtener los detalles del proveedor
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return const Center(child: Text("Error al cargar los datos"));
            }

           final providerName = snapshot.data?['Nombre'] ?? 'Sin nombre';
            final providerService = snapshot.data?['Servicio'] ?? 'Sin servicio';

            return FutureBuilder<Map<String, dynamic>>(
              future: _getProviderDataFromSharedPrefs(providerUserId),  // Obtener el precio y horarios del proveedor
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text("Error al cargar los datos"));
                }

                final providerData = snapshot.data ?? {};
                final providerPrice = providerData['Precio'] as double;
                final providerDayAndTime = providerData['Horarios'] as Map<String, String>? ?? {};

                // Formatear horarios
                String formattedSchedule = providerDayAndTime.entries.map((entry) {
                  return "${entry.key}: ${entry.value}";
                }).join(' , ');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Encabezado con imagen
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.camera_alt, size: 50, color: Colors.white),
                          SizedBox(height: 8),
                          Text(
                            providerName,  // Mostrar el nombre del proveedor
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < 4 ? Icons.star : Icons.star_border,
                                color: Colors.white,
                                size: 20,
                              );
                            }),
                          ),
                          Text(
                            '0 calificaciones',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),

                    // Descripción del servicio y dirección
                    Text(
                      'Dirección',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Descripción del servicio: $providerService',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Documentos
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(Icons.file_copy, size: 40, color: Colors.orange),
                            SizedBox(height: 8),
                            Text(
                              'Hoja de Vida',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(Icons.verified, size: 40, color: Colors.orange),
                            SizedBox(height: 8),
                            Text(
                              'Certificación',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Información adicional
                    Text(
                      'Precio estimado: \$${providerPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    Text(
                      'El tiempo de respuesta promedio es de 0 minutos',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 16),

                    // Horarios disponibles
                    Text(
                      'Estos son mis Horarios disponibles:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      formattedSchedule,
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: [
                        Chip(
                          label: Text("Lunes"),
                          backgroundColor: Colors.orange.shade100,
                        ),
                        Chip(
                          label: Text("Martes"),
                          backgroundColor: Colors.orange.shade100,
                        ),
                        Chip(
                          label: Text("Jueves"),
                          backgroundColor: Colors.orange.shade100,
                        ),
                        Chip(
                          label: Text("Viernes"),
                          backgroundColor: Colors.orange.shade100,
                        ),
                        Chip(
                          label: Text("Domingo"),
                          backgroundColor: Colors.orange.shade100,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Botón de navegación
                    
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
