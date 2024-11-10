import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InicioCliente extends StatefulWidget {
  const InicioCliente({super.key});

  @override
  _InicioClienteState createState() => _InicioClienteState();
}

class _InicioClienteState extends State<InicioCliente> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> services = [
    {"name": "Electricidad", "icon": Icons.electrical_services},
    {"name": "Carpintería", "icon": Icons.chair},
    {"name": "Pintura", "icon": Icons.format_paint},
    {"name": "Albañilería", "icon": Icons.build},
    {"name": "Cerrajería", "icon": Icons.lock},
    {"name": "Jardinería", "icon": Icons.grass},
    {"name": "Impermeabilización", "icon": Icons.roofing},
    {"name": "Herrería", "icon": Icons.construction},
    {"name": "Aire acondicionado", "icon": Icons.ac_unit},
    {"name": "Limpieza de cisternas", "icon": Icons.water_damage},
    {"name": "Fontanería", "icon": Icons.plumbing},
    {"name": "Desinfección y fumigación", "icon": Icons.bug_report},
    {"name": "Limpieza de fachadas", "icon": Icons.cleaning_services},
    {"name": "Reparación de electrodomésticos", "icon": Icons.kitchen},
    {"name": "Instalación de cortinas", "icon": Icons.window},
    {"name": "Vidriería", "icon": Icons.crop_square},
    {"name": "Mudanza y transporte", "icon": Icons.local_shipping},
    {"name": "Sistemas de seguridad", "icon": Icons.security},
    {"name": "Redes y telecomunicaciones", "icon": Icons.wifi},
  ];
  

  final ScrollController _scrollController = ScrollController();

  // Estado para manejar los días seleccionados
  Set<String> selectedDays = Set();

  // Estado para las horas seleccionadas por día
  Map<String, String> selectedTimes = {};

  // Obtener la fecha actual
  String getCurrentDate() {
    final now = DateTime.now();
    return "${now.day}/${now.month}/${now.year}";
  }

  // Función para obtener la fecha del lunes de la semana actual
  DateTime getMondayOfCurrentWeek() {
    final now = DateTime.now();
    final weekday = now.weekday;
    return now.subtract(Duration(days: weekday - 1));
  }

  // Obtener la fecha de un día específico de la semana
  String getDateForDay(String dayOfWeek) {
    final monday = getMondayOfCurrentWeek();
    DateTime selectedDate;

    switch (dayOfWeek) {
      case 'Lunes':
        selectedDate = monday;
        break;
      case 'Martes':
        selectedDate = monday.add(Duration(days: 1));
        break;
      case 'Miércoles':
        selectedDate = monday.add(Duration(days: 2));
        break;
      case 'Jueves':
        selectedDate = monday.add(Duration(days: 3));
        break;
      case 'Viernes':
        selectedDate = monday.add(Duration(days: 4));
        break;
      case 'Sábado':
        selectedDate = monday.add(Duration(days: 5));
        break;
      case 'Domingo':
        selectedDate = monday.add(Duration(days: 6));
        break;
      default:
        selectedDate = monday;
    }

    return DateFormat('dd/MM/yyyy').format(selectedDate);
  }

  // Mover los íconos hacia la derecha
  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150.0, // Aumentamos el desplazamiento
      duration: const Duration(milliseconds: 300), // Desplazamiento más rápido
      curve: Curves.easeInOut,
    );
  }

  // Mover los íconos hacia la izquierda
  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150.0, // Aumentamos el desplazamiento
      duration: const Duration(milliseconds: 300), // Desplazamiento más rápido
      curve: Curves.easeInOut,
    );
  }

  // Cambiar el estado de un día (marcar o desmarcar)
  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
        selectedTimes.remove(day); // Eliminar la hora seleccionada si se desmarca el día
      } else {
        selectedDays.add(day);
      }
    });
  }

  // Establecer la hora seleccionada para un día
  void setTime(String day, String time) {
    setState(() {
      selectedTimes[day] = time;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inicio Cliente"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Row(
                children: [
                  ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/resultadosbusqueda'),
              child: const Text("ir a resultados de la busqueda ")
              ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      print('Volver');
                    },
                  ),
                  const Text("Ubicación: Ciudad de México"),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Buscar servicio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Barra horizontal con flechas para el desplazamiento
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: _scrollLeft, // Desplaza hacia la izquierda
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      controller: _scrollController,
                      child: Row(
                        children: services.map((service) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  service['icon'],
                                  color: Colors.blue,
                                  size: 50, // Tamaño de los íconos
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  service['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: _scrollRight, // Desplaza hacia la derecha
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Esquema de horario
              const Text(
                "Selecciona un día de la semana",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),

              // Contenedor de días
              Wrap(
                spacing: 10.0, // Espacio entre los botones
                runSpacing: 10.0, // Espacio entre las filas
                children: [
                  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
                ].map((day) {
                  return GestureDetector(
                    onTap: () => toggleDay(day), // Cambia el estado al tocar el día
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                      decoration: BoxDecoration(
                        color: selectedDays.contains(day) ? Colors.orange : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Text(
                            day,
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedDays.contains(day) ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Fecha: ${getDateForDay(day)}",
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 5),
                          selectedDays.contains(day)
                              ? DropdownButton<String>(
                                  value: selectedTimes[day] ?? '08:00 AM',
                                  items: ['08:00 AM', '10:00 AM', '12:00 PM', '02:00 PM', '04:00 PM']
                                      .map((String time) {
                                    return DropdownMenuItem<String>(
                                      value: time,
                                      child: Text(time),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setTime(day, value!);
                                  },
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
