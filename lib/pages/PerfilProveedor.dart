import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PerfilProveedor extends StatelessWidget{
  const PerfilProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PerfilProveedor"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/EditarPerfilProveedor'), 
              child: const Text("ir a EditarPerfilProveedor ")
              )
          ],
        ),
      ),
    );
  }}