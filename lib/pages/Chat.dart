import 'package:flutter/material.dart';
class Chat extends StatelessWidget{
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed:() => Navigator.pushNamed(context, '/progresoservicio'),
              child: const Text("ir a ProgresoServicio ")
              )
          ],
        ),
      ),
    );
  }}