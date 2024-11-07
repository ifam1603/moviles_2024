import 'package:dio/dio.dart';
import 'package:moviles_2024/models/actor.dart';
import 'package:moviles_2024/models/popular_movieDAO.dart';

class PopularApi {
 //construiremos los elementos 

 final dio = Dio();
 final apiKey = '28a9a255dd4987326d3217dcc1c3e647';
   final String sessionId = 'e4d3369e092b3413ce952bd00e267af1f3c3df9c';
  final String accountId = '21611767';

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

Future<void> toggleFavorite(int movieId, bool isFavorite) async {
  final url = 'https://api.themoviedb.org/3/account/$accountId/favorite?api_key=$apiKey&session_id=$sessionId';
  
  try {
    final response = await dio.post(
      url,
      data: {
        "media_type": "movie",
        "media_id": movieId,
        "favorite": isFavorite,
      },
    );

    // Verificamos si el código de estado es 200 o 201
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(isFavorite ? 'Película agregada a favoritos' : 'Película eliminada de favoritos');
    } else {
      // Imprime el error si no es ni 200 ni 201
      print('Error ${response.statusCode}: ${response.data}');
      throw Exception('No se pudo modificar la lista de favoritos');
    }
  } catch (e) {
    print('Error en toggleFavorite: $e');
    throw Exception('No se pudo modificar la lista de favoritos');
  }
}

Future<List<PopularMoviesDao>> getFavoriteMovies() async {
  final url = 'https://api.themoviedb.org/3/account/$accountId/favorite/movies?api_key=$apiKey&session_id=$sessionId&language=es-MX&page=1';
  
  try {
    final response = await dio.get(url);
    final res = response.data['results'] as List;
    return res.map((movie) => PopularMoviesDao.fromMap(movie)).toList();
  } catch (e) {
    print('Error al obtener películas favoritas: $e');
    throw Exception('No se pudo cargar las películas favoritas');
  }
}

 }