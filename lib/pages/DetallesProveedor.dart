import 'package:flutter/material.dart';

class DetallesProveedor extends StatelessWidget {
  const DetallesProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalles del Proveedor"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                    'Nombre del proveedor',
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
                'Descripción del servicio',
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
              'El precio estimado es de \$--',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            Text(
              'El tiempo de respuesta promedio es de 0 minutos',
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 16),

            // Horarios disponibles
            Text(
              '¡Estos son mis horarios disponibles, elige el que más te guste!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
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
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/confirmacionservicio'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
              ),
              child: const Text("Ir a Confirmación de Servicio"),
            ),
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
        selectedItemColor: Colors.orange,
      ),
    );
  }
}