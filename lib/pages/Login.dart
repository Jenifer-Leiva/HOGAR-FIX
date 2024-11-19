import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseFirestore baseDatos = FirebaseFirestore.instance;

  Future<void> iniciarSesion() async {
    String email = emailController.text;
    String password = passwordController.text;

    try {
      // Verificar en la colección Proveedores
      QuerySnapshot proveedores = await baseDatos
          .collection('Proveedores')
          .where('Correo', isEqualTo: email)
          .where('Contraseña', isEqualTo: password)
          .get();

      if (proveedores.docs.isNotEmpty) {
        String proveedorId = proveedores.docs.first.id;
        await _guardarDatosUsuario(proveedorId, 'Proveedor');
        Navigator.pushNamed(context, '/perfilproveedor');
        return;
      }

      // Verificar en la colección Clientes
      QuerySnapshot clientes = await baseDatos
          .collection('Clientes')
          .where('Correo', isEqualTo: email)
          .where('Contraseña', isEqualTo: password)
          .get();

      if (clientes.docs.isNotEmpty) {
        String clienteId = clientes.docs.first.id;
        await _guardarDatosUsuario(clienteId, 'Cliente');
        Navigator.pushNamed(context, '/perfilcliente');
        return;
      }

      // Si no encuentra coincidencias en ninguna colección
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: const Text("Credenciales incorrectas"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      print("Error: $e");
      // Manejo de errores opcional
    }
  }

  Future<void> _guardarDatosUsuario(String userId, String userType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // Guardar el userId y userType en SharedPreferences
  if (userType == 'Proveedor') {
  await prefs.setString('providerUserId', userId);
} else if (userType == 'Cliente') {
  await prefs.setString('userIdCliente', userId);
}

    if (userType == 'Proveedor') {
      // Si es un proveedor, obtenemos datos adicionales de la colección 'Proveedores'
      try {
        DocumentSnapshot proveedorSnapshot = await baseDatos.collection('Proveedores').doc(userId).get();

        if (proveedorSnapshot.exists) {
          // Guardamos información adicional del proveedor en SharedPreferences (por ejemplo, nombre y correo)
          String nombreProveedor = proveedorSnapshot['Nombre'] ?? '';
          String correoProveedor = proveedorSnapshot['Correo'] ?? '';

          await prefs.setString('nombreProveedor', nombreProveedor);
          await prefs.setString('correoProveedor', correoProveedor);
        }
      } catch (e) {
        print("Error al obtener datos del proveedor: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "HOGAR FIX",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "¡HOLA!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Usuario',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'Contraseña',
                filled: true,
                fillColor: Colors.grey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/cambiocontraseña');
                },
                child: const Text(
                  "¿Olvidaste tu contraseña?",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.orangeAccent, width: 2),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 100, vertical: 15),
              ),
              onPressed: iniciarSesion,
              child: const Text(
                "Iniciar sesión",
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("¿Usuario nuevo? ",
                    style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/registro');
                  },
                  child: const Text(
                    "Regístrate",
                    style: TextStyle(color: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
