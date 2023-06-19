import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/user/fillup/fillup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../const/images.dart';
import '../../model/user_model.dart';
import '../../widgets/image_background.dart';

class ScreenUserChose extends StatelessWidget {
  const ScreenUserChose({super.key,});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: WidgetBackGround(
      image: backgroundImage,
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              // OutlinedButton(onPressed: (){}, child: Text('hi')),
              UserChoseButtonStyle(
                  navigate: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenUserFillUp(type: UserType.cleint)));
                  },
                  screenSize: screenSize,
                  icon: Icons.person,
                  userType: "I'm a Client, searching for event providers"),
                  itemsGapHeight,
              UserChoseButtonStyle(
                  navigate: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ScreenUserFillUp(type: UserType.profession)));
                  },
                  screenSize: screenSize,
                  icon: Icons.work,
                  userType: "I'm a Event provider, looking for a work"),
                  const Spacer()
            ],
          ),
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
      width: screenSize.width * .8,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              // backgroundColor: orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: navigate,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: orange,
                size: 50,
              ),
              Text(
                userType,
                textAlign: TextAlign.start,
                style:  TextStyle(
                  color: orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          )),
    );
  }
}
