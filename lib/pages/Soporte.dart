import 'package:flutter/material.dart';

class Soporte extends StatelessWidget {
  const Soporte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SOPORTE"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtítulo
            Text(
              "¿Cómo podemos ayudarte?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // Sección de Servicios
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'dd/mm/aa, 00:00',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                      Text(
                        'Nombre del proveedor',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Completado',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Tipo de servicio',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () {
                          // Acción al presionar "Otro servicio"
                        },
                        child: Text(
                          'Otro servicio >',
                          style: TextStyle(fontSize: 14, color: Colors.orange),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Sección de Temas
            Text(
              "Explora todos los temas",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Buscar...',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            // Opciones de ayuda
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    title: Text("Ayuda con un servicio"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.orange),
                    onTap: () {
                      // Acción al presionar
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Manejar mi cuenta"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.orange),
                    onTap: () {
                      // Acción al presionar
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Seguridad y emergencias"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.orange),
                    onTap: () {
                      // Acción al presionar
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("Problemas con la app"),
                    trailing: Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.orange),
                    onTap: () {
                      // Acción al presionar
                    },
                  ),
                ],
              ),
            ),

            // Botón de chat
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '¡Habla con nosotros!',
                  style: TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.chat, color: Colors.orange),
                  onPressed: () {
                    // Acción al presionar el botón de chat
                  },
                ),
              ],
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