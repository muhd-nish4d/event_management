import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../const/color.dart';

class CircleAvatarEdit extends StatelessWidget {
  final ValueNotifier<File?> notifier;
  const CircleAvatarEdit({super.key, required this.notifier});

  

  @override
  Widget build(BuildContext context) {  
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        ValueListenableBuilder(
            valueListenable: notifier,
            builder: (context, value, child) {
              return value == null
                  ? const CircleAvatar(
                      backgroundColor: grey,
                      radius: 60,
                      child: Icon(Icons.person, size: 70, color: white),
                    )
                  : CircleAvatar(
                      backgroundImage: FileImage(File(value.path)),
                      radius: 60,
                    );
            }),
        IconButton(
          onPressed: () {
            pickImageProfile();
          },
          icon: const Icon(
            Icons.edit,
            color: white,
          ),
          style: IconButton.styleFrom(backgroundColor: primaryColor),
        )
      ],
    );
  }

  Future<void> pickImageProfile() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      notifier.value = File(pickedImage.path);
    }
  }
}
