import 'package:flutter/material.dart';
import 'package:moviles_2024/models/popular_movieDAO.dart';
import 'package:moviles_2024/provider/test_provider.dart';
import 'package:provider/provider.dart';

class DetailPopularScreen extends StatefulWidget {
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  @override
  Widget build(BuildContext context) {
    final popular = ModalRoute.of(context)!.settings.arguments as PopularMoviesDao;
    
    final testprovider = Provider.of<TestProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()=>testprovider.name = 'Antoine griezman' ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            opacity: .7,
            fit: BoxFit.fill,
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${popular.posterPath}'),
          )
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Opacity(
              opacity: .7,
              child: Container(
                width: MediaQuery.of(context).size.width, //con esto nos da el ancho de la pantalla
                child: Text(popular.title,style: TextStyle(color: Colors.white),),
                color: Colors.black,
                height: 50,
              ),
            )
          ],
        ),
      ));
  }
}