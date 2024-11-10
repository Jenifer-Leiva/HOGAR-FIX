import 'package:flutter/material.dart';

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
              onPressed:() => Navigator.pushNamed(context, '/editarperfilcliente'),
              child: const Text("ir a editarperfilcliente ")
              )
          ],
        ),
      ),
    );
  }}