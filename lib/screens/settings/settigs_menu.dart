import 'package:event_management/const/color.dart';
import 'package:event_management/screens/settings/screens/privacy_policy.dart';
import 'package:event_management/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/log/login_bloc.dart';

class ScreenSettingsMenu extends StatelessWidget {
  const ScreenSettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: seconderyColor,
          title: const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          // SettingsTiles(text: 'Edit profile', icon: Icons.edit, onTap: () {}),
          SettingsTiles(text: 'Help', icon: Icons.help, onTap: () {}),
          SettingsTiles(
              text: 'Privacy Policy',
              icon: Icons.view_list_rounded,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ScreenPrivacyPolicy(isAbout: false),
                    ));
              }),
          SettingsTiles(
              text: 'About',
              icon: Icons.info,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ScreenPrivacyPolicy(isAbout: true),
                    ));
              }),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoggedOutState) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ScreenSplash()),
                    (route) => false);
                // Navigator.of(context).push(
                //     MaterialPageRoute(builder: (context) => const ScreenSplash()));
              } else if (state is LogLoadingState) {
                const Center(child: CircularProgressIndicator());
              }
            },
            builder: (context, state) {
              return SettingsTiles(
                  text: 'Log out',
                  icon: Icons.logout,
                  isRed: true,
                  onTap: () {
                    alertDialoague(context);
                    // BlocProvider.of<LoginBloc>(context).logOut();
                  });
            },
          ),
        ],
      ),
    );
  }

  void alertDialoague(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.pop(context);

                BlocProvider.of<LoginBloc>(context).add(LogOutEvent());
              },
              child: const Text('Yes'))
        ],
      ),
    );
  }
}

class SettingsTiles extends StatelessWidget {
  final String text;
  final IconData icon;
  bool isRed;
  final void Function()? onTap;
  SettingsTiles(
      {super.key,
      required this.text,
      required this.icon,
      this.isRed = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onTap,
        leading: Icon(icon, color: isRed ? Colors.red : black),
        title: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: isRed ? Colors.red : black),
        ));
  }
}
