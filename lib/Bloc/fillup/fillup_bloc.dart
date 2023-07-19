import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

part 'fillup_event.dart';
part 'fillup_state.dart';

class FillupBloc extends Bloc<FillupEvent, FillupState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  FillupBloc() : super(FillupInitialState()) {
    on<FillUpInitialEvent>((event, emit) async {
      log('FillupInitialEvent');
      emit(FillupLodingState());

      String? data = await getSharedPreferencesData();
      log('after fectching');
      if (data != null) {
        Map<String, dynamic> userData = jsonDecode(data);
        log('convert to map');
        UserModel userModel = UserModel.formMap(userData);
        log('convert to User Model');
        emit(FilledUserState(userModel));
      } else {
        emit(FillupInitialState());
      }
    });
    on<FilleCompleteEvent>((event, emit) {
      emit(FillupLodingState());
      saveToDataBase(
          userDatas: event.userData,
          profilePic: event.profileImage,
          coverImage: event.coverImage);
    });
  }

  void saveToDataBase(
      {required UserModel userDatas,
      required File? profilePic,
      required File? coverImage}) async {
    try {
      final String? userId = _firebaseAuth.currentUser?.uid;
      // uploading image to firebase
      if (profilePic != null) {
        await storeImageToDatabase('profilePic/$userId', profilePic)
            .then((value) {
          userDatas.profileImage = value;
        });
      }
      if (coverImage != null) {
        await storeImageToDatabase('coverPic/$userId', coverImage)
            .then((value) {
          userDatas.coverImage = value;
        });
      }
      log(userDatas.uid!);
      await _firebaseFirestore
          .collection('users')
          .doc(userId)
          .set(userDatas.toMap());
      saveUserDataToSP(userDatas);
      emit(FilledUserState(userDatas));
    } catch (e) {
      (ErrorWhileFillingState());
      log('heare ${e.toString()}');
    }

    //uplaod to database
  }

  Future<String?> storeImageToDatabase(String ref, File image) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> saveUserDataToSP(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user_model', jsonEncode(user.toMap()));
  }

  Future<String?> getSharedPreferencesData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Retrieving a String value
    String? stringValue = sharedPreferences.getString('user_model');
    return stringValue;
  }
}
