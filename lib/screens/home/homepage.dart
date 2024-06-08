import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';
import 'package:tmdb_movies/screens/movie_view/movie_view.dart';
import 'package:tmdb_movies/services/api_services.dart';
import 'package:tmdb_movies/utils/custom_navigator.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/popular_movies.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(),
              const SizedBox(
                height: 10,
              ),
              PopularMovieSlider(size: size),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Now Playing',
                      style: TextStyle(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const Text(
                      'See All',
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade800,
              ),
              FutureBuilder(
                  future: ApiService().getNowPlayingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text(
                        'Something went wrong',
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    List<MovieModel> movies = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            movies.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      CustomNavigator.push(context,
                                          MovieView(movie: movies[index]));
                                    },
                                    child: Hero(
                                      tag: movies[index].id,
                                      child: Container(
                                        width: 130,
                                        height: 180,
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    movies[index].posterPath)),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                      ),
                                    ),
                                  ),
                                )),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Movies',
                      style: TextStyle(
                          color: Colors.grey.shade300,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    const Text(
                      'See All',
                      style: TextStyle(
                          color: Colors.amber,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )
                  ],
                ),
              ),
              Divider(
                color: Colors.grey.shade800,
              ),
              FutureBuilder(
                  future: ApiService().getUpcomingMovies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text(
                        'Something went wrong',
                        style: TextStyle(color: Colors.white),
                      );
                    }

                    List<MovieModel> movies = snapshot.data!;
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(
                            movies.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      CustomNavigator.push(context,
                                          MovieView(movie: movies[index]));
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 180,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  movies[index].posterPath)),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                )),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
