import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/bookings/bottom_navigation.dart';
import 'package:event_management/screens/chat/person_chat/chatting_screen.dart';
import 'package:event_management/screens/profile/professions/tab_views/posts/posts_profession.dart';
import 'package:event_management/screens/profile/professions/tab_views/work/booked_works.dart';
import 'package:event_management/screens/profile/professions/widgets/professions_profile_card.dart';
import 'package:event_management/screens/settings/settigs_menu.dart';
import 'package:event_management/screens/upload/file_seleciton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/fillup/fillup_bloc.dart';
import '../../../const/color.dart';
import '../../../const/sizes.dart';
import '../../../widgets/user_listtile.dart';

class ScreenProfessionsProfile extends StatefulWidget {
  final bool isCleintView;
  final UserModel? userDetails;
  const ScreenProfessionsProfile(
      {super.key, required this.isCleintView, required this.userDetails});

  @override
  State<ScreenProfessionsProfile> createState() =>
      _ScreenProfessionsProfileState();
}

class _ScreenProfessionsProfileState extends State<ScreenProfessionsProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController =
        TabController(length: widget.isCleintView ? 3 : 4, vsync: this);
    BlocProvider.of<FillupBloc>(context).add(FillUpInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                widget.isCleintView
                    ? Row(
                        children: [
                          SizedBox(
                            width: size.width * .5,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const ScreenChat()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: orange,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Text(
                                "Book your's",
                                style: TextStyle(color: white),
                              ),
                            ),
                          ),
                          itemsGapWidth,
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: orange,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: const Text(
                              'Follow',
                              style: TextStyle(color: white),
                            ),
                          ),
                          const SizedBox(width: 15)
                        ],
                      )
                    : Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ScreenFileShowing()));
                              },
                              icon: const Icon(Icons.upload)),
                          IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const ScreenSettingsMenu()));
                              },
                              icon: const Icon(Icons.menu_outlined))
                        ],
                      ),
              ],
              title: widget.isCleintView
                  ? IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(CupertinoIcons.back, color: orange))
                  : ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ScreenBookings()));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Text(
                        'Bookings',
                        style: TextStyle(color: white),
                      ),
                    ),
              floating: true,
              pinned: false,
            ),
            SliverToBoxAdapter(
              child: ProfessionsProfileCard(
                  isCleintView: widget.isCleintView,
                  profession: widget.userDetails!),
            ),
            SliverToBoxAdapter(
              child: DefaultTabController(
                length: widget.isCleintView ? 3 : 4, // Number of tabs
                child: TabBar(
                    controller: tabController,
                    indicatorColor: orange,
                    labelColor: orange,
                    tabs: widget.isCleintView
                        ? const [
                            Tab(
                              text: 'Posts',
                            ),
                            Tab(
                              text: 'Followers',
                            ),
                            Tab(
                              text: 'Following',
                            ),
                          ]
                        : const [
                            Tab(
                              text: 'Posts',
                            ),
                            Tab(
                              text: 'Followers',
                            ),
                            Tab(
                              text: 'Following',
                            ),
                            Tab(
                              text: 'Work',
                            ),
                          ]),
              ),
            ),
          ];
        },
        body: widget.isCleintView
            ? TabBarView(controller: tabController, children: [
                WidgetProfessionsPosts(user: widget.userDetails?.uid),
                const UsersTile(),
                const UsersTile(),
              ])
            : TabBarView(controller: tabController, children: [
                WidgetProfessionsPosts(user: widget.userDetails?.uid),
                const UsersTile(),
                const UsersTile(),
                const WidgetBookedWorks()
              ]),
        //  ValueListenableBuilder(
        //   valueListenable: tabController,
        //   builder: (context, value, child) {
        //     return value == 0
        //         ? ListView.builder(
        //             itemCount: 50, // Example list item count
        //             itemBuilder: (BuildContext context, int index) {
        //               return ListTile(
        //                 title: Text('List Item $index'),
        //               );
        //             },
        //           )
        //         : value == 1
        // ? const SizedBox(
        //     child: Center(
        //       child: Text('1'),
        //     ),
        //   )
        //             : value == 2
        //                 ? const Center(
        //                     child: Text('2'),
        //                   )
        //                 : const Center(
        //                     child: Text('3'),
        //                   );
        //   },
        //   // child:
        // ),
      ),
    );
  }
}
