import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'cleint_screen.dart';

class ScreenChatPersons extends StatefulWidget {
  const ScreenChatPersons({super.key});

  @override
  State<ScreenChatPersons> createState() => _ScreenChatPersonsState();
}

class _ScreenChatPersonsState extends State<ScreenChatPersons> {
  final String currentUser = FirebaseAuth.instance.currentUser?.uid ?? '';

  late final String userType;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser)
        .get()
        .then((value) {
      if (value.exists) {
        // Document exists, retrieve the field value
        setState(() {
          userType = value.get('userType');
        });
        log('Field value: $userType');
      } else {
        log('Document does not exist');
      }
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
            child: userType == 'profession'
                ? Column(
                    children: [
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                Icon(CupertinoIcons.back, color: primaryColor)),
                        const Expanded(child: CupertinoSearchTextField()),
                        itemsGapWidth
                      ]),
                      const SizedBox(
                          height: 50,
                          child: TabBar(
                              tabs: [Text('Professions'), Text('Cleints')])),
                      Expanded(
                          child: TabBarView(children: [
                        CleintsLists(userType: 'profession'),
                        CleintsLists(userType: 'cleint')
                      ]))
                    ],
                  )
                : Column(
                    children: [
                      Row(children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                Icon(CupertinoIcons.back, color: primaryColor)),
                        const Expanded(child: CupertinoSearchTextField()),
                        itemsGapWidth
                      ]),
                      Expanded(child: CleintsLists(userType: 'profession'))
                    ],
                  )),
      ),
    );
    // Scaffold(
    //     body: SafeArea(
    //   child: Column(
    //     children: [
    //       Row(children: [
    //         IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             icon: Icon(CupertinoIcons.back, color: primaryColor)),
    //         const Expanded(child: CupertinoSearchTextField()),
    //         itemsGapWidth
    //       ]),
    //       Expanded(
    //         child: BlocBuilder<AllUserBlocBloc, AllUserBlocState>(
    //           builder: (context, state) {
    //             if (state is AllUserBlocLoadingState) {
    //               return const CustomProgressIndicator();
    //             } else if (state is AllProfessionsLoadedState) {
    //               return ListView.builder(
    //                 itemBuilder: (context, index) {
    //                   UserModel user = state.allProfessions[index];
    //                   return ListTile(
    //                     leading: user.profileImage == null
    //                         ? const CircleAvatar(
    //                             child: Icon(Icons.person),
    //                           )
    //                         : user.profileImage == ''
    //                             ? const CircleAvatar(
    //                                 child: Icon(Icons.person),
    //                               )
    //                             : ClipRRect(
    //                                 borderRadius: BorderRadius.circular(50),
    //                                 child: CachedNetworkImage(
    //                                     placeholder: (context, url) =>
    //                                         const CircleAvatar(
    //                                           child: Icon(Icons.person),
    //                                         ),
    //                                     fit: BoxFit.cover,
    //                                     width: 50,
    //                                     height: 50,
    //                                     imageUrl: user.profileImage!),
    //                               ),
    //                     title: Text(user.companyName ?? 'Company Name'),
    //                     subtitle: Row(
    //                       children: [
    //                         Text(user.profession ?? 'Profession'),
    //                         itemsGapWidth,
    //                         const Text("'message'")
    //                       ],
    //                     ),
    //                     // trailing: Text('0${index + 1} / Jan / 200$index'),
    //                     onTap: () {
    //                       // String? currentUser = auth.currentUser?.uid;
    //                       String roomId =
    //                           Utils.createChatRoomId(resp: user.uid!);
    //                       log(roomId);
    //                       // user.uid!, currentUser!);
    //                       Navigator.of(context).push(MaterialPageRoute(
    //                           builder: (context) =>
    //                               ScreenChat(user: user, chatRoomId: roomId)));
    //                     },
    //                   );
    //                 },
    //                 itemCount: state.allProfessions.length,
    //               );
    //             } else {
    //               return const Center(child: Text('Error'));
    //             }
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }
}
