import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/profile/cleint/cleint_pro_screen.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/fillup/fillup_bloc.dart';

class ScreenUserProfile extends StatelessWidget {
  final bool isProfessional;
  const ScreenUserProfile({super.key, required this.isProfessional});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FillupBloc, FillupState>(
      builder: (context, state) {
        if (state is FilledUserState) {
          if (state.userdatas.userType == UserType.profession) {
            return ScreenProfessionsProfile(
                isCleintView: false, userDetails: state.userdatas);
          } else {
            return const ScreenCleintProfile();
          }
        } else {
          return const Scaffold();
        }
      },
    );
    // : const ScreenCleintProfile();
  }
}
