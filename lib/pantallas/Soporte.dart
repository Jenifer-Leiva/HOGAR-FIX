import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Soporte extends StatelessWidget{
  const Soporte({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Soporte"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/inicio'), 
              child: const Text("ir a inicio ")
              )
          ],
        ),
      ),
    );
  }}