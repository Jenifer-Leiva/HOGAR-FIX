import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hogarfixapp/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:hogarfixapp/pantallas/inicio.dart';
import 'package:hogarfixapp/pantallas/pagina.dart';

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
    return  MaterialApp.router(
      routerConfig: GoRouter(initialLocation: '/inicio',routes: [
      GoRoute(
        path: '/inicio',
        builder: (context, state) => Inicio() ,
        ),
        GoRoute(
        path: '/pagina',
        builder: (context, state) => Pagina() ,
        ),
      ]),
    );
  }
}
