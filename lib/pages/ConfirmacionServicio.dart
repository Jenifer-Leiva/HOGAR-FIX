import 'package:flutter/material.dart';

class ConfirmacionServicio extends StatelessWidget {
  const ConfirmacionServicio({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/calificacion'),
              child: const Text("ir a calificacion ")
              ),
            const SizedBox(height: 5),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: 10),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildServiceDetails(),
            const Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Lógica para iniciar chat
        },
        backgroundColor: Colors.orange,
        child: const Icon(Icons.chat),
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
        currentIndex: 1, // Indica que "Historial" está seleccionado
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
          '¡Tu servicio ha sido aceptado por el\nproveedor!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildServiceDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.person, color: Colors.black),
              SizedBox(width: 8),
              Text(
                'Nombre del proveedor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Tipo de servicio',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'El proveedor llegará el dd/mm/aa',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'La franja horaria elegida fue de 00:00 a 00:00',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'El precio estimado por hora es de \$--',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'Recuerda que esto es un estimado, el precio puede variar dependiendo de la consideración del proveedor. Si tienes dudas respecto al precio final, por favor contacta al proveedor.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Lógica para volver
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.orange, backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.orange),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Volver',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Lógica para cancelar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}