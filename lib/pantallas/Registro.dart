import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Registro extends StatelessWidget{
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/PerfilCliente'), 
              child: const Text("ir a PerfilCliente ")
              ),
              ElevatedButton(
              onPressed:() => context.go('/PerfilProveedor'), 
              child: const Text("ir a PerfilProveedor ")
              )
          ],
        ),
      ),
    );
  }}