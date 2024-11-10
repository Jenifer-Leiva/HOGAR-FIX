import 'package:flutter/material.dart';

class CambioContrasenia extends StatelessWidget{
  const CambioContrasenia({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CambioContraseña"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/'),
              child: const Text("Cambiar contraseña ")
              )
          ],
        ),
      ),
    );
  }}