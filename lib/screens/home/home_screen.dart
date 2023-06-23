import 'package:event_management/screens/chat/persons/chat_screen.dart';
import 'package:event_management/screens/home/widgets/pro_post_card.dart';
import 'package:event_management/screens/notification/notification_screen.dart';
import 'package:flutter/material.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenNotifiaction()));
                  },
                  icon: const Icon(Icons.notifications)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenChatPersons()));
                  },
                  icon: const Icon(Icons.chat_bubble))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const PostCard();
              },
              itemCount: 10,
            ),
          )
        ],
      ),
      // child: PostCard(),
    ));
  }
}
