import 'package:flutter/material.dart';

import '../../../../const/color.dart';

class CircleAvatarEdit extends StatelessWidget {
  const CircleAvatarEdit({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        const CircleAvatar(
          backgroundColor: grey,
          radius: 60,
          child: Icon(Icons.person, size: 70, color: white),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit,
            color: white,
          ),
          style: IconButton.styleFrom(backgroundColor: orange),
        )
      ],
    );
  }
}
