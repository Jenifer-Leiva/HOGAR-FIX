import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              onPressed:() => context.go('/ConfirmacionServicio'), 
              child: const Text("ir a ConfirmacionServicio ")
              )
          ],
        ),
      ),
    );
  }}