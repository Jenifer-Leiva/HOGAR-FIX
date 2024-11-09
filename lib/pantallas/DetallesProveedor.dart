import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetallesProveedor extends StatelessWidget{
  const DetallesProveedor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DetallesProveedor"),
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