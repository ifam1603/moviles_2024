import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:moviles_2024/models/actor.dart';
import 'package:moviles_2024/models/popular_movieDAO.dart';
import 'package:moviles_2024/network/popular_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailPopularScreen extends StatefulWidget {
  
  const DetailPopularScreen({super.key});

  @override
  State<DetailPopularScreen> createState() => _DetailPopularScreenState();
}

class _DetailPopularScreenState extends State<DetailPopularScreen> {
  bool isLoading = true;
  PopularMoviesDao? popular;
  YoutubePlayerController? _youtubeController;
  String? trailerUrl;
  List<Actor> cast = [];

   bool isFavorite = false; // Estado de favorito
  final PopularApi _api = PopularApi(); // Instancia de la API


@override
void initState() {
  super.initState();
  // Recibimos los argumentos de la película
  Future.microtask(() {
    final args = ModalRoute.of(context)?.settings.arguments as PopularMoviesDao?;
    setState(() {
      popular = args;
      isLoading = false;
    });
    if (args != null) {
      _buscartrailer(args.id);
      buscaractores(args.id);
      // Verificar si la película está en los favoritos
      _checkIfFavorite(args.id);
    }
  });
}

Future<void> _checkIfFavorite(int movieId) async {
  try {
    final favoriteMovies = await _api.getFavoriteMovies();
    setState(() {
      isFavorite = favoriteMovies.any((movie) => movie.id == movieId);
    });
  } catch (e) {
    print('Error al verificar si la película está en favoritos: $e');
    // Si hay error, asumimos que no está en favoritos
    setState(() {
      isFavorite = false;
    });
  }
}

Future<void> _toggleFavorite() async {
  if (popular != null) {
    // Llama a la función de la API para agregar o quitar de favoritos
    await _api.toggleFavorite(popular!.id, !isFavorite);
    setState(() {
      isFavorite = !isFavorite; // Cambia el estado de favorito
    });
  }
}


  Future<void> _buscartrailer(int movieId) async {
    const apiKey = '28a9a255dd4987326d3217dcc1c3e647';

    final url = 'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey';
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final videoResults = data['results'] as List;
      final trailer = videoResults.firstWhere(
        (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
        orElse: () => null,
      );

      if (trailer != null) {
        final videoKey = trailer['key'];
        trailerUrl = 'https://www.youtube.com/watch?v=$videoKey';
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoKey,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
        setState(() {});
      }
    }
  }

    Future<void> buscaractores(int movieId) async {
    final api = PopularApi();
    final buscarcast = await api.getMovieCast(movieId);
    setState(() {
      cast = buscarcast;
    });
  }

  @override
  void dispose() {
    _youtubeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(popular?.title ?? 'Detalle de la película'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
          actions: [
            IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.red,
              onPressed: _toggleFavorite, // Llama a la función para alternar favoritos
            ),
          ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  opacity: 0.8,
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500/${popular?.posterPath}',
                  ),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        popular?.title ?? '',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Fecha de lanzamiento: ${popular?.releaseDate ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Popularidad: ${popular?.popularity ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Promedio de votos:',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Widget de estrellas para el rating
                          RatingBarIndicator(
                            rating: (popular?.voteAverage ?? 0) / 2, // Convertimos a escala de 5
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${popular?.voteAverage ?? 'N/A'}/10',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
/////////////////////////////////////////RESUMEN DE PELICULA 
                      const SizedBox(height: 10),
                      Text(
                        'Resumen:',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        popular?.overview ?? 'No disponible',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
//////////////////////REPRODUCTOR DEL TRAILER 
                      const SizedBox(height: 20),
                      if (trailerUrl != null && _youtubeController != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Tráiler:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            YoutubePlayer(
                              controller: _youtubeController!,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.red,
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
/////////////////////////////////LISTA DE ACTORES 
                     const SizedBox(height: 10),
                      const Text(
                        'Actores:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cast.length,
                          itemBuilder: (context, index) {
                            final actor = cast[index];
                            return Container(
                              width: 100,
                              margin: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: actor.profilePath != null
                                        ? NetworkImage(
                                            'https://image.tmdb.org/t/p/w500${actor.profilePath}',
                                          )
                                        : const AssetImage('assets/images/placeholder.png') as ImageProvider,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    actor.name,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    actor.character,
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.white70,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}