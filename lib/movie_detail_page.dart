import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetailPage extends StatelessWidget {
  final Movie movie;

  MovieDetailPage({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(movie.poster, height: 300),
            ),
            SizedBox(height: 16.0),

            // Titre du film
            Text(
              movie.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),

            // Genre du film
            Text(
              movie.genre,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[600]),
            ),
            SizedBox(height: 8.0),

            // Note IMDb
            Text(
              'IMDb Rating: ${movie.imdbRating}',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 16.0),

            // Autres informations du film
            Text(
              'Runtime: ${movie.runtime}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8.0),

            Text(
              'Director: ${movie.director}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8.0),

            Text(
              'Actors: ${movie.actors}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            SizedBox(height: 8.0),

            // Résumé du film (Plot)
            Text(
              'Plot:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: 4.0),
            Text(
              movie.plot,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
