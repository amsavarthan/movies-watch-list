import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/models/movie.dart';

class MoviesListProvier with ChangeNotifier {
  final List<Movie> movies = [];

  void addItem(Movie movie) {
    movies.add(movie);
    notifyListeners();
  }

  void updateItem(int index, Movie movie) {
    movies[index] = movie;
    notifyListeners();
  }

  void removeItem(int index) {
    movies.removeAt(index);
    notifyListeners();
  }
}
