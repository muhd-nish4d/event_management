import 'package:flutter/material.dart';

import '../const/color.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: SizedBox(
            height: 80,
            width: 80,
            child: CircularProgressIndicator(
              color: grey,
              strokeWidth: 1,
            )));
  }
}
