import 'package:flutter/material.dart';
import 'package:hogarfixapp/services/firebase_services.dart';

class AddRegistro extends StatefulWidget {
  const AddRegistro({super.key});

  @override
  State<AddRegistro> createState() => _AddRegistroState();
}

class _AddRegistroState extends State<AddRegistro> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "¡BIENVENIDO!",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.facebook, color: Colors.white),
              label: Text("Registrate con Facebook"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                // Acción para registro con Facebook
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: Icon(Icons.g_mobiledata, color: Colors.white),
              label: Text("Registrate con Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                // Acción para registro con Google
              },
            ),
            const SizedBox(height: 20),
            const Text(
              "O hazlo manual:",
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Nombre',
                filled: true,
                fillColor: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                hintText: 'Celular',
                filled: true,
                fillColor: Colors.grey,
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Correo electrónico',
                filled: true,
                fillColor: Colors.grey,
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
                suffixIcon: Icon(Icons.info_outline),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 5),
            Text(
              "La contraseña debe contener:\n- Min 8 caracteres\n- 1 mayúscula y 1 minúscula\n- 1 símbolo (L, ?, &, etc.)",
              style: TextStyle(fontSize: 12, color: Colors.orange),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    // Acción para registro como Proveedor
                    await addUsuarios(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text, // Añadir la contraseña
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("PROVEEDOR"),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () async {
                    // Acción para registro como Cliente
                    await addUsuariosClientes(
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text, // Añadir la contraseña
                    ).then((_) {
                      Navigator.pop(context);
                    });
                  },
                  child: const Text("CLIENTE"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Acción para ir a Iniciar Sesión
              },
              child: const Text(
                "Ya tienes una cuenta? Inicia sesión",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
