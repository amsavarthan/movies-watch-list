import 'package:flutter/material.dart';
import 'package:movie_watch_list/src/models/movie.dart';

class MovieProvider with ChangeNotifier {
  late Movie movie;

  MovieProvider({Movie? movie}) {
    this.movie = movie ??
        Movie(
          name: '',
          directorName: '',
          lovedPercentage: 0,
          posterFilePath: ''
        );
  }

  void updateMovie({
    String? name,
    String? directorName,
    int? lovedPercentage,
    String? posterFilePath,
  }) {
    if (name != null) movie.name = name;
    if (directorName != null) movie.directorName = directorName;
    if (lovedPercentage != null) movie.lovedPercentage = lovedPercentage;
    if (posterFilePath != null) movie.posterFilePath = posterFilePath;
    notifyListeners();
  }
}
