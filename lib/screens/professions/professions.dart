import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/screens/professions/widgets/professions_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../const/color.dart';
import '../../model/user_model.dart';

class ScreenProfession extends StatefulWidget {
  final bool fromAnotherScreen;
  final String? filterKey;
  const ScreenProfession(
      {super.key, required this.fromAnotherScreen, this.filterKey});

  @override
  State<ScreenProfession> createState() => _ScreenProfessionState();
}

class _ScreenProfessionState extends State<ScreenProfession> {
  TextEditingController searchTe = TextEditingController();

  String searchedQuery = '';

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
                controller: searchTe,
                onChanged: (value) {
                  setState(() {
                    searchedQuery = value;
                  });
                },
              )),
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
                return const Expanded(child:  Center(child: Text('Loading...')));
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
