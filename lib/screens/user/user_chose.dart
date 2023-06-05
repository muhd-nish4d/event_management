import 'package:event_management/const/color.dart';
import 'package:event_management/screens/user/fillup/fillup_screen.dart';
import 'package:flutter/material.dart';

class ScreenUserChose extends StatelessWidget {
  const ScreenUserChose({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            UserChoseButtonStyle(
                isBuisness: false,
                screenSize: screenSize,
                icon: Icons.person,
                userType: 'As a Client'),
            UserChoseButtonStyle(
                isBuisness: true,
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
    required this.isBuisness,
  });

  final Size screenSize;
  final String userType;
  final IconData icon;
  final bool isBuisness;

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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ScreenUserFillUp(isFullShow: isBuisness)));
          },
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
