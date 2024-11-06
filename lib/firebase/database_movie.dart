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
  } catch (e) {
    kDebugMode ? print('ERROR AL INSERTAR: ${e.toString()}'): '';
    return false;
  }
return true;  
}

Future<bool> delete (String UId)async{

  try {
    collectionReference!.doc(UId).delete();
  } catch (e) {
    print('error $e');
  }
  return false;
}

Future<void> update (Map<String, dynamic> movies, String id) async{
 return collectionReference!.doc(id).update(movies);
}
//para retornar todos los resultados(documentos de esa coleccion) que tenemos en firebase
Stream<QuerySnapshot> Select (){
 return collectionReference!.snapshots();
}
}