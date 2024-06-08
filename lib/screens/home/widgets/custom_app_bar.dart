import 'package:flutter/material.dart';
import 'package:tmdb_movies/screens/movie_search/movie_search_page.dart';
import 'package:tmdb_movies/utils/custom_navigator.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade700)),
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                )),
            const Text(
              'TMDB Movies',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  CustomNavigator.push(context, const MovieSearchScreen());
                },
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade700)),
                icon: const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
