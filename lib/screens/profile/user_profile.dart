import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/profile/cleint/cleint_pro_screen.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:event_management/widgets/circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScreenUserProfile extends StatelessWidget {
  final bool isProfessional;
  const ScreenUserProfile({super.key, required this.isProfessional});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userdatasTab(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.userType == UserType.profession) {
            return ScreenProfessionsProfile(
                isCleintView: false, userDetails: snapshot.data);
          } else {
            return ScreenCleintProfile();
          }
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else {
          return const CustomProgressIndicator();
        }
      },
    );

    // BlocBuilder<FillupBloc, FillupState>(
    //   builder: (context, state) {
    //     if (state is FilledUserState) {
    //       if (state.userdatas.userType == UserType.profession) {
    //         return ScreenProfessionsProfile(
    //             isCleintView: false, userDetails: state.userdatas);
    //       } else {
    //         return const ScreenCleintProfile();
    //       }
    //     } else {
    //       return const Scaffold();
    //     }
    //   },
    // );
    // : const ScreenCleintProfile();
  }

  Future<UserModel> userdatasTab() async {
    final String currentUser = FirebaseAuth.instance.currentUser?.uid ?? '';
    final datas = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get();
    final mapedData = datas.data();
    final UserModel userDatasFrom = UserModel.formMap(mapedData!);
    return userDatasFrom;
  }
}
