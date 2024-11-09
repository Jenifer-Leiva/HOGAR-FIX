import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InicioCliente extends StatelessWidget{
  const InicioCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("InicioCliente"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/ResultadosBusqueda'), 
              child: const Text("ir a ResultadosBusqueda ")
              )
          ],
        ),
      ),
    );
  }}