import 'package:flutter/material.dart';

class InicioProveedor extends StatelessWidget{
  const InicioProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InicioProveedor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/detallesproveedor'),
              child: const Text("ir a DetallesProveedor ")
              )
          ],
        ),
      ),
    );
  }}