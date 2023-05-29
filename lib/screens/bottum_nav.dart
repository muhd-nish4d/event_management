import 'package:event_management/const/color.dart';
import 'package:event_management/screens/home/home_screen.dart';
import 'package:event_management/screens/professions/professions.dart';
import 'package:event_management/screens/profile/cleint/cleint_pro_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'filter/filter_screen.dart';

class ScreenMain extends StatefulWidget {
  const ScreenMain({super.key});

  @override
  State<ScreenMain> createState() => _ScreenMainState();
}

class _ScreenMainState extends State<ScreenMain> {
  int currentIndexSelected = 0;
  List<Widget> screens = const [
    ScreenHome(),
    ScreenFilter(),
    ScreenProfession(),
    ScreenCleintProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(child: screens[currentIndexSelected]),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 10, blurStyle: BlurStyle.outer)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              selectedIndex: currentIndexSelected,
              activeColor: white,
              tabBackgroundColor: orange,
              tabBorderRadius: 10,
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.work,
                  text: 'Professions',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              onTabChange: (value) {
                setState(() {
                  currentIndexSelected = value;
                });
              },
            ),
          ),
        ));
  }
}
