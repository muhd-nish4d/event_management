import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../const/color.dart';
import '../../model/post_model.dart';

part 'post_image_event.dart';
part 'post_image_state.dart';

class PostImageBloc extends Bloc<PostImageEvent, PostImageState> {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  PostImageBloc() : super(PostImageInitial()) {
    on<UploadImagEvent>((event, emit) async {
      emit(PostLoadingState());
      saveToDataBase(
          image: event.imagePathForUpload, postModel: event.postModel);
      emit(PostUploadedState());
    });
  }

  void saveToDataBase({
    required String image,
    required Post postModel,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await uploadImageToFirebase(imagePathId: image, file: File(image))
          .then((value) {
        postModel.imagePath = value;
      });
      if (user == null) {
        log('user null');
      }
      postModel.creatorId = user!.uid;
      postModel.creatorImageId = postModel.id! + postModel.creatorId!;
      await firestore.collection('posts').doc().set(postModel.toMap());
      log('uploaded + ${postModel.creatorImageId}');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> uploadImageToFirebase(
      {required String imagePathId, required File file}) async {
    String fileName = 'post/jpeg';
    UploadTask uploadTask =
        storage.ref().child('posts$imagePathId/$fileName').putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
