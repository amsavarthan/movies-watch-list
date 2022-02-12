import 'package:movie_watch_list/src/db/database_helper.dart';

class Movie {
  int? id;
  String name;
  String directorName;
  String posterFilePath;
  int lovedPercentage;

  Movie({
    this.id = 0,
    required this.name,
    required this.directorName,
    required this.posterFilePath,
    required this.lovedPercentage,
  });

  @override
  String toString() {
    return 'Movie(id: $id, name: $name, directorName: $directorName, posterFilePath: $posterFilePath, lovedPercentage: $lovedPercentage)';
  }

  Movie clone() {
    return Movie(
      id: id,
      name: name,
      directorName: directorName,
      lovedPercentage: lovedPercentage,
      posterFilePath: posterFilePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnDirectorName: directorName,
      DatabaseHelper.columnPosterPath: posterFilePath,
      DatabaseHelper.columnLovedPercentage: lovedPercentage,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map[DatabaseHelper.columnId]?.toInt() ?? 0,
      name: map[DatabaseHelper.columnName] ?? '',
      directorName: map[DatabaseHelper.columnDirectorName] ?? '',
      posterFilePath: map[DatabaseHelper.columnPosterPath] ?? '',
      lovedPercentage: map[DatabaseHelper.columnLovedPercentage]?.toInt() ?? 0,
    );
  }
}
