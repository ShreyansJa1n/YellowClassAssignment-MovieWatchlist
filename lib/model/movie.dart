final String tableName = 'movies';

class Movie {
  final int? id;
  final String movieName;
  final String directorName;
  final String? image;

  const Movie(
      {this.id,
      required this.movieName,
      required this.directorName,
      this.image});

  Movie copy({
    int? id,
    String? movieName,
    String? directorName,
    String? image,
  }) =>
      Movie(
          id: id ?? this.id,
          movieName: movieName ?? this.movieName,
          directorName: directorName ?? this.directorName,
          image: image);

  static Movie fromJson(Map<String, Object?> json) => Movie(
      id: json[MovieFields.id] as int?,
      movieName: json[MovieFields.movieName] as String,
      directorName: json[MovieFields.directorName] as String,
      image: json[MovieFields.image] as String);

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.movieName: movieName,
        MovieFields.directorName: directorName,
        MovieFields.image: image
      };
}

class MovieFields {
  static final List<String> values = ['id', 'movieName', 'directorName'];
  static final String id = '_id';
  static final String movieName = 'moviename';
  static final String directorName = 'directorname';
  static final String image = 'image';
}
