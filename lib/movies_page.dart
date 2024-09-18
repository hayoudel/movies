import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Pour charger le fichier JSON
import 'movie.dart';
import 'movie_search_delegate.dart'; // Assure-toi que ce fichier existe et contient MovieSearchDelegate
import 'movie_detail_page.dart'; // Assure-toi que ce fichier existe et contient MovieDetailPage

Future<List<Movie>> loadMovies() async {
  final String response = await rootBundle.loadString('assets/movies.json');
  final List<dynamic> data = json.decode(response) as List<dynamic>;
  return data.map((json) => Movie.fromJson(json)).toList();
}

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              final movies = await loadMovies();
              showSearch(
                context: context,
                delegate: MovieSearchDelegate(movies),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Movie>>(
        future: loadMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No movies found.'));
          }

          final movies = snapshot.data!;
          movies.sort((a, b) => b.imdbRatingAsDouble.compareTo(a.imdbRatingAsDouble));

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                leading: Image.network(movie.poster),
                title: Text(movie.title),
                subtitle: Text(movie.genre),
                trailing: Text(movie.imdbRating),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailPage(movie: movie),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
