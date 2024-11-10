import 'package:flutter/material.dart';

class ResultadosBusqueda extends StatelessWidget{
  const ResultadosBusqueda({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ResultadosBusqueda"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/detallesproveedor'),
              child: const Text("ir a detallesproveedor ")
              )
          ],
        ),
      ),
    );
  }}