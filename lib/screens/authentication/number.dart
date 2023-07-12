import 'dart:developer';

import 'package:event_management/Bloc/log/login_bloc.dart';
import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../const/images.dart';
import '../../widgets/image_background.dart';
import 'otp.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});

  TextEditingController countryController = TextEditingController(text: '+91');
  // TextEditingController phoneController = TextEditingController();
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Size phoneSize = MediaQuery.of(context).size;
    return Scaffold(
        body: WidgetBackGround(
      image: backgroundImage,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: phoneSize.width * .5,
                    child: Lottie.asset(
                        'assets/lottie/otp_verification_lot.json')),
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
                              child: TextFormField(
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
                    child: BlocConsumer<LoginBloc, LoginState>(
                      listener: (context, state) {
                        if (state is CodeSentState) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ScreenOTP(
                                  phoneNumber:
                                      "${countryController.text + phoneNumber}")));
                        } else if (state is ErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.error)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is LogLoadingState) {
                          return SizedBox(
                            width: phoneSize.width * .2,
                            height: phoneSize.width * .2,
                            child: LottieBuilder.asset(
                                'assets/lottie/loading_plane_lot.json'),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () async {
                            if (phoneNumber.isEmpty ||
                                phoneNumber.length != 10) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Enter a valid phone number')),
                              );
                            } else {
                              BlocProvider.of<LoginBloc>(context).add(
                                  PhoneNumberSubmittedEvent(
                                      "${countryController.text + phoneNumber}"));
                            }

                            // BlocProvider.of<LoginBloc>(context).sentOtp(
                            //     "${countryController.text + phoneNumber}");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const Text(
                            'Send OTP',
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
