import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:moviles_2024/models/moviesDAO.dart';
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
            namemovie varchar(100),
            overview text(),
            idgenero char(1),
            imgmovie VARCGAR(150),
            releasedate CHAR(10), 
            constraint fk_genre foreign key(idGenero) references tblgenre(idGenre);
        );''';
        db.execute(query);
        
      }
    );
  } //initdatabase

//estos seran metodos que se ejecuten en ssegundo plano 
  Future<int> INSERT(String table,Map<String,dynamic> row) async { //dynamic utiliza para regresar cualquier tipo de dato
    var con = await database;
    return await con.insert(table, row);
  }

  Future<int> UPDATE(String table, Map<String,dynamic> row) async {
    var con = await database;
    return await con.update(table, row, where: 'idmovie = ?',whereArgs: [row['idmovie']]);
  }

  Future<int> DELETE(String table, int idmovie ) async {
    var con = await database;
    return await con.delete(table,where: 'idmovie =?',whereArgs: [idmovie]);
  }

  Future<List<MoviesDAO>> SELECT() async {
    var con = await database;
    var result = await con.query('tblmovies');
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList();
  }

}