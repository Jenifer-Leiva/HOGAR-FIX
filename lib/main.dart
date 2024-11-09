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
        builder: (context, state) => Registro() ,
        ),


        GoRoute(
        path: '/PerfilCliente',
        builder: (context, state) => PerfilCliente() ,
        ),
        GoRoute(
        path: '/EditarPerfilCliente',
        builder: (context, state) => EditarPerfilCliente() ,
        ),
        GoRoute(
        path: '/InicioCliente',
        builder: (context, state) => InicioCliente() ,
        ),
        GoRoute(
        path: '/ResultadosBusqueda',
        builder: (context, state) => ResultadosBusqueda() ,
        ),


         GoRoute(
        path: '/PerfilProveedor',
        builder: (context, state) => PerfilProveedor() ,
        ),
         GoRoute(
        path: '/EditarPerfilProveedor',
        builder: (context, state) => EditarPerfilProveedor() ,
        ),
         GoRoute(
        path: '/InicioProveedor',
        builder: (context, state) => InicioProveedor() ,
        ),
        GoRoute(
        path: '/DetallesProveedor',
        builder: (context, state) => DetallesProveedor() ,
        ),
       

        GoRoute(
        path: '/ConfirmacionServicio',
        builder: (context, state) => ConfirmacionServicio() ,
        ),
        GoRoute(
        path: '/Chat',
        builder: (context, state) => Chat() ,
        ),
        GoRoute(
        path: '/ProgresoServicio',
        builder: (context, state) => ProgresoServicio() ,
        ),
        GoRoute(
        path: '/MonitoreoServicio',
        builder: (context, state) => MonitoreoServicio() ,
        ),
        GoRoute(
        path: '/Calificacion',
        builder: (context, state) => Calificacion() ,
        ),


         GoRoute(
        path: '/HistorialServicios',
        builder: (context, state) => HistorialServicios() ,
        ),
        GoRoute(
        path: '/Soporte',
        builder: (context, state) => Soporte() ,
        ),
      ]),
    );
  }
}
     