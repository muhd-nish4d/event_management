import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/home/widgets/app_bar_section.dart';
import 'package:flutter/material.dart';
import 'widgets/post_third_section.dart';
import 'widgets/text_second_section.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        itemsGapHeight,
        //AppBar
        HomeAppBarSection(),
        //TextSection
        const HomeSecondSection(),
        PostSection()
      ],
    );
  }
}
