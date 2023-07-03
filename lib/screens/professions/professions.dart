import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/screens/professions/widgets/professions_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/all_user/all_user_bloc_bloc.dart';
import '../../const/color.dart';
import '../../model/user_model.dart';
import '../../widgets/circular_progress_indicator.dart';

class ScreenProfession extends StatefulWidget {
  final bool fromAnotherScreen;
  final String? filterKey;
  const ScreenProfession(
      {super.key, required this.fromAnotherScreen, this.filterKey});

  @override
  State<ScreenProfession> createState() => _ScreenProfessionState();
}

class _ScreenProfessionState extends State<ScreenProfession> {

  String searchedQuery = '';

  // @override
  // void initState() {
  //   BlocProvider.of<AllUserBlocBloc>(context).add(UserProfessionsEvent());
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              widget.fromAnotherScreen
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.back, color: orange))
                  : const SizedBox(),
              Expanded(
                  child: CupertinoSearchTextField(
                onChanged: (value) {
                  // BlocProvider.of<AllUserBlocBloc>(context)
                  //     .add(UserSearchEvent(value));
                  setState(() {
                    searchedQuery = value;
                  });
                },
              )),
            ],
          ),
        ),
        // BlocBuilder<AllUserBlocBloc, AllUserBlocState>(
        //   builder: (context, state) {
        //     if (state is AllProfessionsLoadedState) {
        //       // log('All user bloc loaded');
        //       return Expanded(
        //           child: state.allProfessions.isEmpty
        //               ? const Center(child: Text('No providers here'))
        //               // : Text('${state.allUser.length}')
        //               : GridView.builder(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10),
        //                   gridDelegate:
        //                       const SliverGridDelegateWithFixedCrossAxisCount(
        //                           childAspectRatio: .75,
        //                           mainAxisSpacing: 10,
        //                           crossAxisSpacing: 10,
        //                           crossAxisCount: 2),
        //                   itemBuilder: (context, index) {
        //                     var userData = state.allProfessions[index];
        //                     return ProfessionsCard(professions: userData);
        //                   },
        //                   itemCount: state.allProfessions.length,
        //                 ));
        //     } else if (state is AllUserBlocLoadingState) {
        //       return const Expanded(child: CustomProgressIndicator());
        //     } else if (state is AllUserBlocErrorState) {
        //       return Text(state.error!);
        //     } else if (state is AllProfessionsSearchState) {
        //       return Expanded(
        //           child: state.searchedProfessions.isEmpty
        //               ? const Center(child: Text('No providers here'))
        //               // : Text('${state.allUser.length}')
        //               : GridView.builder(
        //                   padding: const EdgeInsets.symmetric(horizontal: 10),
        //                   gridDelegate:
        //                       const SliverGridDelegateWithFixedCrossAxisCount(
        //                           childAspectRatio: .75,
        //                           mainAxisSpacing: 10,
        //                           crossAxisSpacing: 10,
        //                           crossAxisCount: 2),
        //                   itemBuilder: (context, index) {
        //                     var userData = state.searchedProfessions[index];
        //                     return ProfessionsCard(professions: userData);
        //                   },
        //                   itemCount: state.searchedProfessions.length,
        //                 ));
        //     } else {
        //       return const Center(child: Text('Loading...'));
        //     }
        //   },
        // )
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Expanded(child: CustomProgressIndicator());
              }

              var professionsDocs = search(searchedQuery, snapshot);
              // snapshot.data?.docs
              //     .where((doc) => doc['userType'] == 'profession')
              //     .toList();

              return Expanded(
                  child: professionsDocs.isEmpty
                      ? const Center(child: Text('No providers here'))
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: .75,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) {
                            var userData = professionsDocs?[index].data();
                            var professions = UserModel.formMap(
                                userData as Map<String, dynamic>);
                            // log(hi.userType.toString());
                            return ProfessionsCard(professions: professions);
                          },
                          itemCount: professionsDocs?.length,
                        ));
            })
      ],
    );
  }

  search(String que, AsyncSnapshot<QuerySnapshot<Object?>> snap) {
    if (que.isEmpty && widget.filterKey != null) {
      return snap.data?.docs.where((doc) {
        return doc['userType'] == 'profession' &&
            doc['profession'] == widget.filterKey;
      }).toList();
    }
    dynamic docs;
    if (widget.filterKey != null) {
      docs = snap.data?.docs.where((element) {
        return element['profession'] == widget.filterKey;
      });
    } else {
      docs = snap.data?.docs;
    }
    return docs.where(
      (doc) {
        return doc['userType'] == 'profession' &&
            doc['companyName']
                .toString()
                .toLowerCase()
                .contains(que.toLowerCase());
      },
    ).toList();
  }
}
