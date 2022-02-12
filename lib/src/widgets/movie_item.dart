import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/models/movie.dart';
import 'package:movie_watch_list/src/providers/movie_list_provider.dart';
import 'package:movie_watch_list/src/screens/movie_details_screen.dart';
import 'package:provider/provider.dart';

class MovieItem extends StatelessWidget {
  const MovieItem({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Movie movie = context.watch<MoviesListProvier>().movies[index];
    return InkWell(
      onTap: () async {
        final result = await Navigator.push<Movie>(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MovieDetailsScreen(movie: movie.clone());
            },
          ),
        );
        if (result == null) return;
        context.read<MoviesListProvier>().updateItem(index, result);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        height: 180,
        child: Row(
          children: <Widget>[
            MovieImage(index: index),
            const SizedBox(width: 16),
            Flexible(child: MovieDetails(index: index)),
          ],
        ),
      ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  const MovieDetails({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Movie movie = context.watch<MoviesListProvier>().movies[index];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              movie.directorName,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              movie.name,
              style: theme.textTheme.titleLarge,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  Icons.favorite,
                  size: 21,
                  color: Colors.redAccent,
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                  child: Text(
                    '${movie.lovedPercentage}%',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Remove Movie'),
                    content: const Text(
                      'Are you sure do you want to remove this from your watch list?',
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete"),
                      )
                    ],
                  ),
                );
                if (ok == null) return;
                if (ok) context.read<MoviesListProvier>().removeItem(index);
              },
              icon: const Icon(Icons.delete),
            )
          ],
        )
      ],
    );
  }
}

class MovieImage extends StatelessWidget {
  const MovieImage({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final Movie movie = context.watch<MoviesListProvier>().movies[index];
    return AspectRatio(
      aspectRatio: 2 / 3,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(File(movie.posterFilePath)),
            ),
          ),
        ),
      ),
    );
  }
}
