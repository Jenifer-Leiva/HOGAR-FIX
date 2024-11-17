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
    {"name": "Plomería", "icon": Icons.water},
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
    {"name": "Desinfección y\n  fumigación", "icon": Icons.bug_report},
    {"name": "Limpieza \n de fachadas", "icon": Icons.cleaning_services},
    {"name": "Reparación de \n electrodomésticos", "icon": Icons.kitchen},
    {"name": "Instalación \n de cortinas", "icon": Icons.window},
    {"name": "Vidriería", "icon": Icons.crop_square},
    {"name": "Mudanza y \n transporte", "icon": Icons.local_shipping},
    {"name": "Sistemas \n de seguridad", "icon": Icons.security},
    {"name": "Redes y \n telecomunicaciones", "icon": Icons.wifi},
  ];

  List<Map<String, dynamic>> filteredServices = [];
  Set<String> selectedDays = {};
  Map<String, String> selectedTimes = {};
  String? selectedService;

  @override
  void initState() {
    super.initState();
    filteredServices = services;
    _searchController.addListener(_filterServices);
  }

  void _filterServices() {
    setState(() {
      final query = _searchController.text.toLowerCase();
      filteredServices = services
          .where((service) => service['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  String getDateForDay(String dayOfWeek) {
    final monday = getMondayOfCurrentWeek();
    final daysOffset = {
      'Lunes': 0,
      'Martes': 1,
      'Miércoles': 2,
      'Jueves': 3,
      'Viernes': 4,
      'Sábado': 5,
      'Domingo': 6,
    };
    final offset = daysOffset[dayOfWeek] ?? 0;
    final selectedDate = monday.add(Duration(days: offset));
    return DateFormat('dd/MM/yyyy').format(selectedDate);
  }

  DateTime getMondayOfCurrentWeek() {
    final now = DateTime.now();
    return now.subtract(Duration(days: now.weekday - 1));
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

  void selectTime(String day) {
    final List<String> availableTimes = [
      '08:00 AM',
      '09:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '01:00 PM',
      '02:00 PM',
      '03:00 PM',
      '04:00 PM',
      '05:00 PM',
    ];

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Selecciona una hora",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: availableTimes.length,
                  itemBuilder: (context, index) {
                    final time = availableTimes[index];
                    return ListTile(
                      title: Text(time),
                      onTap: () {
                        setTime(day, time);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void setTime(String day, String time) {
    setState(() {
      selectedTimes[day] = time;
    });
  }

  void searchAndSave() {
    if (selectedService != null && selectedDays.isNotEmpty) {
      final selectedServiceDetails = {
        'service': selectedService,
        'days': selectedDays.toList(),
        'times': selectedTimes,
      };

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Datos de Busqueda'),
          content: Text('Servicio: $selectedService\nDías: ${selectedDays.join(", ")}\nHorarios: ${selectedTimes.values.join(", ")}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/resultadosbusqueda', arguments: selectedServiceDetails,),
              child: Text('Buscar'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Por favor, selecciona un servicio y al menos un día con horario.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inicio Cliente")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              filteredServices.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: filteredServices.map((service) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedService = service['name'];
                              });
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                                  padding: const EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Icon(
                                    service['icon'],
                                    color: Colors.blue,
                                    size: 40.0,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  service['name'],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12.0),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    )
                  : const Text("No se encontraron resultados."),
              if (selectedService != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text("Servicio seleccionado: $selectedService"),
                    Wrap(
                      spacing: 10,
                      children: ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo']
                          .map((day) {
                        return ChoiceChip(
                          label: Text(day),
                          selected: selectedDays.contains(day),
                          onSelected: (_) => toggleDay(day),
                        );
                      }).toList(),
                    ),
                    ...selectedDays.map((day) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('$day: ${getDateForDay(day)}'),
                          Text(
                            selectedTimes[day] != null
                                ? 'Hora: ${selectedTimes[day]}'
                                : 'Hora:',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.access_time),
                            onPressed: () => selectTime(day),
                          ),
                        ],
                      );
                    }).toList(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: searchAndSave,
                      child: const Text("Buscar"),
                    ),
                  ],
                ),
                //barra navegacion  inferior
                
            ],
          ),
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
      ]
      )
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



