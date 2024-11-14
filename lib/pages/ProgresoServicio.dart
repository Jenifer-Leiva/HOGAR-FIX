import 'package:flutter/material.dart';

class ProgresoServicio extends StatefulWidget {
  const ProgresoServicio({super.key});

  @override
  _MonitoreoServicioState createState() => _MonitoreoServicioState();
}

class _MonitoreoServicioState extends State<ProgresoServicio> {
  // Variables para controlar el estado de cada botón
  bool noIniciadoSelected = false;
  bool retrasadoSelected = false;
  bool completadoSelected = false;

  bool noIniciadoXSelected = false;
  bool retrasadoXSelected = false;
  bool completadoXSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Progreso del Servicio"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          // Título de la sección
          Expanded(
            child: Center(
              child: Text(
                "Servicio en curso",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Estado del trabajo
          Expanded(
            child: Column(
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
                SizedBox(height: 8),

                // Tabla de estado
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("No iniciado", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                          Text("Retrasado", style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                          Text("Completado", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Botones circulares para los estados
                          IconButton(
                            icon: Icon(Icons.radio_button_off,
                                color: noIniciadoSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                               
                                noIniciadoSelected = !noIniciadoSelected;
                              }
                              );
                               Navigator.pushNamed(context, '/monitoreoservicio');
                            },
                          ),
                          SizedBox(height: 16),
                          IconButton(
                            icon: Icon(Icons.radio_button_off,
                                color: retrasadoSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                                retrasadoSelected = !retrasadoSelected;
                                
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          IconButton(
                            icon: Icon(Icons.radio_button_off,
                                color: completadoSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                                completadoSelected = !completadoSelected;
                              });
                            },
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Botones "X" para los estados
                          IconButton(
                            icon: Icon(Icons.close,
                                color: noIniciadoXSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                                noIniciadoXSelected = !noIniciadoXSelected;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          IconButton(
                            icon: Icon(Icons.close,
                                color: retrasadoXSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                                retrasadoXSelected = !retrasadoXSelected;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          IconButton(
                            icon: Icon(Icons.close,
                                color: completadoXSelected
                                    ? Colors.orange
                                    : Colors.grey),
                            onPressed: () {
                              setState(() {
                                completadoXSelected = !completadoXSelected;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Pregunta de utilidad
          Expanded(
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "¿El servicio fue de utilidad?",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Acción al presionar "Sí"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: Text("Sí"),
                        ),
                        SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Acción al presionar "No"
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      
    );
  }
}