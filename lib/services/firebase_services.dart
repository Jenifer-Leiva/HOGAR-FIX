import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore baseDatos = FirebaseFirestore.instance;

Future<List> getProveedores() async {
  List proveedores = [];

  CollectionReference collectionReferenceProveedores =
      baseDatos.collection('Proveedores');

  QuerySnapshot queryProveedores = await collectionReferenceProveedores.get();

  queryProveedores.docs.forEach((documento) {
    proveedores.add(documento.data());
  });
  return proveedores;
}
