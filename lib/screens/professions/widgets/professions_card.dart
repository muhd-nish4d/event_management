import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/screens/chat/person_chat/chatting_screen.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../../../model/user_model.dart';
import '../../../static/statics.dart';

class ProfessionsCard extends StatelessWidget {
  ProfessionsCard({super.key, required this.professions});
  final UserModel professions;

  final String? currentUserUid = FirebaseAuth.instance.currentUser!.uid;

  ValueNotifier<bool> isFollowed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    isFollowed.value = professions.isFollowed(currentUserUid!);
    return Card(
      elevation: 5,
      child: SizedBox(
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: GestureDetector(
                onTap: () {
                  log(professions.uid.toString());
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenProfessionsProfile(
                          isCleintView: true, userDetails: professions)));
                },
                child: Stack(
                  // alignment: Alignment.center,
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 100,
                                ),
                                Text(professions.ownerName ?? 'Owner Name'),
                                Text(
                                  professions.companyName ?? 'Company Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Text(professions.profession ?? 'Profession'),
                                // Row(
                                //   children: const [
                                //     Icon(
                                //       Icons.star,
                                //       color: Colors.yellow,
                                //       size: 15,
                                //     ),
                                //     Icon(
                                //       Icons.star,
                                //       color: Colors.yellow,
                                //       size: 15,
                                //     ),
                                //     Icon(
                                //       Icons.star,
                                //       color: Colors.yellow,
                                //       size: 15,
                                //     ),
                                //     Icon(
                                //       Icons.star,
                                //       color: Colors.yellow,
                                //       size: 15,
                                //     ),
                                //     Icon(
                                //       Icons.star,
                                //       color: grey,
                                //       size: 15,
                                //     )
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 80,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),

                          // image: professions.coverImage!.isEmpty
                          //     ? null
                          //     : DecorationImage(
                          //         fit: BoxFit.cover,
                          //         image:

                          //             NetworkImage(professions.coverImage!))
                        ),
                        child: professions.coverImage!.isEmpty
                            ? const SizedBox()
                            : ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 60,
                                    height: 60,
                                    imageUrl: professions.coverImage!),
                              ),
                      ),
                    ),
                    Positioned(
                      // alignment: Alignment.centerLeft,
                      top: 50,
                      left: 20,
                      child: professions.profileImage!.isEmpty
                          ? const CircleAvatar(
                              radius: 30,
                              backgroundColor: grey,
                              child: Icon(
                                Icons.person,
                                color: white,
                                size: 40,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 60,
                                  height: 60,
                                  imageUrl: professions.profileImage!),
                            ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: white,
                  ),
                  child: Column(
                    children: [
                      const Divider(
                        height: 0,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () {
                                final roomId = Utils.createChatRoomId(
                                    resp: professions.uid!);
                                log(roomId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ScreenChat(
                                              user: professions,
                                              chatRoomId: roomId,
                                            )));
                              },
                              child: const Text('Chat'),
                            ),
                            const VerticalDivider(),
                            ValueListenableBuilder(
                                valueListenable: isFollowed,
                                builder: (context, value, child) {
                                  return TextButton(
                                    onPressed: () {
                                      if (value) {
                                        // Perform unfollow action
                                        Utils.unfollowUser(professions.uid!);
                                      } else {
                                        // Perform follow action
                                        Utils.followUser(professions.uid!);
                                      }
                                    },
                                    child: Text(value ? 'Unfollow' : 'Follow'),
                                  );
                                })
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
