import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/user/fillup/widgets/circle_avatar_edit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Bloc/fillup/fillup_bloc.dart';
import '../../../const/professions.dart';

class ScreenUserFillUp extends StatefulWidget {
  final UserType type;
  ScreenUserFillUp({
    super.key,
    required this.type,
  });

  @override
  State<ScreenUserFillUp> createState() => _ScreenUserFillUpState();
}

class _ScreenUserFillUpState extends State<ScreenUserFillUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  ValueNotifier<String?> professionsDropDownNotifier = ValueNotifier(null);

  //  companyName,
  TextEditingController? companyController = TextEditingController();

  TextEditingController ownerController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  ValueNotifier<File?> userCoverImageNotifier = ValueNotifier(null);
  ValueNotifier<File?> userProfileImageNotifier = ValueNotifier(null);

  @override
  void initState() {
    phoneController =
        TextEditingController(text: firebaseAuth.currentUser?.phoneNumber);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocConsumer<FillupBloc, FillupState>(
          listener: (context, state) {
            if (state is FilledUserState) {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ScreenMain()));
            }
          },
          builder: (context, state) {
            if (state is FillupLodingState) {
              return const Center(child: CircularProgressIndicator());
            }
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: orange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {
                storeUserData();
              },
              child: const Text(
                'Done',
                style: TextStyle(color: white, fontWeight: FontWeight.bold),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            widget.type == UserType.profession
                ? Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Column(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: userCoverImageNotifier,
                              builder: (context, value, child) {
                                return Container(
                                    decoration: value == null
                                        ? BoxDecoration(
                                            color: orange,
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4))
                                            ],
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20)))
                                        : BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    userCoverImageNotifier
                                                        .value!.path))),
                                            boxShadow: const [
                                              BoxShadow(
                                                  blurRadius: 4,
                                                  offset: Offset(0, 4))
                                            ],
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                    bottomRight:
                                                        Radius.circular(20))),
                                    height: 150,
                                    width: double.infinity);
                              }),
                          const SizedBox(
                            height: 150,
                            width: double.infinity,
                          ),
                        ],
                      ),
                      Positioned(
                        right: 3,
                        bottom: 150,
                        child: ElevatedButton(
                            onPressed: () {
                              pickImageCover();
                            },
                            child: const Text('Take Cover Image')),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 30),
                          CircleAvatarEdit(notifier: userProfileImageNotifier),
                        ],
                      )
                    ],
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircleAvatarEdit(notifier: userProfileImageNotifier),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    controller: widget.type == UserType.profession
                        ? companyController
                        : ownerController,
                    decoration: InputDecoration(
                        hintText: widget.type == UserType.profession
                            ? 'Company name'
                            : 'Uesr name',
                        border: const OutlineInputBorder()),
                  ),
                  itemsGapHeight,
                  Visibility(
                    visible: widget.type == UserType.profession,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: TextField(
                            controller: ownerController,
                            decoration: InputDecoration(
                                hintText: 'Owner name',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        itemsGapHeight,
                        Card(
                          child: SizedBox(
                              width: double.infinity,
                              child: ValueListenableBuilder(
                                  valueListenable: professionsDropDownNotifier,
                                  builder: (context, value, child) {
                                    return DropdownButton(
                                      value: value,
                                      items: professions.map((String items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items,
                                              overflow: TextOverflow.ellipsis),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        professionsDropDownNotifier.value =
                                            value!;
                                      },
                                    );
                                  })),
                        ),
                      ],
                    ),
                  ),
                  widget.type == UserType.profession
                      ? itemsGapHeight
                      : const SizedBox(),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(
                        hintText: 'Contact No:', border: OutlineInputBorder()),
                  ),
                  itemsGapHeight,
                  TextField(
                    controller: bioController,
                    decoration: const InputDecoration(
                        hintText: 'Bio', border: OutlineInputBorder()),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  // store data to database
  void storeUserData() {
    UserModel userModel = UserModel(
        userType: widget.type,
        companyName: companyController?.text,
        ownerName: ownerController.text.trim(),
        profession: professionsDropDownNotifier.value ?? '',
        phoneNumber: phoneController.text.trim(),
        userBio: bioController.text.trim(),
        profileImage: null,
        coverImage: null,
        uid: firebaseAuth.currentUser?.uid);
    BlocProvider.of<FillupBloc>(context).add(FilleCompleteEvent(userModel,
        userCoverImageNotifier.value, userProfileImageNotifier.value));
  }

  Future<void> pickImageCover() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      userCoverImageNotifier.value = File(pickedImage.path);
    }
  }

  // void saveToDataBase(
  //     {required UserModel userDatas,
  //     required File? profilePic,
  //     required File? coverImage}) async {
  //   try {
  //     final String? userId = firebaseAuth.currentUser?.uid;
  //     // uploading image to firebase
  //     if (profilePic != null) {
  //       await storeImageToDatabase('profilePic/$userId', profilePic)
  //           .then((value) {
  //         userDatas.profileImage = value;
  //       });
  //     }
  //     if (coverImage != null) {
  //       await storeImageToDatabase('coverPic/$userId', coverImage)
  //           .then((value) {
  //         userDatas.coverImage = value;
  //       });
  //     }
  //     log(userDatas.uid!);
  //     await _firebaseFirestore
  //         .collection('users')
  //         .doc(userId)
  //         .set(userDatas.toMap());
  //     saveUserDataToSP(userDatas);
  //   } catch (e) {
  //     log(e.toString());
  //   }

  //   //uplaod to database
  // }

  // Future<String?> storeImageToDatabase(String ref, File image) async {
  //   UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(image);
  //   TaskSnapshot snapshot = await uploadTask;
  //   String downloadUrl = await snapshot.ref.getDownloadURL();
  //   return downloadUrl;
  // }

  // Future<void> saveUserDataToSP(UserModel user) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   await sharedPreferences.setString('user_model', jsonEncode(user.toMap()));
  // }
}
