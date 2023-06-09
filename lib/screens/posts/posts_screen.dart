import 'package:flutter/material.dart';

import '../home/widgets/pro_post_card.dart';

class ScreenPostsView extends StatelessWidget {
  const ScreenPostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return const PostCard();
          },
        ),
      ),
    );
  }
}
