import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/screens/chat/persons/chat_screen.dart';
import 'package:event_management/screens/notification/notification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeAppBarSection extends StatelessWidget {
  HomeAppBarSection({
    super.key,
  });
  final String currentUser = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 45,
            width: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: grey.withOpacity(.1)),
            child: Center(
              child: Text(
                'Event Hub',
                style: GoogleFonts.lobster(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )),
        const SizedBox(),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: grey.withOpacity(.1)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScreenNotifiaction()));
                  },
                  icon: const Icon(Icons.notifications)),
              IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(currentUser)
                        .get()
                        .then((value) {
                      if (value.exists) {
                        // Document exists, retrieve the field value
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScreenChatPersons(
                                      userType: value.data()!['userType'],
                                    )));
                        log('Field value: ${value.data()!['userType']}');
                      } else {
                        log('Document does not exist');
                      }
                    });
                  },
                  icon: const Icon(Icons.chat_bubble))
            ],
          ),
        ),
      ],
    );
  }
}