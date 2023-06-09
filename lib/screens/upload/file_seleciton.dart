import 'dart:developer';
import 'dart:io';
import 'package:all_gallery_images/model/StorageImages.dart';
import 'package:event_management/screens/upload/selected_file.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:all_gallery_images/all_gallery_images.dart';
import 'package:lottie/lottie.dart';

ValueNotifier<StorageImages?> images = ValueNotifier(null);

class ScreenFileShowing extends StatefulWidget {
  const ScreenFileShowing({Key? key}) : super(key: key);

  @override
  State<ScreenFileShowing> createState() => _ScreenFileShowingState();
}

class _ScreenFileShowingState extends State<ScreenFileShowing> {
  StorageImages? _storageImages;
  // late StorageImages uniqueImag;

  @override
  void initState() {
    super.initState();
    getImagesFromGallery();
  }

  Future<void> getImagesFromGallery() async {
    StorageImages? storageImages;
    // final set = <Images>{};

    try {
      storageImages = await GalleryImages().getStorageImages();
      // uniqueImag = storageImages!;
      // uniqueImag.images?.clear();
      // for (var element in storageImages.images!) {
      //   if (set.add(element)) {
      //     uniqueImag.images?.add(element);
      //   }
      // }
    } catch (error) {
      debugPrint(error.toString());
    }

    // StorageImages? removeDuplicates(StorageImages list) {
    //   final set = <Images>{};
    //   StorageImages uniqueList = storageImages!;

    //   uniqueList.images?.clear();
    //   for (final item in list.images!) {
    //     if (set.add(item)) {
    //       uniqueList.images?.add(item);
    //     }
    //   }

    //   return uniqueList;
    // }

    // StorageImages? nish;

    // nish = removeDuplicates(storageImages!);

    setState(() {
      // log(uniqueImag.images!.length.toString());
      // _storageImages = uniqueImag;
      _storageImages = storageImages;
    });

    // setState(() {
    //   if (storageImages != null) {
    //     final List<Images> uniqueImages = [];
    //     final List<Images> storedImages = [];

    //     for (final newImage in storageImages.images!) {
    //       bool isDuplicate = false;
    //       for (final oldImage in _storageImages?.images ?? []) {
    //         if (newImage.imagePath == oldImage.imagePath) {
    //           isDuplicate = true;
    //           break;
    //         }
    //       }
    //       if (!isDuplicate) {
    //         uniqueImages.add(newImage);
    //       }
    //     }

    //     if (_storageImages != null) {
    //       _storageImages!.images?.addAll(uniqueImages);
    //     } else {
    //       _storageImages = StorageImages(images: uniqueImages);
    //     }
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  log(_storageImages!.images!.length.toString());
                },
                icon: Icon(Icons.abc))
          ],
        ),
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
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScreenSelectedFile(
                            imagePath:
                                _storageImages!.images![index].imagePath!))),
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
            :  Center(
                child: SizedBox(
                    width: phoneSize.width * .5,
                    child: Lottie.asset(
                        'assets/lottie/loding_circular_bar.json')),
              ));
  }
}
