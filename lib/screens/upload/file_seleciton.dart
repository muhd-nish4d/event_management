import 'dart:io';
import 'package:all_gallery_images/model/StorageImages.dart';
import 'package:event_management/screens/upload/selected_file.dart';
import 'package:event_management/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:all_gallery_images/all_gallery_images.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';

import '../../const/color.dart';

ValueNotifier<StorageImages?> images = ValueNotifier(null);

class ScreenFileShowing extends StatefulWidget {
  const ScreenFileShowing({Key? key}) : super(key: key);

  @override
  State<ScreenFileShowing> createState() => _ScreenFileShowingState();
}

class _ScreenFileShowingState extends State<ScreenFileShowing> {
  StorageImages? _storageImages;
  CroppedFile? croppedImage;
  String? croppedImagePath;
  // late StorageImages uniqueImag;

  @override
  void initState() {
    super.initState();
    getImagesFromGallery();
  }

  Future<void> getImagesFromGallery() async {
    StorageImages? storageImages;

    try {
      storageImages = await GalleryImages().getStorageImages();

      if (storageImages != null && storageImages.images != null) {
        // Create a set to store unique images
        final Set<String> uniqueImagePaths = {};
        final List<Images> uniqueImages = [];

        for (final image in storageImages.images!) {
          // Check if the image path is unique
          if (!uniqueImagePaths.contains(image.imagePath)) {
            uniqueImagePaths.add(image.imagePath!);
            uniqueImages.add(image);
          }
        }

        storageImages.images = uniqueImages;
      }
    } catch (error) {
      debugPrint(error.toString());
    }

    setState(() {
      _storageImages = storageImages;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size(double.infinity, 90),
            child: WidgetAppBar(itHaveBack: true)),
        body: _storageImages != null
            ? GridView.builder(
                padding: const EdgeInsets.all(2),
                itemCount: _storageImages!.images!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      croppedImage = await cropImage(
                          context, _storageImages!.images![index].imagePath!);
                      if (croppedImage != null) {
                        croppedImagePath = croppedImage!.path;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenSelectedFile(
                                imagePath: croppedImagePath!)));
                      }
                    },
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => ScreenCropImage(
                    //         imagePath:
                    //             _storageImages!.images![index].imagePath!))),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.cover,
                        image: FileImage(
                            File(_storageImages!.images![index].imagePath!)),
                      )),
                      // child:
                    ),
                  );
                },
              )
            : Center(
                child: SizedBox(
                    width: phoneSize.width * .5,
                    child:
                        Lottie.asset('assets/lottie/loding_circular_bar.json')),
              ));
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
