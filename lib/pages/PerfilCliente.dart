import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilCliente extends StatelessWidget{
  const PerfilCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PerfilCliente"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/EditarPerfilCliente'), 
              child: const Text("ir a EditarPerfilCliente ")
              )
          ],
        ),
      ),
    );
  }}