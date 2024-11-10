import 'package:flutter/material.dart';

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
              onPressed:() => Navigator.pushNamed(context, '/iniciocliente'),
              child: const Text("ir a InicioCliente ")
              )
          ],
        ),
      ),
    );
  }}