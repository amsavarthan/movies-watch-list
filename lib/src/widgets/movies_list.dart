import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/models/movie.dart';
import 'package:movie_watch_list/src/providers/movie_list_provider.dart';
import 'package:movie_watch_list/src/widgets/movie_item.dart';
import 'package:provider/provider.dart';

class MoviesList extends StatelessWidget {
  const MoviesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Movie> movies = context.watch<MoviesListProvier>().movies;
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 6),
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) => MovieItem(index: index),
      itemCount: movies.length,
    );
  }
}
