import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';

part 'followunfollow_event.dart';
part 'followunfollow_state.dart';

class FollowUnfollowBloc
    extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // bool? isFollowed;
  FollowUnfollowBloc() : super(FollowUnfollowInitialState()) {
    on<UserFollowInitialEvent>((event, emit) {
      emit(FollowUnfollowLoadingState());
      try {
        final isFollowed = event.user.isFollowed(firebaseAuth.currentUser!.uid);
        log(isFollowed.toString());
        if (isFollowed == true) {
          emit(FollowedState());
        } else {
          emit(UnfollowedSate());
        }
      } catch (e) {
        emit(FollowErrorState(e.toString()));
      }
    });
    on<UserFollowEvent>((event, emit) async {
      emit(FollowUnfollowLoadingState());
      try {
        await followUser(event.userId);
        emit(FollowedState());
      } catch (e) {
        emit(FollowErrorState(e.toString()));
      }
    });
    on<UserUnfollowEvent>((event, emit) async {
      emit(FollowUnfollowLoadingState());
      try {
        await unfollowUser(event.userId);
        emit(UnfollowedSate());
      } catch (e) {
        emit(FollowErrorState(e.toString()));
      }
    });
  }

  Future<void> followUser(String userId) async {
    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    // firebaseFirestore.collection('users').doc(userId).update({
    //   'followers': FieldValue.arrayUnion([currentUserId]),
    // }).then((value) {
    //   emit(FollowedState());
    //   log('Error following user $userId');
    // }).catchError((error) {
    //   emit(FollowErrorState());
    //   log('Error following user $userId: $error');
    // });

    await firebaseFirestore.collection('users').doc(userId).update({
      'follwers': FieldValue.arrayUnion([currentUserId])
    });
    log('following user $userId');
  }

  Future<void> unfollowUser(String userId) async {
    final String currentUserId = firebaseAuth.currentUser?.uid ?? '';

    // firebaseFirestore.collection('users').doc(userId).update({
    //   'followers': FieldValue.arrayRemove([currentUserId]),
    // }).then((value) {
    //   // Update the UI or show a success message
    //   print('Successfully unfollowed user $userId');
    // }).catchError((error) {
    //   // Handle error
    //   print('Error unfollowing user $userId: $error');
    // });

    await firebaseFirestore.collection('users').doc(userId).update({
      'follwers': FieldValue.arrayRemove([currentUserId])
    });
    log('unfollowed user $userId');
  }
}
