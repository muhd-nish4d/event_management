import 'package:event_management/Bloc/fillup/fillup_bloc.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/screens/home/home_screen.dart';
import 'package:event_management/screens/professions/professions.dart';
import 'package:event_management/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../model/user_model.dart';
import 'filter/filter_screen.dart';

ValueNotifier<int> currentIndexSelected = ValueNotifier(0);

class ScreenMain extends StatelessWidget {
  final UserModel? userDatas;
  ScreenMain({super.key, this.userDatas});
  List<Widget> screens = [
    const ScreenHome(),
    const ScreenProfession(fromAnotherScreen: false),
    const ScreenFilter(),
    const ScreenUserProfile(isProfessional: true)
  ];
  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<FillupBloc>(context).close();
    // BlocProvider.of<FillupBloc>(context).add(FillUpInitialEvent());
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        body: ValueListenableBuilder(
            valueListenable: currentIndexSelected,
            builder: (context, value, child) {
              return SafeArea(child: screens[value]);
            }),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(blurRadius: 1, blurStyle: BlurStyle.outer)
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
