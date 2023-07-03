import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/chat/person_chat/chatting_screen.dart';
import 'package:event_management/widgets/circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/all_user/all_user_bloc_bloc.dart';
import '../../../model/user_model.dart';

class ScreenChatPersons extends StatelessWidget {
  ScreenChatPersons({super.key});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllUserBlocBloc>(context).add(UserProfessionsEvent());
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(CupertinoIcons.back, color: orange)),
            const Expanded(child: CupertinoSearchTextField()),
            itemsGapWidth
          ]),
          Expanded(
            child: BlocBuilder<AllUserBlocBloc, AllUserBlocState>(
              builder: (context, state) {
                if (state is AllUserBlocLoadingState) {
                  return const CustomProgressIndicator();
                } else if (state is AllProfessionsLoadedState) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      UserModel user = state.allProfessions[index];
                      return ListTile(
                        leading: user.profileImage == null
                            ? const CircleAvatar(
                                child: Icon(Icons.person),
                              )
                            : user.profileImage == ''
                                ? const CircleAvatar(
                                    child: Icon(Icons.person),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            const CircleAvatar(
                                              child: Icon(Icons.person),
                                            ),
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                        imageUrl: user.profileImage!),
                                  ),
                        title: Text(user.companyName ?? 'Company Name'),
                        subtitle: Row(
                          children: [
                            Text(user.profession ?? 'Profession'),
                            itemsGapWidth,
                            const Text("'message'")
                          ],
                        ),
                        // trailing: Text('0${index + 1} / Jan / 200$index'),
                        onTap: () {
                          String? currentUser = auth.currentUser?.uid;
                          String roomId = createChatRoomId(
                              currentUser: currentUser!, resp: user.uid!);
                              log(roomId);
                          // user.uid!, currentUser!);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ScreenChat(user: user, chatRoomId: roomId)));
                        },
                      );
                    },
                    itemCount: state.allProfessions.length,
                  );
                } else {
                  return const Center(child: Text('Error'));
                }
              },
            ),
          ),
        ],
      ),
    ));
  }

  String createChatRoomId({required String currentUser, required String resp}) {
    log(currentUser);
    log(resp);
    if (currentUser[0].toLowerCase().codeUnits[0] >
        resp[0].toLowerCase().codeUnits[0]) {
      return '$currentUser$resp';
    } else {
      return '$resp$currentUser';
    }
  }
}
