import 'package:flutter/material.dart';
import 'package:moviles_2024/models/popular_movieDAO.dart';
import 'package:moviles_2024/network/popular_api.dart';
import 'package:moviles_2024/screens/detail_popular_screen.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMoviesScreenState();
}

class _FavoriteMoviesScreenState extends State<FavoriteMoviesScreen> {
  
  late Future<List<PopularMoviesDao>> _favoriteMovies;

  @override
  void initState() {
    super.initState();
    _loadFavoriteMovies();
  }

  void _loadFavoriteMovies() {
    setState(() {
      _favoriteMovies = PopularApi().getFavoriteMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Películas Favoritas'),
      ),
      body: FutureBuilder<List<PopularMoviesDao>>(
        future: _favoriteMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tienes películas favoritas.'));
          }

          final favoriteMovies = snapshot.data!;
          return ListView.builder(
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return ListTile(
                title: Text(movie.title ?? 'Título desconocido'),
                subtitle: Text(movie.releaseDate ?? 'Fecha desconocida'),
                leading: Hero(
                  tag: 'movie-poster-${movie.id}',
                  child: movie.posterPath != null
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.movie),
                ),
                onTap: () {         
                  Navigator.of(context).push(_createPopAndScaleRoute(movie)).then((_){
                    _loadFavoriteMovies();
                  });
                },
              );
            },
          );
        },
      ),
    );
  }

  Route _createPopAndScaleRoute(PopularMoviesDao movie) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => DetailPopularScreen(),
      settings: RouteSettings(arguments: movie),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const curve = Curves.easeInOut;
        final scaleAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return ScaleTransition(
          scale: scaleAnimation,
          child: child,
        );
      },
    );
  }
}
