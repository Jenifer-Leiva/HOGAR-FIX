import 'package:flutter/material.dart';
import 'package:hogarfixapp/pages/HistorialServicios.dart';
import 'package:hogarfixapp/pages/InicioProveedor.dart';

class PerfilProveedor extends StatefulWidget {
  const PerfilProveedor({super.key});

  @override
  _ProveeProfileState createState() => _ProveeProfileState();
}

class _ProveeProfileState extends State<PerfilProveedor> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/inicioproveedor');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/historialservicios');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/perfilproveedor');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          InicioProveedor(),
          HistorialServicios(),
          PerfilClienteContent(),
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
        selectedItemColor: Color.fromARGB(255, 255, 153, 0),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class PerfilClienteContent extends StatelessWidget {
  const PerfilClienteContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/monitoreoservicio'),
              child: const Text("ir a InicioProveedor"),
            ),
            Container(
              color: Colors.orange,
              padding: const EdgeInsets.all(40),
              child: const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.orange,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Nombre",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Información personal"),
                  const SizedBox(height: 10),
                  const Text("Correo\nDireccion\nCelular", style: TextStyle(color: Colors.black, fontSize: 20)),
                  _buildSectionTitle("Acerca de tu servicio"),
                  const Text("Servicio\nDescripcion", style: TextStyle(color: Colors.black, fontSize: 18)),
                  const SizedBox(height: 10),
                  _buildSectionTitle("Tus horarios"),
                  const SizedBox(height: 10),
                  _buildDropdownTimeIntervals(),
                  const SizedBox(height: 10),
                  _buildSectionTitle("Tus certificaciones"),
                  const Text("Hoja de vida"),
                  const Text("Certificación técnica"),
                  const SizedBox(height: 10),
                  _buildSectionTitle("Tu precio estimado"),
                  const Text("\$ --- por hora"),
                  const Divider(color: Colors.orange, thickness: 1),
                  const SizedBox(height: 10),
                  const Text("Soporte", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  const Text("Cerrar sesión", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  const Text("Eliminar cuenta", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/editarperfilproveedor');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Editar info"),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Colors.orange, thickness: 1)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          const Expanded(child: Divider(color: Colors.orange, thickness: 1)),
        ],
      ),
    );
  }

  Widget _buildDropdownTimeIntervals() {
    const timeIntervals = [
      "7:00 - 8:00 am",
      "8:00 - 9:00 am",
      "9:00 - 10:00 am",
      "10:00 - 11:00 am",
      "11:00 - 12:00 pm",
      "12:00 - 1:00 pm",
      "1:00 - 2:00 pm",
      "2:00 - 3:00 pm",
      "3:00 - 4:00 pm",
      "4:00 - 5:00 pm"
    ];

    const days = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo"];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: days.map((day) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              day,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            day == "Domingo"
                ? Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "No disponible",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )
                : DropdownButton<String>(
                    hint: const Text("Horarios disponibles"),
                    items: timeIntervals.map((interval) {
                      return DropdownMenuItem(
                        value: interval,
                        child: Text(interval),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
          ],
        );
      }).toList(),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  final String text;

  const PlaceholderWidget({required this.color, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
