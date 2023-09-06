import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/widgets/user_listtile.dart';
import 'package:flutter/material.dart';

import '../../../../../model/user_model.dart';

class WidgetProfessionsFollow extends StatelessWidget {
  const WidgetProfessionsFollow({super.key, required this.followers});
  final List<dynamic> followers;
  // late UserModel user;

  @override
  Widget build(BuildContext context) {
    return followers.isEmpty
        ? const Center(child: Text('No followers'))
        : ListView.builder(
            itemBuilder: (context, index) {
              return FutureBuilder<UserModel?>(
                future: getUserDetails(followers[index]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.indigo[100],
                      ),
                    );
                  } else if (snapshot.hasData) {
                    UserModel? user = snapshot.data;
                    return UsersTile(userDetails: user);
                  } else {
                    return const SizedBox(); // or handle the error case
                  }
                },
              );
            },
            itemCount: followers.length,
          );
  }

  Future<UserModel?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        // User document found, create UserModel instance
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return UserModel.formMap(data);
      } else {
        // User document not found
        return null;
      }
    } catch (e) {
      // Error occurred
      log('Error fetching user details: $e');
      return null;
    }
  }
}
