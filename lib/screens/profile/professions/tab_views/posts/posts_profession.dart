import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/screens/posts/posts_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WidgetProfessionsPosts extends StatelessWidget {
  final String? user;
  const WidgetProfessionsPosts({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading...'));
          }
          var eachUserData = snapshot.data?.docs
              .where((element) => element['creatorId'] == user);

          return eachUserData!.isEmpty
              ? Text('No Posts')
              : GridView.builder(
                  padding: EdgeInsets.all(5),
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
                                builder: (context) => const ScreenPostsView()));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image:
                                      NetworkImage(imageDetail.imagePath!)))),
                    );
                  },
                  itemCount: eachUserData!.length,
                );
        });
  }
}
