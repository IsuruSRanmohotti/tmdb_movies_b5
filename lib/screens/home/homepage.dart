import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb_movies/services/api_services.dart';

import 'widgets/custom_app_bar.dart';

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
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.grey.shade900,
            statusBarBrightness: Brightness.dark),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: ApiService().getPopularMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
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
                                      image: NetworkImage(movie.backdropPath)),
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
