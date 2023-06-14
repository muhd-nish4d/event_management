import 'dart:async';
import 'dart:developer';

import 'package:event_management/Bloc/fillup/fillup_bloc.dart';
import 'package:event_management/Bloc/log/login_bloc.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/authentication/number.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/user/user_chose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoggedInState) {
               BlocProvider.of<FillupBloc>(context).add(FillUpInitialEvent());
                return BlocBuilder<FillupBloc, FillupState>(
                  builder: (context, state) {
                    if (state is FilledUserState) {
                      return ScreenMain();
                    } else {
                      return ScreenUserChose();
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
      },
    );

    // Timer(Duration(milliseconds: 3000), () {

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Splash Screen'),
      ),
    );
  }

  Future<void> getSharedPreferencesData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    // Retrieving a String value
    stringValue = sharedPreferences.getString('user_model');
  }
}
