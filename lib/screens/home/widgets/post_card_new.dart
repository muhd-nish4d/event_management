import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/screens/view_event/view_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../model/post_model.dart';
import '../../../model/user_model.dart';
import '../../../static/statics.dart';

class WidgetPostCard extends StatelessWidget {
  final Post? postDetails;
  final UserModel? userData;
  WidgetPostCard({super.key, this.postDetails, this.userData});
  ValueNotifier<bool> isUserLiked = ValueNotifier(false);
  final String? currentUser = FirebaseAuth.instance.currentUser?.uid;
  // ValueNotifier<bool> isFollowed = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    isUserLiked.value = postDetails!.isLiked(currentUser!);
    final Size mediaSize = MediaQuery.of(context).size;
    final TextStyle postText = GoogleFonts.salsa(
        fontWeight: FontWeight.bold, color: white, fontSize: 18);
    return SizedBox(
      width: mediaSize.width * .7,
      height: mediaSize.height * .8,
      child: Stack(children: [
        Hero(
          tag: '${postDetails!.imagePath}',
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                        color: grey.withOpacity(0.5),
                      ),
                  fit: BoxFit.cover,
                  imageUrl: postDetails!.imagePath!),
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(20),
          //       image: DecorationImage(
          //           image: NetworkImage(postDetails!.imagePath!),
          //           fit: BoxFit.cover)),
          // ),
        ),
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              width: double.infinity,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey.shade200.withOpacity(0)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userData!.profileImage!),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData!.companyName!,
                        style: postText,
                      ),
                      Text(
                        userData!.profession!,
                        style: postText.copyWith(
                            fontWeight: FontWeight.normal, fontSize: 15),
                      )
                    ],
                  )
                ],
              )),
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) => ScreenViewEvent(
                                postDetail: postDetails!,
                                user: userData!,
                              )));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: white, elevation: 0),
                child: Text(
                  'View Event',
                  style: postText.copyWith(color: black),
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: isUserLiked,
                  builder: (context, value, child) {
                    return IconButton(
                      onPressed: () {
                        if (value) {
                          Utils.getPostIdByImage(postDetails!.id!).then((id) {
                            Utils.unLikeUserPost(id!);
                          });
                        } else {
                          Utils.getPostIdByImage(postDetails!.id!).then((id) {
                            Utils.likeUserPost(id!);
                          });
                        }
                      },
                      icon: Icon(
                        value
                            ? Icons.favorite_sharp
                            : Icons.favorite_border_outlined,
                        color: value ? Colors.red : black,
                      ),
                      style: IconButton.styleFrom(backgroundColor: white),
                    );
                  })
            ],
          ),
        )
      ]),
    );
  }
}
