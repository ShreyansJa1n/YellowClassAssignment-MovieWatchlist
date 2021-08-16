import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:yellow_class_assignment/model/movie.dart';

class MovieDB {
  static final MovieDB instance = MovieDB._init();
  static Database? _database;
  MovieDB._init();
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movies.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableName(
      ${MovieFields.id} $idType,
      ${MovieFields.movieName} $textType,
      ${MovieFields.directorName} $textType,
      ${MovieFields.image} TEXT
    )
    ''');
  }

  Future<Movie> create(Movie movie) async {
    final db = await instance.database;
    final id = await db.insert(tableName, movie.toJson());
    return movie.copy();
  }

  Future<List<Movie>> allMovies() async {
    final db = await instance.database;
    final movies = await db.query(tableName);
    return movies.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> updateMovie(Movie movie) async {
    final db = await instance.database;
    return db.update(
      tableName,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    );
  }

  Future<int> deleteMovie(int id) async {
    final db = await instance.database;
    return db
        .delete(tableName, where: '${MovieFields.id} = ?', whereArgs: [id]);
  }

  Future _close() async {
    final db = await instance.database;
    db.close();
  }
}
