import 'package:flutter/material.dart';

class WidgetBackGround extends StatelessWidget {
  final Widget? child;
  final String image;
  const WidgetBackGround({super.key, this.child, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(image))),
      child: child,
    );
  }
}
