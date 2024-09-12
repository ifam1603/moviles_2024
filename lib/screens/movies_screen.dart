import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moviles_2024/database/movies_database.dart';
import 'package:moviles_2024/models/moviesDAO.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  //mandamos a llamra 
  late MoviesDatabase moviesDB =  MoviesDatabase();
  
  @override
  void initState(){
    super.initState();
    moviesDB = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Movies list'),),
      body:  FutureBuilder(
        future: moviesDB.SELECT(),//aqui el future builder va a ejecutar en segundo plano
        builder: (context,AsyncSnapshot<List<MoviesDAO>> snapshot) {
          if(snapshot.hasData){
            return ListView.builder(//el listview solo se usa cuand sabemos cuantos elemntos son, si no sabemos usamos el builder
              itemBuilder: (context, index) { 
                return movieViewItem();         
              },
          );
          }else{
            if(snapshot.hasError){
              return Center(child: Text('something was wrong '),);
            }else{
              return Center(child:CircularProgressIndicator(),);
            }
          }
        }
      ),
    );
  }

  Widget movieViewItem(){
    return Text('');
  }
}