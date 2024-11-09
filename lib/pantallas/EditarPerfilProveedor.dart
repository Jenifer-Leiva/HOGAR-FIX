import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditarPerfilProveedor extends StatelessWidget{
  const EditarPerfilProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditarPerfilProveedor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/InicioProveedor'), 
              child: const Text("ir a InicioProveedor ")
              )
          ],
        ),
      ),
    );
  }}