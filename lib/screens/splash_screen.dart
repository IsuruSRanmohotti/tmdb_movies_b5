import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmdb_movies/screens/home/homepage.dart';
import 'package:tmdb_movies/utils/custom_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      CustomNavigator.pushReplacement(context, const HomePage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://miniwallist.com/wp-content/uploads/2018/07/spiderman-movie-mobile-wallpaper-minimalist-3072x4096.jpg'))),
            child: const Center(
              child: Text(
                'TMDB Movies',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'From Ceylon Edge',
                  style: TextStyle(color: Colors.white),
                ),
              ))
        ],
      ),
    );
  }
}
