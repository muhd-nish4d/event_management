import 'dart:developer';

import 'package:event_management/const/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'otp.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  static String verify = '';

  TextEditingController countryController = TextEditingController(text: '+91');
  // TextEditingController phoneController = TextEditingController();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    Size phoneSize = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: indigo),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        SizedBox(
                            width: 40,
                            child: TextField(
                              controller: countryController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: '+91'),
                            )),
                        const VerticalDivider(thickness: 2),
                        Expanded(
                            child: TextField(
                          onChanged: (value) {
                            phoneNumber = value;
                            log(phoneNumber);
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Phone',
                          ),
                        )),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: "${countryController.text + phoneNumber}",
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          ScreenLogin.verify = verificationId;
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ScreenOTP()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: const Text(
                      'Send OTP',
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
