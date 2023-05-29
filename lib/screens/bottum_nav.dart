import 'package:event_management/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class ScreenMain extends StatelessWidget {
  const ScreenMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ScreenHome(),
    );
  }
}