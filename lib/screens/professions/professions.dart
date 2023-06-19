import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/screens/professions/widgets/professions_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/all_user/all_user_bloc_bloc.dart';
import '../../model/user_model.dart';

class ScreenProfession extends StatelessWidget {
  final bool fromAnotherScreen;
  const ScreenProfession({super.key, required this.fromAnotherScreen});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllUserBlocBloc>(context).add(UserInitialEvent());
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              fromAnotherScreen
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back))
                  : const SizedBox(),
              const Expanded(child: CupertinoSearchTextField()),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...');
              }

              var professionsDocs = snapshot.data?.docs
                  .where((doc) => doc['userType'] == 'profession')
                  .toList();

              return Expanded(
                  child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: .75,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var userData = professionsDocs?[index].data();
                  var professions =
                      UserModel.formMap(userData as Map<String, dynamic>);
                  // log(hi.userType.toString());
                  return ProfessionsCard(professions: professions);
                },
                itemCount: professionsDocs?.length,
              ));
            })
        // BlocBuilder<AllUserBlocBloc, AllUserBlocState>(
        //   builder: (context, state) {
        //     if (state is AllUserBlocLoadingState) {
        //       return CircularProgressIndicator();
        //     }
        //     if (state is AllUserBlocLoadedState) {
        //       Text('data');
        //     }
        //     return Container();
        //   },
        // )
      ],
    );
  }
}
