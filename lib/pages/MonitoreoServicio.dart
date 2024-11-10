import 'package:flutter/material.dart';

class MonitoreoServicio extends StatelessWidget{
  const MonitoreoServicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MonitoreoServicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/calificacion'),
              child: const Text("ir a Calificacion ")
              )
          ],
        ),
      ),
    );
  }}