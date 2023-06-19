import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/user_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  LoginBloc() : super(LogInitialState()) {
    User? currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(LoggedInState(currentUser));
    } else {
      emit(LoggedOutState());
    }
    on<PhoneNumberSubmittedEvent>((event, emit) {
      emit(LogLoadingState());
      sentOtp(event.phoneNumber);
    });
    on<OtpVerificationEvent>((event, emit) {
      emit(LogLoadingState());
      verifyOtp(event.otp);
      getUserData(currentUser!);
    });
    on<LogOutEvent>((event, emit) {
      emit(LogLoadingState());
      try {
        logOut();
        emit(LoggedOutState());
      } catch (e) {
        log(e.toString());
      }
    });
  }

  String? phoneVerificationId;

  void sentOtp(String phoneNumber) async {
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(ErrorState(error.message.toString()));
      },
      codeSent: (verificationId, forceResendingToken) {
        phoneVerificationId = verificationId;
        emit(CodeSentState());
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  void verifyOtp(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: phoneVerificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  void signInWithPhone(PhoneAuthCredential credential) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      if (userCredential.user != null) {
        DocumentSnapshot documentSnapshot = await firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        UserModel usersss =
            UserModel.formMap(documentSnapshot.data() as Map<String, dynamic>);
        if (documentSnapshot.exists) {
          saveUserDataToSP(usersss);
          emit(UserFilledState());
        } else {
          emit(LoggedInState(userCredential.user!));
        }
      }
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  void logOut() async {
    await firebaseAuth.signOut();
    clearSharedPreferencesData();
  }

  Future<void> clearSharedPreferencesData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  Future<void> getUserData(User user) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(user.uid).get();

    if (documentSnapshot.exists) {
      UserModel usersss =
          UserModel.formMap(documentSnapshot.data() as Map<String, dynamic>);

      if (documentSnapshot.data() != null) {
        saveUserDataToSP(usersss);
        emit(UserFilledState());
      } else {
        emit(LoggedInState(user));
      }
    }
  }

  Future<void> saveUserDataToSP(UserModel user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('user_model', jsonEncode(user.toMap()));
  }
}
