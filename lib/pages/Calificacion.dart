import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Calificacion extends StatelessWidget{
  const Calificacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calificacion"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/historialservicios'),
              child: const Text("ir a HistorialServicios ")
              )
          ],
        ),
      ),
    );
  }}