import 'dart:developer';

import 'package:event_management/const/color.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/user/user_chose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../../Bloc/log/login_bloc.dart';
import '../../const/images.dart';
import '../../widgets/image_background.dart';

class ScreenOTP extends StatelessWidget {
  final String phoneNumber;
  ScreenOTP({super.key, required this.phoneNumber});
  var code = '';

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: orange),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    Size phoneSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: WidgetBackGround(
      image: backgroundImage,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: phoneSize.width * .5,
                    child:
                        Lottie.asset('assets/lottie/otp_verification_lot.json')),
                const SizedBox(height: 10),
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'We need to register your phone\nbefore getting started !',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Pinput(
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  length: 6,
                  onChanged: (value) => code = value,
                  showCursor: true,
                  onCompleted: (pin) => log(pin),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is UserFilledState) {
                          // BlocProvider.of<FillupBloc>(context).add(FillUpInitialEvent());
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (context) => ScreenMain()));
                        } else if (state is LoggedInState) {
                          Navigator.of(context)
                              .popUntil((route) => route.isFirst);
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const ScreenUserChose(),
                          ));
                        } else if (state is ErrorState) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(state.error)));
                        }
                      },
                      builder: (context, state) {
                        if (state is LogLoadingState) {
                          SizedBox(
                            width: phoneSize.width * .3,
                            child: LottieBuilder.asset(
                                'assets/lottie/loading_plane_lot.json'),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            BlocProvider.of<LoginBloc>(context)
                                .add(OtpVerificationEvent(code));
                            // BlocProvider.of<LoginBloc>(context).verifyOtp(code);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'Verify Phone Number',
                            style: TextStyle(color: white),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
