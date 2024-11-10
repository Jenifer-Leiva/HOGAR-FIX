import 'package:flutter/material.dart';

class ConfirmacionServicio extends StatelessWidget{
  const ConfirmacionServicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ConfirmacionServicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/chat'),
              child: const Text("ir a Chat ")
              )
          ],
        ),
      ),
    );
  }}