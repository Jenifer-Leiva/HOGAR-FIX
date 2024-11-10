import 'package:flutter/material.dart';

class HistorialServicios extends StatelessWidget{
  const HistorialServicios({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HistorialServicios"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() =>Navigator.pushNamed(context, '/soporte'),
              child: const Text("ir a Soporte ")
              )
          ],
        ),
      ),
    );
  }}