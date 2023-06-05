import 'dart:developer';

import 'package:event_management/const/color.dart';
import 'package:event_management/screens/authentication/number.dart';
import 'package:event_management/screens/user/user_chose.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

class ScreenOTP extends StatelessWidget {
  ScreenOTP({super.key});

  TextEditingController countryController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController();

  ValueNotifier<bool> isVisible = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    var code = '';
    final FirebaseAuth auth = FirebaseAuth.instance;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
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
              SizedBox(height: 10),
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
                onChanged: (value) {
                  code = value;
                },
                // validator: (s) {
                //   return s == ScreenLogin.verify ? null : 'Pin is incorrect';
                // },
                // pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              SizedBox(
                width: phoneSize.width * .3,
                child: ValueListenableBuilder(
                  valueListenable: isVisible,
                  builder: (context, value, child) {
                    return Visibility(
                        visible: value,
                        child: LottieBuilder.asset(
                            'assets/lottie/loading_plane_lot.json'));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        isVisible.value = true;
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: ScreenLogin.verify,
                                smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ScreenUserChose(),
                        ));
                      } catch (e) {
                        log('Wrong OTP');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Verify Phone Number',
                      style: TextStyle(color: white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
