import 'package:event_management/const/color.dart';
import 'package:event_management/screens/home/home_screen.dart';
import 'package:event_management/screens/professions/professions.dart';
import 'package:event_management/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'filter/filter_screen.dart';

ValueNotifier<int> currentIndexSelected = ValueNotifier(0);

class ScreenMain extends StatelessWidget {
  ScreenMain({super.key});
  List<Widget> screens = const [
    ScreenHome(),
    ScreenFilter(),
    ScreenProfession(fromAnotherScreen: false),
    ScreenUserProfile(isProfessional: true)
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: currentIndexSelected,
            builder: (context, value, child) {
              return SafeArea(child: screens[value]);
            }),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 10, blurStyle: BlurStyle.outer)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              selectedIndex: currentIndexSelected.value,
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
                currentIndexSelected.value = value;
                currentIndexSelected.notifyListeners();
              },
            ),
          ),
        ));
  }
}
