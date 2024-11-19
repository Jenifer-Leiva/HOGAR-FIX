import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProgresoServicio extends StatefulWidget {
  const ProgresoServicio({super.key});

  @override
  _ProgresoServicioState createState() => _ProgresoServicioState();
}

class _ProgresoServicioState extends State<ProgresoServicio> {
  late String serviceId; // Variable para almacenar el serviceId

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtener el serviceId desde los argumentos de la ruta
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    if (args != null) {
      serviceId = args; // Asignar el serviceId recibido
    }
  }

// Función para actualizar el estado del servicio en Firestore
  Future<void> _updateServiceStatus(String status) async {
    try {
      await FirebaseFirestore.instance
          .collection('Servicios')
          .doc(serviceId)
          .update({'estado': status}); // Actualizar el estado en Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Estado del servicio actualizado a: $status')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el estado: $e')),
      );
    }
  }


// Variables para controlar el estado de cada botón
  bool noIniciadoSelected = false;
  bool retrasadoSelected = false;
  bool completadoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progreso del Servicio"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          // Título de la sección (Reducir el espacio)
          Padding(
            padding: const EdgeInsets.only(top: 120.0),
            child: Center(
              child: Text(
                "Servicio en curso $serviceId",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Estado del trabajo
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Estado del trabajo",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Divider(color: Colors.orange, thickness: 1),
                SizedBox(height: 16),

                // Tabla de estado
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            
                            SizedBox(width: 10),
                            Text("No iniciado", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                           
                            SizedBox(width: 8),
                            Text("Retrasado", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        SizedBox(height: 30),
                        Row(
                          children: [
                           
                            SizedBox(width: 8),
                            Text("Completado", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.radio_button_off,
                            color: noIniciadoSelected ? Colors.orange : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              noIniciadoSelected = !noIniciadoSelected;
                               _updateServiceStatus("No Iniciado");
                            });
                            Navigator.pushNamed(context, '/monitoreoservicio');
                          },
                        ),
                        SizedBox(height: 16),
                        IconButton(
                          icon: Icon(
                            Icons.radio_button_off,
                            color: retrasadoSelected ? Colors.orange : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              retrasadoSelected = !retrasadoSelected;
                               _updateServiceStatus("retrasado");
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        IconButton(
                          icon: Icon(
                            Icons.radio_button_off,
                            color: completadoSelected ? Colors.orange : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              completadoSelected = !completadoSelected;
                               _updateServiceStatus("completado");
                            });
                            Navigator.pushNamed(context, '/calificacion');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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

  // Método para construir los botones de navegación
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
