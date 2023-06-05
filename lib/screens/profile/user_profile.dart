import 'package:event_management/screens/profile/cleint/cleint_pro_screen.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:flutter/material.dart';

class ScreenUserProfile extends StatelessWidget {
  final bool isProfessional;
  const ScreenUserProfile({super.key, required this.isProfessional});

  @override
  Widget build(BuildContext context) {
    return isProfessional
        ? const ScreenProfessionsProfile(isCleintView: false)
        : const ScreenCleintProfile();
  }
}
