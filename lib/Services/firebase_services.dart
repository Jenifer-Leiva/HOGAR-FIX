import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore baseDatos = FirebaseFirestore.instance;

Future<List> getProveedores() async {
  List proveedores = [];

  QuerySnapshot queryProveedores =
      await baseDatos.collection('Proveedores').get();

  for (var doc in queryProveedores.docs) {
    proveedores.add(doc.data());
  }

  return proveedores;
}

Future<void> addUsuarios(
    String nombre, String correo, String celular, String contrasena) async {
  await baseDatos.collection("Proveedores").add({
    "Nombre": nombre,
    'Correo': correo,
    'Celular': celular,
    'Contraseña': contrasena,
  });
}
//////////////////////////////////////////////////////////////////////////////////////

FirebaseFirestore baseDatosClientes = FirebaseFirestore.instance;

Future<List> getClientes() async {
  List clientes = [];

  QuerySnapshot queryclientes =
      await baseDatosClientes.collection('Clientes').get();

  for (var doc in queryclientes.docs) {
    clientes.add(doc.data());
  }

  return clientes;
}

Future<void> addUsuariosClientes(
    String nombre, String correo, String celular, String contrasena) async {
  await baseDatosClientes.collection("Clientes").add({
    "Nombre": nombre,
    'Correo': correo,
    'Celular': celular,
    'Contraseña': contrasena, // Nuevo campo para almacenar la contraseña
  });
}

//////////////////////////////////////////////////////////////////////////////////////

FirebaseFirestore baseDatosServicios = FirebaseFirestore.instance;

Future<List> getServicios() async {
  List Servicios = [];

  QuerySnapshot queryservicios =
      await baseDatosServicios.collection('Servicios').get();

  for (var doc in queryservicios.docs) {
    Servicios.add(doc.data());
  }

  return Servicios;
}

Future<void> addServicios(
    String servicio, String fecha, String estado, String proveedor,String cliente) async {
  await baseDatosServicios.collection("Servicios").add({
    "Servicio": servicio,
    'Fecha': fecha,
    'Estado': estado,
    'Proveedor': proveedor,
    'Cliente': cliente, // Nuevo campo para almacenar la contraseña
  });
}