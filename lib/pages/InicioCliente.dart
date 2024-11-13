import 'package:flutter/material.dart';
import 'package:hogarfixapp/pages/HistorialServicios.dart';
import 'package:hogarfixapp/pages/PerfilCliente.dart';
import 'package:intl/intl.dart';

class InicioCliente extends StatefulWidget {
  const InicioCliente({super.key});

 @override
  _ClientProfileState createState() => _ClientProfileState();
}

class _ClientProfileState extends State<InicioCliente> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/iniciocliente');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/historialservicios');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/perfilcliente');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          InicioCliente(),
          HistorialServicios(),
          PerfilCliente(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
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
  @override
  _InicioClienteState createState() => _InicioClienteState();


class _InicioClienteState extends State<InicioCliente> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
  Set<String> selectedDays = {};
  Map<String, String> selectedTimes = {};

  String getDateForDay(String dayOfWeek) {
    final monday = getMondayOfCurrentWeek();
    DateTime selectedDate;

    switch (dayOfWeek) {
      case 'Lunes':
        selectedDate = monday;
        break;
      case 'Martes':
        selectedDate = monday.add(const Duration(days: 1));
        break;
      case 'Miércoles':
        selectedDate = monday.add(const Duration(days: 2));
        break;
      case 'Jueves':
        selectedDate = monday.add(const Duration(days: 3));
        break;
      case 'Viernes':
        selectedDate = monday.add(const Duration(days: 4));
        break;
      case 'Sábado':
        selectedDate = monday.add(const Duration(days: 5));
        break;
      case 'Domingo':
        selectedDate = monday.add(const Duration(days: 6));
        break;
      default:
        selectedDate = monday;
    }

    return DateFormat('dd/MM/yyyy').format(selectedDate);
  }

  DateTime getMondayOfCurrentWeek() {
    final now = DateTime.now();
    final weekday = now.weekday;
    return now.subtract(Duration(days: weekday - 1));
  }

  void toggleDay(String day) {
    setState(() {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
        selectedTimes.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  void setTime(String day, String time) {
    setState(() {
      selectedTimes[day] = time;
    });
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 150.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 150.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
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
               ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resultadosbusqueda'); 
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text(" buscar "),
              ),
              Row(
                children: [
                 
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
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_left),
                    onPressed: _scrollLeft,
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
                                Icon(service['icon'], color: Colors.blue, size: 50),
                                const SizedBox(height: 5),
                                Text(service['name'], style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_right),
                    onPressed: _scrollRight,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Selecciona un día de la semana",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: [
                  'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'
                ].map((day) {
                  return GestureDetector(
                    onTap: () => toggleDay(day),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 18.0),
                      decoration: BoxDecoration(
                        color: selectedDays.contains(day) ? Colors.orange : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        children: [
                          Text(day, style: TextStyle(color: selectedDays.contains(day) ? Colors.white : Colors.black)),
                          const SizedBox(height: 5),
                          Text("Fecha: ${getDateForDay(day)}", style: const TextStyle(fontSize: 12)),
                          const SizedBox(height: 5),
                          selectedDays.contains(day)
                              ? DropdownButton<String>(
                                  value: selectedTimes[day] ?? '08:00 AM',
                                  items: ['08:00 AM', '10:00 AM', '12:00 PM', '02:00 PM', '04:00 PM']
                                      .map((time) => DropdownMenuItem(value: time, child: Text(time)))
                                      .toList(),
                                  onChanged: (value) => setTime(day, value!),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_repair_service), label: 'Servicios'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Historial'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Mi perfil'),
        ],
        selectedItemColor: const Color.fromARGB(255, 255, 153, 0),
        unselectedItemColor: Colors.grey,
      ),
      
    );
  }
}
