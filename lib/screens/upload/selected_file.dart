import 'dart:io';

import 'package:event_management/Bloc/upload_image/post_image_bloc.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/post_model.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';

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
            trailing: IconButton(
                onPressed: () async {
                  final croppedImage = await cropImage(context, imagePath);

                  final croppedImagePath = croppedImage.path;
                   Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) =>
                          ScreenSelectedFile(imagePath: croppedImagePath)));
                },
                icon: Icon(Icons.crop))),
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
                decoration: const InputDecoration(
                    border: InputBorder.none, hintText: 'Type something...'),
              ),
              BlocConsumer<PostImageBloc, PostImageState>(
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
                  return Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: () {
                          postModel = Post(
                              id: Utils.getUniqueId(),
                              title: titleController.text,
                              creatorId: null,
                              creatorImageId: null,
                              imagePath: null,
                              likeBy: [],
                              totalLikes: 0,
                              timestamp: DateTime.now().millisecondsSinceEpoch);
                          BlocProvider.of<PostImageBloc>(context)
                              .add(UploadImagEvent(imagePath, postModel));
                        },
                        child: const Text('Post')),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<CroppedFile> cropImage(BuildContext ctx, String imagePath) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressQuality: 85,
      aspectRatioPresets: [CropAspectRatioPreset.ratio16x9],
      uiSettings: [
        AndroidUiSettings(
            backgroundColor: white,
            dimmedLayerColor: white,
            hideBottomControls: true,
            toolbarTitle: 'Cropper',
            toolbarColor: primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: ctx,
        ),
      ],
    );
    return croppedFile!;
  }
}
