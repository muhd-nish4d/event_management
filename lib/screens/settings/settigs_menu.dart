import 'package:event_management/const/color.dart';
import 'package:event_management/screens/user/fillup/fillup_screen.dart';
import 'package:flutter/material.dart';

class ScreenSettingsMenu extends StatelessWidget {
  const ScreenSettingsMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.bold))),
      body: Column(
        children: [
          SettingsTiles(text: 'Edit profile', icon: Icons.edit),
          SettingsTiles(text: 'Help', icon: Icons.help),
          SettingsTiles(text: 'About', icon: Icons.info),
          SettingsTiles(text: 'Log out', icon: Icons.logout, isRed: true),
        ],
      ),
    );
  }
}

class SettingsTiles extends StatelessWidget {
  final String text;
  final IconData icon;
  bool isRed;
  SettingsTiles(
      {super.key, required this.text, required this.icon, this.isRed = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      const ScreenUserFillUp(isFullShow: true)));
        },
        leading: Icon(icon, color: isRed ? Colors.red : black),
        title: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: isRed ? Colors.red : black),
        ));
  }
}
