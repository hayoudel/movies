import 'package:flutter/material.dart';
import 'movie.dart';
import 'movie_detail_page.dart';

class MovieSearchDelegate extends SearchDelegate<String> {
  final List<Movie> movies;

  MovieSearchDelegate(this.movies);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Efface la recherche
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Movie> filteredMovies = movies
        .where((movie) => movie.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: filteredMovies.length,
      itemBuilder: (context, index) {
        final movie = filteredMovies[index];
        return ListTile(
          leading: Image.network(movie.poster),
          title: Text(movie.title),
          subtitle: Text(movie.genre),
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
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }
}
