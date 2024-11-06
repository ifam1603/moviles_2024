import 'package:dio/dio.dart';
import 'package:moviles_2024/models/actor.dart';
import 'package:moviles_2024/models/popular_movieDAO.dart';

class PopularApi {
 //construiremos los elementos 

 final dio = Dio();
 final apiKey = '28a9a255dd4987326d3217dcc1c3e647';

 //void getPopularMovies() async{
 Future<List<PopularMoviesDao>> getPopularMovies() async{
 final response = await dio.get('https://api.themoviedb.org/3/movie/popular?api_key=28a9a255dd4987326d3217dcc1c3e647&language=es-MX&page=1');
  final res = response.data['results'] as List;
  return res.map((popular)=> PopularMoviesDao.fromMap(popular)).toList(); //todo lo que va haciendo, lo mandara a la lista

  }

  Future<String?> getMovieTrailer(int movieId) async {
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/$movieId/videos',
      queryParameters: {
        'api_key': apiKey,
        'language': 'es-MX',
      },
    );
    final results = response.data['results'] as List;

    // Filtramos los videos para encontrar un tráiler de YouTube
    final trailer = results.firstWhere(
      (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
      orElse: () => null,
    );

    // Retornamos la clave del tráiler si existe, de lo contrario null
    if (trailer != null) {
      return trailer['key']; // Esta es la clave de YouTube para construir la URL del tráiler
    }
    return null;
  }

  Future<List<Actor>> getMovieCast(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey';

    final response = await dio.get(url);
    final castData = response.data['cast'] as List;

    return castData.map((actor) => Actor.fromMap(actor)).toList();
  }

 }