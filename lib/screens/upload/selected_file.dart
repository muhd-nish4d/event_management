import 'dart:io';

import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';

class ScreenSelectedFile extends StatelessWidget {
  final String imagePath;
  const ScreenSelectedFile({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(children: [
              Container(
                width: double.infinity,
                height: 500,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: FileImage(File(imagePath)))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: black,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: grey.withOpacity(0.3)),
                ),
              ),
            ]),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: const Text('Post', style: TextStyle(color: white)),
            )
          ],
        ),
      ),
    );
  }
}
