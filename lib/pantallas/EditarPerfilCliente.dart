import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditarPerfilCliente extends StatelessWidget{
  const EditarPerfilCliente({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditarPerfilCliente"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/InicioCliente'), 
              child: const Text("ir a InicioCliente ")
              )
          ],
        ),
      ),
    );
  }}