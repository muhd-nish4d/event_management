import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/static/statics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/post_model.dart';

class ScreenViewEvent extends StatelessWidget {
  ScreenViewEvent({super.key, required this.postDetail, required this.user});
  final Post postDetail;
  final UserModel user;
  ValueNotifier<bool> userLiked = ValueNotifier(false);
  final String? currentUser = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    userLiked.value = postDetail.isLiked(currentUser!);
    Size mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          ClipRRect(
              child: Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: mediaSize.height * .55,
                child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          color: grey.withOpacity(0.5),
                        ),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageUrl: postDetail.imagePath!),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: black,
                              size: 20,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          )),
          // Container(
          //   decoration: BoxDecoration(
          //       image: DecorationImage(
          //           image: NetworkImage(postDetail.imagePath!),
          //           fit: BoxFit.cover)),

          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              width: double.infinity,
              height: mediaSize.height * .5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.profileImage!),
                        ),
                        itemsGapWidth,
                        Text(
                          user.companyName!,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    itemsGapHeight,
                    const Text('Place'),
                    itemsGapHeight,
                    Text(
                      postDetail.title!,
                      style: const TextStyle(color: grey),
                    ),
                    itemsGapHeight,
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Total ${postDetail.likeBy!.length.toString()}"),
                            const Text(
                              'Likes for this post',
                              style: TextStyle(color: grey, fontSize: 10),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Book Now'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Hero(
            tag: '${postDetail.imagePath}',
            child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: SizedBox(
                    height: mediaSize.width * .2,
                    width: mediaSize.width * .2,
                    child: ValueListenableBuilder(
                        valueListenable: userLiked,
                        builder: (context, value, child) {
                          return IconButton(
                            onPressed: () {
                              if (value) {
                                Utils.getPostIdByImage(postDetail.id!)
                                    .then((id) {
                                  Utils.unLikeUserPost(id!);
                                });
                              } else {
                                Utils.getPostIdByImage(postDetail.id!)
                                    .then((id) {
                                  Utils.likeUserPost(id!);
                                });
                              }
                            },
                            icon: Icon(
                                value
                                    ? Icons.favorite
                                    : Icons.favorite_border_rounded,
                                color: value ? Colors.red : black),
                            style: IconButton.styleFrom(
                                backgroundColor: white, iconSize: 40),
                          );
                        }),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
