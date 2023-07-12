import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/const/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/all_user/all_user_bloc_bloc.dart';
import '../../../model/user_model.dart';
import '../../../static/statics.dart';
import '../../../widgets/circular_progress_indicator.dart';
import '../person_chat/chatting_screen.dart';

class CleintsLists extends StatelessWidget {
  const CleintsLists({super.key, required this.userType});
  final String userType;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllUserBlocBloc>(context).add(
        userType == 'profession' ? UserProfessionsEvent() : UserInitialEvent());
    return BlocBuilder<AllUserBlocBloc, AllUserBlocState>(
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
                  // String? currentUser = auth.currentUser?.uid;
                  String roomId = Utils.createChatRoomId(resp: user.uid!);
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
        } else if (state is AllUserBlocLoadedState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final user = state.allUser.where((element) {
                return element.userType == UserType.cleint;
              }).toList();
              final userVal = user[index];
              return ListTile(
                leading: userVal.profileImage == null
                    ? const CircleAvatar(
                        child: Icon(Icons.person),
                      )
                    : userVal.profileImage == ''
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
                                imageUrl: userVal.profileImage!),
                          ),
                title: Text(userVal.ownerName ?? 'Company Name'),
                subtitle: const Text("'message'"),
                //  trailing: Text('0${index + 1} / Jan / 200$index'),
                onTap: () {
                  // String? currentUser = auth.currentUser?.uid;
                  String roomId = Utils.createChatRoomId(resp: userVal.uid!);
                  log(roomId);
                  // user.uid!, currentUser!);
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ScreenChat(user: userVal, chatRoomId: roomId)));
                },
              );
            },
            itemCount: state.allUser.where((element) {
              return element.userType == UserType.cleint;
            }).length,
          );
        } else {
          return const Center(child: Text('Error'));
        }
      },
    );
  }
}
