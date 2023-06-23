import 'dart:io';

import 'package:event_management/Bloc/upload_image/post_image_bloc.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/chat/person_chat/widgets/appbar.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../static/statics.dart';

class ScreenSelectedFile extends StatelessWidget {
  final String imagePath;
  ScreenSelectedFile({super.key, required this.imagePath});
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Post postModel;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 100),
        child: WidgetAppBar(
            itHaveBack: true,
            title: 'New Post',
            trailing: BlocConsumer<PostImageBloc, PostImageState>(
              listener: (context, state) {
                if (state is PostLoadingState) {
                  const CircularProgressIndicator();
                } else if (state is PostUploadedState) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScreenMain(),
                      ),
                      (route) => false);
                }
              },
              builder: (context, state) {
                return TextButton(
                    onPressed: () {
                      postModel = Post(
                          id: Utils.getUniqueId(),
                          title: titleController.text,
                          creatorId: null,
                          creatorImageId: null,
                          imagePath: null,
                          // likeBy: ['njan'],
                          totalLikes: 0,
                          timestamp: DateTime.now().millisecondsSinceEpoch);
                      BlocProvider.of<PostImageBloc>(context)
                          .add(UploadImagEvent(imagePath, postModel));
                    },
                    child: const Text('Post'));
              },
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Card(
                elevation: 5,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(File(imagePath)))),
                ),
              ),
              TextFormField(
                controller: titleController,
                maxLines: 4,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Type something...'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
