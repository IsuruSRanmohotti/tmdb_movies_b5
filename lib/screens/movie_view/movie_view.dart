import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/actor_model.dart';
import 'package:tmdb_movies/models/company_model.dart';
import 'package:tmdb_movies/models/movie_model.dart';
import 'package:tmdb_movies/services/api_services.dart';

class MovieView extends StatelessWidget {
  const MovieView({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: size.width,
                height: size.height / 4,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(movie.backdropPath))),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: SafeArea(
                          child: BackButton(
                            color: Colors.white,
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    Colors.black.withOpacity(0.6))),
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FutureBuilder(
                        future:
                            ApiService().getMovieDetails(movie.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator.adaptive();
                          }
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: FilledButton(
                              style: const ButtonStyle(
                                  backgroundColor:
                                      WidgetStatePropertyAll(Colors.blue)),
                              onPressed: () {},
                              child: Text(
                                snapshot.data!.status!,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                )),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: movie.id,
                        child: Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(movie.posterPath)),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          movie.overview,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Production Companies',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Divider(
                    color: Colors.grey.shade800,
                  ),
                  FutureBuilder(
                      future: ApiService().getMovieDetails(movie.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Something Went wrong',
                            style: TextStyle(color: Colors.grey),
                          );
                        }
                        List<CompanyModel> companies =
                            snapshot.data!.companies!;

                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: companies.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey.shade700,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ListTile(
                                    leading: Image.network(
                                      companies[index].logo!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    title: Text(
                                      companies[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Actors',
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  Divider(
                    color: Colors.grey.shade800,
                  ),
                  FutureBuilder(
                      future: ApiService().getCastList(movie.id.toString()),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.hasError) {
                          return const Text(
                            'Something Went wrong',
                            style: TextStyle(color: Colors.grey),
                          );
                        }
                        List<ActorModel> actors = snapshot.data!;

                        return MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          removeBottom: true,
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: actors.length,
                            itemBuilder: (context, index) {
                              return Card(
                                color: Colors.grey.shade700,
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          NetworkImage(actors[index].image!),
                                    ),
                                    title: Text(
                                      actors[index].name,
                                      style: TextStyle(
                                          color: Colors.grey.shade300,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      actors[index].character,
                                      style: TextStyle(
                                          color: Colors.grey.shade300),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
