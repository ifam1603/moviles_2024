import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabase {
  static final NAMEDB = 'MOVIESDB';
  static final VERSIONDB = 1;

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await initDatabase();
  }
  
  Future<Database> initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory(); //CON ESTE METODO ACCCEDEMOS A DIRECTORIOS SEGUROS
    String path = join(folder.path, NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version){//PARA CUANDO SEA LA PRIMERA VEZ QUE SE INSTALA LA APP EJECUTE ESTE METODO
        //DENTRO ESTE METODO PODEMOS EJECUTAR LOS QUERYS QUE QUERAMOS
        String query ='''
          CREATE TABLE tblgenre(
            idGenre char(1) PRIMARY KEY,
            dscgenre VARCHAR(50)
          );

          CREATE TABLE tblmovies(
            idmovie INTEGER PRIMARY KEY ,
            nameMovie varchar(100),
            overview text(),
            idGenero char(1),
            imgMovie VARCGAR(150),
            releaseDate CHAR(10), 
            constraint fk_genre foreign key(idGenero) references tblgenre(idGenre);
        );''';
        db.execute(query);
        
      }
    );
  } //initdatabase

//estos seran metodos que se ejecuten en ssegundo plano 
  Future<int> INSERT(String table,Map<String,dynamic> row) async { //dynamic utiliza para regresar cualquier tipo de dato
    var con = await database;
    return con.insert(table, row);
  }

  Future<int> UPDATE() async {}

  Future<int> DELETE() async {}

  Future<List<MoviesDAO>> SELECT() async {}

}