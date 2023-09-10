import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/home/widgets/post_card_new.dart';
import 'package:event_management/widgets/circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class PostSection extends StatelessWidget {
  PostSection({super.key});
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final Size mediaSize = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: firestore
          .collection('posts')
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: mediaSize.height * .61,
            width: double.infinity,
            child: ListView(
              padding: const EdgeInsets.all(30),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: List.generate(snapshot.data!.docs.length, (index) {
                var images = snapshot.data?.docs[index].data();
                var imageDetails = Post.fromMap(images!);
                return FutureBuilder(
                  future: getUser(images, firestore),
                  builder: (context, userModelSnapshot) {
                    if (userModelSnapshot.hasData) {
                      UserModel user = userModelSnapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: WidgetPostCard(
                          postDetails: imageDetails,
                          userData: user,
                        ),
                      );
                    } else if (userModelSnapshot.hasError) {
                      return const Text('Error');
                    } else {
                      return SizedBox(
                        width: mediaSize.width * .7,
                        child: const Center(child: CustomProgressIndicator()),
                      );
                    }
                  },
                );
              }),
            ),
          );
        } else {
          return const Expanded(child: CustomProgressIndicator());
        }
      },
    );
  }

  Future<UserModel> getUser(
    Map<String, dynamic> images,
    FirebaseFirestore firestore,
  ) async {
    QuerySnapshot querySnapshot = await firestore
        .collection('users')
        .where('uid', isEqualTo: images['creatorId'])
        .get();

    Map<String, dynamic> datas =
        querySnapshot.docs[0].data() as Map<String, dynamic>;
    UserModel userModel = UserModel.formMap(datas);
    return userModel;
  }
}
