import 'package:flutter/material.dart';

class CambioContrasenia extends StatelessWidget {
  const CambioContrasenia({super.key});

  @override
  Widget build(BuildContext context) {
    return const CambiarContrasenaScreen();
  }
}

class CambiarContrasenaScreen extends StatelessWidget {
  const CambiarContrasenaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Cambia contraseña 2',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '¡HOLA!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Cambia tu contraseña de forma segura',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Campos de entrada de texto
            const TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña actual',
                labelStyle: TextStyle(color: Colors.orange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Contraseña nueva',
                labelStyle: TextStyle(color: Colors.orange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Verifica la contraseña nueva',
                labelStyle: TextStyle(color: Colors.orange),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            // Nota de requisitos de contraseña
            const Text(
              'La contraseña debe contener los siguientes parámetros:\n'
              '- Mín 8 caracteres\n'
              '- Mayúscula y minúscula\n'
              '- 1 símbolo (!, #, %, &)',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Spacer(),
            // Botón guardar
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                  // Acción de guardar o cualquier otra operación que quieras realizar
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Guardar'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
     
    );
  }
}
