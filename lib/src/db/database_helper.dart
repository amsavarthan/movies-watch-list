import 'package:movie_watch_list/src/models/movie.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = "Movies.db";
  static const _databaseVersion = 1;

  static const table = 'movies';

  static const columnId = '_id';
  static const columnName = 'movie_name';
  static const columnDirectorName = 'director_name';
  static const columnPosterPath = 'poster_path';
  static const columnLovedPercentage = 'loved_percentage';

  DatabaseHelper._privateConstructor();
  static final instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    return await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnDirectorName TEXT NOT NULL,
            $columnPosterPath TEXT NOT NULL,
            $columnLovedPercentage INTEGER NOT NULL
          )
          ''');
  }

  Future<int> insert(Movie movie) async {
    final db = await instance.database;
    return await db.insert(
      table,
      movie.toMap(),
    );
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await instance.database;
    final maps = await db.query(table);
    final movies = maps.map<Movie>((e) => Movie.fromMap(e));
    return movies.toList();
  }

  Future<int> update(Movie movie) async {
    final db = await instance.database;
    return await db.update(
      table,
      movie.toMap(),
      where: '$columnId = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> delete(Movie movie) async {
    final db = await instance.database;
    return await db.delete(
      table,
      where: '$columnId = ?',
      whereArgs: [movie.id],
    );
  }
}
