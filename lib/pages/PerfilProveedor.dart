import 'package:flutter/material.dart';

class PerfilProveedor extends StatelessWidget {
  const PerfilProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
             ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/monitoreoservicio'),
              child: const Text("ir a InicioProveedor ")
              ),
            // Sección de Foto de Perfil
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

            // Nombre del Proveedor
            const Text(
              "Nombre",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

           // Sección de Información Personal
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Información personal"),
                  const SizedBox(height: 10),
                  const Text("Correo\nDireccion\nCelular", style: TextStyle(color: Colors.black,fontSize: 20)),
          
            // Sección de Acerca del Servicio               
                  _buildSectionTitle("Acerca de tu servicio"),
                 const Text("Servicio\nDescripcion", style: TextStyle(color: Colors.black,fontSize: 18)),
                 const SizedBox(height: 10),

                  // Sección de Horarios
                  _buildSectionTitle("Tus horarios"),
                  const SizedBox(height: 10),
                  _buildDropdownTimeIntervals(),

                  //Certificaciones
                  const SizedBox(height: 10),
                  _buildSectionTitle("Tus certificaciones"),
                  const Text("Hoja de vida"),
                  const Text("Certificación técnica"),

                  //Precio
                  const SizedBox(height: 10),
                  _buildSectionTitle("Tu precio estimado"),
                  const Text("\$ --- por hora"),

                  const Divider(color: Colors.orange, thickness: 1),

                  // Opciones adicionales
                  const SizedBox(height: 10),
                  const Text("Soporte", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  const Text("Cerrar sesión", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 5),
                  const Text("Eliminar cuenta", style: TextStyle(color: Colors.grey)),

                  const SizedBox(height: 20),

                  // Botón Editar Información
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
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
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Método auxiliar para construir títulos de sección
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

  // Método para construir los desplegables de intervalos de horas para cada día
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
                    onChanged: (value) {
                      // Acción cuando se selecciona un intervalo
                    },
                  ),
          ],
        );
      }).toList(),
    );
  }
}
