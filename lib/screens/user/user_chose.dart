import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/screens/user/fillup/fillup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';

class ScreenUserChose extends StatelessWidget {
  const ScreenUserChose({super.key,});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UserChoseButtonStyle(
                navigate: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenUserFillUp(type: UserType.cleint)));
                },
                screenSize: screenSize,
                icon: Icons.person,
                userType: 'As a Client'),
            UserChoseButtonStyle(
                navigate: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenUserFillUp(type: UserType.profession)));
                },
                screenSize: screenSize,
                icon: Icons.work,
                userType: 'As a Business Man'),
          ],
        ),
      ),
    );
  }
}

class UserChoseButtonStyle extends StatelessWidget {
  const UserChoseButtonStyle({
    super.key,
    required this.screenSize,
    required this.userType,
    required this.icon,
    this.navigate,
  });

  final Size screenSize;
  final String userType;
  final IconData icon;
  final void Function()? navigate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: screenSize.width * .4,
      width: screenSize.width * .4,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: navigate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: white,
                size: 50,
              ),
              Text(
                userType,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
  }
}
