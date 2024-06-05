import 'package:flutter/material.dart';

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
                onPressed: () {},
                style: ButtonStyle(
                    backgroundColor:
                        WidgetStatePropertyAll(Colors.grey.shade700)),
                icon: const Icon(
                  Icons.more_horiz_outlined,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}
