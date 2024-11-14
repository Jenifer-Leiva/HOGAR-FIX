import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:hogarfixapp/firebase_options.dart';
import 'package:hogarfixapp/pages/Calificacion.dart';

//paginas_cod
import 'package:hogarfixapp/pages/CambioContrasenia.dart';
import 'package:hogarfixapp/pages/CancelacionServicio.dart';
import 'package:hogarfixapp/pages/Chat.dart';
import 'package:hogarfixapp/pages/ConfirmacionServicio.dart';
import 'package:hogarfixapp/pages/DetallesProveedor.dart';
import 'package:hogarfixapp/pages/EditarPerfilCliente.dart';
import 'package:hogarfixapp/pages/EditarPerfilProveedor.dart';
import 'package:hogarfixapp/pages/HistorialSCliente.dart';
import 'package:hogarfixapp/pages/HistorialSProveedor.dart';
import 'package:hogarfixapp/pages/InicioCliente.dart';
import 'package:hogarfixapp/pages/InicioProveedor.dart';
import 'package:hogarfixapp/pages/Login.dart';
import 'package:hogarfixapp/pages/MonitoreoServicio.dart';
import 'package:hogarfixapp/pages/PerfilCliente.dart';
import 'package:hogarfixapp/pages/PerfilProveedor.dart';
import 'package:hogarfixapp/pages/ProgresoServicio.dart';
import 'package:hogarfixapp/pages/Registro.dart';
import 'package:hogarfixapp/pages/ResultadosBusqueda.dart';
import 'package:hogarfixapp/pages/Soporte.dart';


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
        '/': (context) => const Login(),
        '/cambiocontraseña': (context) => const CambioContrasenia(),
        '/registro': (context) => const Registro(),
        
        '/perfilcliente': (context) => const PerfilCliente(),
        '/editarperfilcliente': (context) => const EditarPerfilCliente(),
        '/iniciocliente': (context) =>  const InicioCliente(),
        '/resultadosbusqueda': (context) => const ResultadosBusqueda(),
        '/detallesproveedor': (context) => const DetallesProveedor(),
        '/confirmacionservicio': (context) => const ConfirmacionServicio(),
        '/chat': (context) => const Chat(),

        '/progresoservicio': (context) => const ProgresoServicio(),
        '/cancelacionservicio': (context) => const CancelacionServicio(),
        '/monitoreoservicio': (context) => const MonitoreoServicio(),
        '/calificacion': (context) => const Calificacion(),

        '/perfilproveedor': (context) => const PerfilProveedor(),
        '/editarperfilproveedor': (context) => const EditarPerfilProveedor(),
       '/inicioproveedor': (context) =>  InicioProveedor(),
        
        
  
        '/historialcliente': (context) => const HistorialSCliente(),
        '/historialproveedor': (context) => const HistorialSProveedor(),
        '/soporte': (context) => const Soporte(),
      },
    );
  }
}
