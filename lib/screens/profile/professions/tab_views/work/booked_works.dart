import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';

class WidgetBookedWorks extends StatelessWidget {
  const WidgetBookedWorks({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle completed = const TextStyle(color: grey);
    TextStyle unComplete = const TextStyle(color: black);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 9,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text('User Name', style: index < 5 ? unComplete : completed),
          subtitle: const Text('Profession'),
          trailing: Text('0${index + 1} / Apr / 200$index',
              style: index < 5 ? unComplete : completed),
        );
      },
    );
  }
}
