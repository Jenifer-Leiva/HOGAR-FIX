import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hogarfixapp/firebase_options.dart';

Future<void> main() async {
  // Asegúrate de que las bindings de Flutter estén inicializadas antes de iniciar Firebase.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Corre la aplicación
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

// Función para agregar datos a Firestore
void addDataToFirestore() async {
  // Obtén una instancia de Firestore
  final db = FirebaseFirestore.instance;
  
  // Define el nuevo documento que deseas agregar
  final user = <String, dynamic>{
    "Celular": 1815,
    "Corre electronico": "Lovelace",
    "Nombre": "Ada"
  };

  // Agrega el documento a la colección "users" y maneja la respuesta
  db.collection("users").add(user).then((DocumentReference doc) {
    print('DocumentSnapshot added with ID: ${doc.id}');
  }).catchError((error) {
    print("Error adding document: $error");
  });
}
