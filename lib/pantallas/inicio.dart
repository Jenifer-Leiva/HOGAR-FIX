import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Inicio extends StatelessWidget{
  const Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("inicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => context.go('/pagina'), 
              child: const Text("ir a pagina 2")
              )
          ],
        ),
      ),
    );
  }}