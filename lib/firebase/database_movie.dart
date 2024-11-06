import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseMoviesfirebase{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
   CollectionReference? collectionReference;

//creamos un constructor
DatabaseMoviesfirebase(){
 //instanciamos el collectionReference
collectionReference= firebaseFirestore.collection('movies');

}

//creamos los metodos 
Future<bool> insertar (Map<String, dynamic> movies) async{
  try {
    collectionReference!.doc().set(movies);
    return true;
  } catch (e) {
    kDebugMode ? print('ERROR AL INSERTAR: ${e.toString()}'): '';
    return false;
  }
return true;  
}

Future<bool> delete (String UId)async{

  try {
    collectionReference!.doc(UId).delete();
    return true;
  } catch (e) {
      print('error $e');
  }
  return false;
}

Future<bool> update (Map<String, dynamic> movies, String id) async{
  try {
    collectionReference!.doc(id).update(movies);
    return true;
  } catch (e) {
      print('error $e');
  }
 return false;
}
//para retornar todos los resultados(documentos de esa coleccion) que tenemos en firebase
Stream<QuerySnapshot> Select (){
 return collectionReference!.snapshots();
}
}