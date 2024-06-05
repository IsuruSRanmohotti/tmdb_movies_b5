import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class ApiService {
  String apiKey = 'api_key=206f4bdc58a80317e550efddb30793aa';
  String popularMovies = 'https://api.themoviedb.org/3/movie/popular?';

  Future<List<MovieModel>> getPopularMovies() async {
    final response = await http.get(Uri.parse('$popularMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      // List<MovieModel> movies = results.map(
      //   (movie) {
      //     return MovieModel.fromJson(movie as Map<String, dynamic>);
      //   },
      // ).toList();
      List<MovieModel> movies = [];
      for (var movie in results) {
        MovieModel movieModel =
            MovieModel.fromJson(movie as Map<String, dynamic>);
        movies.add(movieModel);
      }
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }
}
