import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeSecondSection extends StatelessWidget {
  const HomeSecondSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Text(
            'Find The\nPerfect Eventer',
            style: GoogleFonts.salsa(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Text(
            'Discover the best event for you',
            style: GoogleFonts.salsa(color: grey),
          ),
        ],
      ),
    );
  }
}