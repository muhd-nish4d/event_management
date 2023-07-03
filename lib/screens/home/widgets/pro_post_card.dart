import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:flutter/material.dart';

import '../../../model/post_model.dart';

class PostCard extends StatelessWidget {
  final Post? postDetails;
  final UserModel? userData;
  const PostCard(
      {super.key, required this.postDetails, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: SizedBox(
          height: 340,
          width: double.infinity,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     boxShadow: const [
          //       BoxShadow(
          //           blurRadius: 10, spreadRadius: 3, blurStyle: BlurStyle.outer)
          //     ]),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    userData!.profileImage == null
                        ? const CircleAvatar(
                            backgroundColor: grey,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          )
                        : CircleAvatar(
                            backgroundColor: grey,
                            backgroundImage:
                                NetworkImage(userData!.profileImage!),
                          ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>  ScreenProfessionsProfile(
                              userDetails: userData, isCleintView: true))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userData!.companyName!.isEmpty
                                ? 'No Name'
                                : userData!.companyName!,
                            style: TextStyle(color: black),
                          ),
                          Row(
                            children: [
                              Text(userData!.profession!),
                              SizedBox(width: 5),
                              // CircleAvatar(radius: 3, backgroundColor: grey),
                              // Text('Place')
                            ],
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_alt_1))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  elevation: 5,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                                color: grey.withOpacity(0.5),
                              ),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          imageUrl: postDetails!.imagePath!)),

                  // Container(
                  //   height: 200,
                  //   width: double.infinity,
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(10),
                  //       image: const DecorationImage(
                  //           fit: BoxFit.cover,
                  //           image: AssetImage(
                  //             'assets/image/beautiful-woman-long-red-dress-walks-around-city-with-her-husband.jpg',
                  //           ))),
                  // ),
                ),
              ),
              // Image.asset(
              //   'assets/image/5dcc5d9bce6550c6fc59b3c4cffae51c.jpg',
              // ),
              SizedBox(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite, color: Colors.red)),
                    const Text(
                      'Total Like',
                      style: TextStyle(color: grey),
                    ),
                    const Spacer(),
                    // const Text('Date', style: TextStyle(color: grey))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
