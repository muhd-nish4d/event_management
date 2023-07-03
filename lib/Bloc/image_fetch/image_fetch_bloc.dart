import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:event_management/model/post_model.dart';

part 'image_fetch_event.dart';
part 'image_fetch_state.dart';

class ImageFetchBloc extends Bloc<ImageFetchEvent, ImageFetchState> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  List<Post> allPosts = [];
  ImageFetchBloc() : super(ImageFetchInitial()) {
    on<ImageFetchInitialEvent>((event, emit) async {
      emit(ImageFetchLoadingState());
      await fetchPosts();
      emit(ImageFetchLoadedState(allPosts));
    });
  }
  Future<void> fetchPosts() async {
    allPosts.clear();
    try {
      final postSnapshot = await firebaseFirestore.collection('posts').get();
      final postDocuments = postSnapshot.docs;

      for (var doc in postDocuments) {
        // Extract the data from each document
        Map<String, dynamic> data = doc.data();

        // Create a UserModel object using the extracted data
        Post post = Post.fromMap(data);

        // Add the UserModel object to the global list
        allPosts.add(post);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
