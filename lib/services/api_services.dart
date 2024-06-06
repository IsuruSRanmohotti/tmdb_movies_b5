import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:tmdb_movies/models/movie_model.dart';

class ApiService {
  String apiKey = 'api_key=206f4bdc58a80317e550efddb30793aa';
  String popularMovies = 'https://api.themoviedb.org/3/movie/popular?';
  String nowPlaying = 'https://api.themoviedb.org/3/movie/now_playing?';
  String upcomingMovies = 'https://api.themoviedb.org/3/movie/upcoming?';

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

  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await http.get(Uri.parse('$nowPlaying$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = [];
      for (var movieData in results) {
        MovieModel movie =
            MovieModel.fromJson(movieData as Map<String, dynamic>);
        movies.add(movie);
      }
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }

  Future<List<MovieModel>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse('$upcomingMovies$apiKey'));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body['results'];
      List<MovieModel> movies = [];
      for (var movieData in results) {
        MovieModel movie =
            MovieModel.fromJson(movieData as Map<String, dynamic>);
        movies.add(movie);
      }
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }
}
