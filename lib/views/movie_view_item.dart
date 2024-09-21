import 'package:flutter/material.dart';
import 'package:moviles_2024/models/moviesDAO.dart';

class MovieViewItem extends StatefulWidget {
   MovieViewItem({super.key,required this.moviesDAO});

  MoviesDAO moviesDAO;

  @override
  State<MovieViewItem> createState() => _MovieViewItemState();
}

class _MovieViewItemState extends State<MovieViewItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.moviesDAO.imgMovie!),
    );
  }
}