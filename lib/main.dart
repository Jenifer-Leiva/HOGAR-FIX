import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hogarfixapp/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:hogarfixapp/pantallas/Calificacion.dart';
import 'package:hogarfixapp/pantallas/Chat.dart';
import 'package:hogarfixapp/pantallas/ConfirmacionServicio.dart';
import 'package:hogarfixapp/pantallas/DetallesProveedor.dart';
import 'package:hogarfixapp/pantallas/EditarPerfilCliente.dart';
import 'package:hogarfixapp/pantallas/EditarPerfilProveedor.dart';
import 'package:hogarfixapp/pantallas/HistorialServicios.dart';
import 'package:hogarfixapp/pantallas/InicioCliente.dart';
import 'package:hogarfixapp/pantallas/InicioProveedor.dart';
import 'package:hogarfixapp/pantallas/MonitoreoServicio.dart';
import 'package:hogarfixapp/pantallas/PerfilCliente.dart';
import 'package:hogarfixapp/pantallas/PerfilProveedor.dart';
import 'package:hogarfixapp/pantallas/ProgresoServicio.dart';
import 'package:hogarfixapp/pantallas/Registro.dart';
import 'package:hogarfixapp/pantallas/ResultadosBusqueda.dart';
import 'package:hogarfixapp/pantallas/Soporte.dart';



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
      routerConfig: GoRouter(initialLocation: '/Registro',routes: [
      GoRoute(
        path: '/Registro',
        builder: (context, state) => const Registro() ,
        ),


        GoRoute(
        path: '/PerfilCliente',
        builder: (context, state) => const PerfilCliente() ,
        ),
        GoRoute(
        path: '/EditarPerfilCliente',
        builder: (context, state) => const EditarPerfilCliente() ,
        ),
        GoRoute(
        path: '/InicioCliente',
        builder: (context, state) => const InicioCliente() ,
        ),
        GoRoute(
        path: '/ResultadosBusqueda',
        builder: (context, state) => const ResultadosBusqueda() ,
        ),


         GoRoute(
        path: '/PerfilProveedor',
        builder: (context, state) => const PerfilProveedor() ,
        ),
         GoRoute(
        path: '/EditarPerfilProveedor',
        builder: (context, state) => const EditarPerfilProveedor() ,
        ),
         GoRoute(
        path: '/InicioProveedor',
        builder: (context, state) => const InicioProveedor() ,
        ),
        GoRoute(
        path: '/DetallesProveedor',
        builder: (context, state) => const DetallesProveedor() ,
        ),
       

        GoRoute(
        path: '/ConfirmacionServicio',
        builder: (context, state) => const ConfirmacionServicio() ,
        ),
        GoRoute(
        path: '/Chat',
        builder: (context, state) => const Chat() ,
        ),
        GoRoute(
        path: '/ProgresoServicio',
        builder: (context, state) => const ProgresoServicio() ,
        ),
        GoRoute(
        path: '/MonitoreoServicio',
        builder: (context, state) => const MonitoreoServicio() ,
        ),
        GoRoute(
        path: '/Calificacion',
        builder: (context, state) => const Calificacion() ,
        ),


         GoRoute(
        path: '/HistorialServicios',
        builder: (context, state) => const HistorialServicios() ,
        ),
        GoRoute(
        path: '/Soporte',
        builder: (context, state) => const Soporte() ,
        )
      ]),
    );
  }
}
     