import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/bookings/bottom_navigation.dart';
import 'package:event_management/screens/profile/professions/tab_views/follow/follwing.dart';
import 'package:event_management/screens/settings/settigs_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/fillup/fillup_bloc.dart';
import '../../../const/color.dart';

class ScreenCleintProfile extends StatelessWidget {
  ScreenCleintProfile({super.key, this.user});
  final UserModel? user;
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getCurrentUser(),
            builder: (context, snapshot) {
              final UserModel cleintUser = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  user == null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ScreenBookings(userId: cleintUser),
                                    ));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                'Bookings',
                                style: TextStyle(color: white),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenSettingsMenu()));
                                },
                                icon: const Icon(Icons.menu_outlined))
                          ],
                        )
                      : IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                  const SizedBox(height: 20),
                  user == null
                      ? Row(
                          children: [
                            cleintUser.profileImage == null
                                ? const CircleAvatar(
                                    radius: 60,
                                    child: Icon(
                                      Icons.person,
                                      color: white,
                                      size: 70,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                              color: grey.withOpacity(0.5),
                                            ),
                                        fit: BoxFit.cover,
                                        width: 130,
                                        height: 130,
                                        imageUrl: cleintUser.profileImage!),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cleintUser.ownerName ?? 'User Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.work_outline_rounded),
                                    Text('Cleint'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    Text(cleintUser.phoneNumber ??
                                        'Phone Number'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            user?.profileImage == null
                                ? const CircleAvatar(
                                    radius: 60,
                                    child: Icon(
                                      Icons.person,
                                      color: white,
                                      size: 70,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                              color: grey.withOpacity(0.5),
                                            ),
                                        fit: BoxFit.cover,
                                        width: 130,
                                        height: 130,
                                        imageUrl: user!.profileImage!),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user!.ownerName ?? 'User Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.work_outline_rounded),
                                    Text('Cleint'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    Text(user!.phoneNumber ?? 'Phone No'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Following',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Divider(),
                  Expanded(
                    child: WidgetProfessionsFollow(
                        followers: user != null
                            ? user!.following!
                            : cleintUser.following!),
                  )
                ],
              );
            },
          )),
    );
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Convert the document data to a Map
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        // Return the user data
        return UserModel.formMap(userData);
      } else {
        // Document with the provided userId doesn't exist
        print("User data not found.");
        return null;
      }
    } catch (e) {
      // Error fetching user data
      print("Error fetching user data: $e");
      return null;
    }
  }
}
