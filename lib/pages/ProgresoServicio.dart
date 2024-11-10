import 'package:flutter/material.dart';

class ProgresoServicio extends StatelessWidget{
  const ProgresoServicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ProgresoServicio"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/monitoreoservicio'),
              child: const Text("ir a MonitoreoServicio ")
              )
          ],
        ),
      ),
    );
  }}