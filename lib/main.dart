import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hogarfixapp/firebase_options.dart';

//paginas_cod
import 'package:hogarfixapp/Pages/add_Registro_page.dart';
import 'package:hogarfixapp/Pages/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const Home(),
        '/add': (context) => const AddRegistro(),
      },
    );
  }
}
