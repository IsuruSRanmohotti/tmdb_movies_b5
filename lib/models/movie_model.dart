import 'package:tmdb_movies/models/company_model.dart';

class MovieModel {
  String title;
  int id;
  String backdropPath;
  String posterPath;
  double voteAverage;
  String overview;
  List<CompanyModel>? companies;
  String? status;

  MovieModel({
    required this.title,
    required this.id,
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    this.companies,this.status
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    List<CompanyModel> companies = [];
    if (json['production_companies'] != null) {
      for (var companyData in (json['production_companies'] as List<dynamic>)) {
        CompanyModel company =
            CompanyModel.fromJson(companyData as Map<String, dynamic>);

        companies.add(company);
      }
    }

    return MovieModel(
      title: json['title'],
      id: json['id'],
      backdropPath: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
      overview: json['overview'],
      posterPath: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
      voteAverage: json['vote_average'],
      companies: companies,
      status: json['status'],
    );
  }
}
