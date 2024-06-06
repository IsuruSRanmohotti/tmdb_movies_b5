import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../services/api_services.dart';

class PopularMovieSlider extends StatelessWidget {
  const PopularMovieSlider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiService().getPopularMovies(),
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
    
          return CarouselSlider(
            options: CarouselOptions(
                height: 180,
                autoPlay: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.9),
            items: snapshot.data!.map((movie) {
              return Builder(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                        width: size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    NetworkImage(movie.backdropPath)),
                            borderRadius: BorderRadius.circular(15)),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color:
                                        Colors.black.withOpacity(0.6),
                                    borderRadius:
                                        BorderRadius.circular(15)),
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.grey.shade400,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.amber.shade800,
                                      borderRadius:
                                          BorderRadius.circular(50)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        movie.voteAverage.toString(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      const Icon(
                                        Icons.star_rounded,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                  );
                },
              );
            }).toList(),
          );
        });
  }
}
