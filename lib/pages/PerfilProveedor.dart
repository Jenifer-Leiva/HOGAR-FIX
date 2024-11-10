import 'package:flutter/material.dart';

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
              onPressed:() =>  Navigator.pushNamed(context, '/editarperfilproveedor'),
              child: const Text("ir a editarperfilproveedor ")
              )
          ],
        ),
      ),
    );
  }}