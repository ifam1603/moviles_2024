import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moviles_2024/firebase/database_movie.dart';
import 'package:moviles_2024/models/moviesDAO.dart';
import 'package:moviles_2024/views/movie_view.dart';
import 'package:moviles_2024/views/movie_view_item_firebase.dart';
import 'package:moviles_2024/views/movie_view_firebase.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MoviesScreenFirebase extends StatefulWidget {
  const MoviesScreenFirebase({super.key});

  @override
  State<MoviesScreenFirebase> createState() => _MoviesScreenFirebaseState();
}

class _MoviesScreenFirebaseState extends State<MoviesScreenFirebase> {
 //instanciamos la clase insert 
 late DatabaseMoviesfirebase? moviesDatabase; //nombre de la clase 

 @override
 void initState() {
 moviesDatabase = DatabaseMoviesfirebase();//colocamos el nombre de la clase 
 super.initState();
 }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies_list'),
        actions: [
          IconButton(
            onPressed: () {
              WoltModalSheet.show(
                context: context,
                pageListBuilder: (context) => [
                  WoltModalSheetPage(
                    child: MovieViewFirebase(),
                  )
                ],
              );
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder(
        stream: moviesDatabase?.Select(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Something was wrong'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay peliculas disponibles'));
          } else {
            var movies = snapshot.data!.docs;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movieData = movies[index];
                return MovieViewItemFirebase(
                  moviesDAO: MoviesDAO.fromMap(
                    {
                      'imgMovie': movieData.get('imgMovie'),
                      'nameMovie': movieData.get('nameMovie'),
                      'overview': movieData.get('overview'),
                      'releaseDate': movieData.get('releaseDate').toString(),
                    },

                  ),
                  uid: movieData.id,
                );
              },
            );
          }
        },
      ),
    );
  }
}