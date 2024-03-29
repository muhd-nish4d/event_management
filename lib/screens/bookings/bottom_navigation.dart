import 'package:event_management/screens/bookings/screens/over.dart';
import 'package:event_management/screens/bookings/screens/pending.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../const/color.dart';
import '../../model/user_model.dart';

ValueNotifier<int> currentSelectedScreen = ValueNotifier(0);

class ScreenBookings extends StatelessWidget {
 const ScreenBookings({super.key, required this.userId});
  final UserModel userId;

  @override
  Widget build(BuildContext context) {
    final List pages = [
      ScreenPending(user: userId),
      ScreenOwer(
        user: userId,
      )
    ];
    return Scaffold(
        appBar: AppBar(title: const Text("Bookings")),
        body: ValueListenableBuilder(
            valueListenable: currentSelectedScreen,
            builder: (context, value, child) {
              return SafeArea(child: pages[value]);
            }),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 10, blurStyle: BlurStyle.outer)
          ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GNav(
              selectedIndex: currentSelectedScreen.value,
              activeColor: white,
              tabBackgroundColor: primaryColor,
              tabBorderRadius: 10,
              tabMargin: const EdgeInsets.symmetric(horizontal: 50),
              padding: const EdgeInsets.all(10),
              tabs: const [
                GButton(
                  icon: Icons.pending_actions_rounded,
                  text: 'Pending',
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
              ],
              onTabChange: (value) {
                currentSelectedScreen.value = value;
                // currentIndexSelected.notifyListeners();
              },
            ),
          ),
        ));
  }
}
