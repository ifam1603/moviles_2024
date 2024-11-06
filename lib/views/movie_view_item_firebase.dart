import 'package:flutter/material.dart';
import 'package:moviles_2024/database/movies_database.dart';
import 'package:moviles_2024/models/moviesDAO.dart';
import 'package:moviles_2024/settings/global_values.dart';
import 'package:moviles_2024/views/movie_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class MovieViewItemFirebase extends StatefulWidget {
  MovieViewItemFirebase(
      {super.key,
      required this.moviesDAO,
      required this.uid,
      });

  final MoviesDAO moviesDAO;
  final uid;
  
  @override
  State<MovieViewItemFirebase> createState() => _MovieViewItemFirebaseState();
}

class _MovieViewItemFirebaseState extends State<MovieViewItemFirebase> {
  MoviesDatabase? moviesDatabase;

  @override
  void initState() {
    super.initState();
    moviesDatabase = MoviesDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromRGBO(68, 138, 255, 1)),
      child: Column(
        children: [
          Row(
            children: [
              Image.network(
                widget.moviesDAO.imgMovie!,
                width:100,
                height: 100,
              ),
              Expanded(
                child: ListTile(
                  title: Text(widget.moviesDAO.nameMovie!),
                  subtitle: Text(widget.moviesDAO.releaseDate!),
                ),
              ),
              IconButton(
                  onPressed: () {
                    WoltModalSheet.show(
                      context: context, 
                      pageListBuilder: (context) => [
                        WoltModalSheetPage(
                          child: MovieView(moviesDAO: widget.moviesDAO,)
                        )
                      ]
                    );
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () {
                    moviesDatabase!
                        .DELETE('tblmovies', widget.moviesDAO.idMovie!)
                        .then((value) {
                      if (value > 0) {
                        GlobalValues.bandUpdListMovies.value =
                            !GlobalValues.bandUpdListMovies.value;
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Transaction Completed Successfully!',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: true,
                        );
                      } else {
                        return QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          text: 'Something was wrong! :()',
                          autoCloseDuration: const Duration(seconds: 2),
                          showConfirmBtn: false,
                        );
                      }
                    });
                  },
                  icon: Icon(Icons.delete)),
            ],
          ),
          Divider(),
          Text(widget.moviesDAO.overview!),
        ],
      ),
    );
  }
}

//