import 'package:event_management/screens/posts/posts_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetProfessionsPosts extends StatelessWidget {
  const WidgetProfessionsPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ScreenPostsView()));
          },
          child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'assets/image/5dcc5d9bce6550c6fc59b3c4cffae51c.jpg')))),
        );
      },
      itemCount: 10,
    );
  }
}
