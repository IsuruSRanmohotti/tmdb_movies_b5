import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movies/models/movie_model.dart';
import 'package:tmdb_movies/services/api_services.dart';

import '../../utils/custom_navigator.dart';
import '../movie_view/movie_view.dart';

class MovieSearchScreen extends StatefulWidget {
  const MovieSearchScreen({super.key});

  @override
  State<MovieSearchScreen> createState() => _MovieSearchScreenState();
}

class _MovieSearchScreenState extends State<MovieSearchScreen> {
  bool isSearched = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Colors.grey.shade800,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const BackButton(
                      color: Colors.white,
                    ),
                    SizedBox(
                        width: size.width * 0.7,
                        child: TextField(
                          controller: searchController,
                          cursorColor: Colors.grey,
                          style: TextStyle(
                              color: Colors.grey.shade300,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              hintText: 'Type here',
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              border: InputBorder.none),
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            isSearched = true;
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.grey.shade700)),
                        icon: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
            ),
            !isSearched
                ? const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            size: 200,
                            color: Colors.grey,
                          ),
                          Text(
                            'Explore Movies',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                    ),
                  )
                : FutureBuilder(
                    future: ApiService().searchMovies(searchController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Expanded(
                            child: Center(
                          child: CupertinoActivityIndicator(
                            color: Colors.white,
                          ),
                        ));
                      }
                      if (snapshot.hasError) {}
                      List<MovieModel> movies = snapshot.data!;
                      return Expanded(
                        child: GridView.builder(
                          itemCount: movies.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 0.68),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  CustomNavigator.push(
                                      context, MovieView(movie: movies[index]));
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
                                      borderRadius: BorderRadius.circular(15)),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  )
          ],
        ),
      ),
    );
  }
}
