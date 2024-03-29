import 'dart:async';

import 'package:event_management/Bloc/fillup/fillup_bloc.dart';
import 'package:event_management/Bloc/log/login_bloc.dart';
import 'package:event_management/screens/authentication/number.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/user/user_chose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/color.dart';
import '../../const/images.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  String? stringValue;
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        precacheImage(
                const AssetImage('assets/image/back_ground_image.jpg'), context)
            .then((value) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoggedInState) {
                  BlocProvider.of<FillupBloc>(context)
                      .add(FillUpInitialEvent());
                  return BlocBuilder<FillupBloc, FillupState>(
                    builder: (context, state) {
                      if (state is FilledUserState) {
                        return ScreenMain(
                          userDatas: state.userdatas,
                        );
                      } else {
                        return const ScreenUserChose();
                      }
                    },
                  );
                } else if (state is LoggedOutState) {
                  return ScreenLogin();
                } else {
                  return ScreenLogin();
                }
              },
            );
          }));
        });
      },
    );

    // Timer(Duration(milliseconds: 3000), () {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
          child: Container(
        width: screenSize.width * .5,
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage(appLogo))),
      )),
    );
  }
}
