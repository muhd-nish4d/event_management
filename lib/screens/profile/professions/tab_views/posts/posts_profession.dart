import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/screens/posts/posts_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../model/user_model.dart';

class WidgetProfessionsPosts extends StatelessWidget {
  final UserModel? user;
  const WidgetProfessionsPosts({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: firestore
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }
          var eachUserData = snapshot.data?.docs
              .where((element) => element['creatorId'] == user!.uid);

          return eachUserData!.isEmpty
              ? const Text('No Posts')
              : GridView.builder(
                
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (context, index) {
                    var images = eachUserData.elementAt(index).data();

                    var imageDetail = Post.fromMap(images);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenPostsView(
                                      user: user!,
                                    )));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: CachedNetworkImage(
                            placeholder: (context, url) => Container(
                                  color: grey.withOpacity(0.5),
                                ),
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                            imageUrl: imageDetail.imagePath!),
                      ),
                    );
                  },
                  itemCount: eachUserData.length,
                );
        });
  }
}
