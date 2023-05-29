import 'package:event_management/screens/home/widgets/pro_post_card.dart';
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
                  onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.chat_bubble))
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const PostCard();
              },
            ),
          )
        ],
      ),
      // child: PostCard(),
    ));
  }
}
