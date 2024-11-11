import 'package:flutter/material.dart';


class HistorialServicios extends StatelessWidget {
  const HistorialServicios({super.key});
  
  BuildContext? get context => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/cancelacionservicio'),
              child: const Text("ir a cancelacion servicio ")
              ),
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildServiceHistory(),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
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
        currentIndex: 1, // El índice 1 indica que "Historial" está seleccionado
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Text(
          'Mis servicios',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceHistory() {
    return Column(
      children: List.generate(5, (index) => _buildServiceCard(index)),
    );
  }

  Widget _buildServiceCard(int index) {
    bool inProgress = index == 0; // Solo el primer servicio está en proceso
    return Card(
      color: Colors.orange[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'dd/mm/aa, 00:00',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Nombre proveedor',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  inProgress ? 'En proceso' : 'Completado',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                  ),
                ),
                if (inProgress)
                  GestureDetector(
                    onTap: () {
                      // Aquí se puede agregar la lógica para cancelar el servicio
                      ScaffoldMessenger.of(context!).showSnackBar(
                        const SnackBar(content: Text('Servicio cancelado')),
                      );
                    },
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              'Tipo de servicio',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}