class Movie {
  String name;
  String directorName;
  String posterFilePath;
  int lovedPercentage;

  Movie({
    required this.name,
    required this.directorName,
    required this.lovedPercentage,
    required this.posterFilePath,
  });

  @override
  String toString() =>
      'Movie(name: $name, directorName: $directorName, lovedPercentage: $lovedPercentage, posterFilePath: $posterFilePath)';

  Movie clone() {
    return Movie(
      name: name,
      directorName: directorName,
      lovedPercentage: lovedPercentage,
      posterFilePath: posterFilePath,
    );
  }
}
