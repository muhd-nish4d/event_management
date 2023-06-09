import 'package:flutter/material.dart';

import '../../../../const/color.dart';
import '../../../../const/sizes.dart';

class WidgetChatAppBarTitle extends StatelessWidget {
  const WidgetChatAppBarTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(child: Icon(Icons.person, color: white)),
        itemsGapWidth,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Company Name',
                style: TextStyle(fontWeight: FontWeight.bold, color: white)),
            Row(
              children: const [
                Text('Profession',
                    style: TextStyle(fontSize: 15, color: white)),
                Icon(Icons.star, color: Colors.yellow, size: 15),
                Icon(Icons.star, color: Colors.yellow, size: 15),
                Icon(Icons.star, color: Colors.yellow, size: 15),
                Icon(Icons.star, color: Colors.yellow, size: 15),
                Icon(Icons.star, color: grey, size: 15),
              ],
            )
          ],
        )
      ],
    );
  }
}
