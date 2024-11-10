import 'package:flutter/material.dart';

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
              onPressed:() => Navigator.pushNamed(context, '/'),
              child: const Text("ir a inicio ")
              )
          ],
        ),
      ),
    );
  }}