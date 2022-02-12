import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/db/database_helper.dart';
import 'package:movie_watch_list/src/models/movie.dart';

class MoviesListProvier with ChangeNotifier {
  final db = DatabaseHelper.instance;
  List<Movie> movies = [];

  void addItem(Movie movie) async {
    final id = await db.insert(movie);
    movie.id = id;
    movies.add(movie);
    notifyListeners();
  }

  void updateItem(int index, Movie movie) async {
    await db.update(movie);
    movies[index] = movie;
    notifyListeners();
  }

  void removeItem(int index) async {
    await db.delete(movies[index]);
    movies.removeAt(index);
    notifyListeners();
  }
}
