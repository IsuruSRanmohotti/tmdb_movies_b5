class MovieModel {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  double voteAverage;
  String overview;

  MovieModel({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        title: json['title'],
        id: json['id'],
        backdropPath: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
        overview: json['overview'],
        posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        voteAverage: json['vote_average']);
  }
}
