import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/chat/persons/chat_screen.dart';
import 'package:event_management/screens/home/widgets/pro_post_card.dart';
import 'package:event_management/screens/notification/notification_screen.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:flutter/material.dart';

import '../../widgets/circular_progress_indicator.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    return Column(
      children: [
        WidgetAppBar(
            itHaveBack: false,
            trailing: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ScreenNotifiaction()));
                    },
                    icon: const Icon(Icons.notifications)),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScreenChatPersons()));
                    },
                    icon: const Icon(Icons.chat_bubble))
              ],
            )),
        StreamBuilder(
          stream:
              firestore.collection('posts').orderBy('timestamp',descending: true).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Expanded(
                child: ListView(
                  children: List.generate(snapshot.data!.docs.length, (index) {
                    var images = snapshot.data?.docs[index].data();
                    var imageDetails = Post.fromMap(images!);
                    return FutureBuilder(
                      future: getUser(images, firestore),
                      builder: (context, userModelSnapshot) {
                        if (userModelSnapshot.hasData) {
                          UserModel user = userModelSnapshot.data!;
                          return PostCard(
                            postDetails: imageDetails,
                            userData: user,
                          );
                        } else if (userModelSnapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return const SizedBox();
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
        )
      ],
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
