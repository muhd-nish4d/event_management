import 'package:flutter/cupertino.dart';

class WidgetProfessionsPosts extends StatelessWidget {
  const WidgetProfessionsPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 4, mainAxisSpacing: 4),
      itemBuilder: (context, index) {
        return Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'assets/image/5dcc5d9bce6550c6fc59b3c4cffae51c.jpg'))));
      },
      itemCount: 10,
    );
  }
}
