import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../widgets/works_card.dart';

class ScreenPending extends StatefulWidget {
  const ScreenPending({super.key});

  @override
  State<ScreenPending> createState() => _ScreenPendingState();
}

class _ScreenPendingState extends State<ScreenPending>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 10, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // DefaultTabController(
        //   length: 10, // Number of tabs
        //   child: TabBar(
        //     isScrollable: true,
        //     controller: tabController,
        //     indicatorColor: orange,
        //     labelColor: orange,
        //     tabs: const [
        //       Tab(
        //         text: 'All',
        //       ),
        //       Tab(
        //         icon: Icon(Icons.place),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.food_bank_rounded),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.checkroom_rounded),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.watch),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.face_2),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.camera_alt),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.people_alt_rounded),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.mic_external_on),
        //       ),
        //       Tab(
        //         icon: Icon(Icons.card_giftcard_rounded),
        //       ),
        //     ],
        //   ),
        // ),
         Expanded(
          child: WidgetCardWorks(),
          // child: TabBarView(controller: tabController, children: const [
          //   SizedBox(
          //     child: WidgetCardWorks(),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('2'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('3'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('4'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('5'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('6'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('7'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('8'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('9'),
          //     ),
          //   ),
          //   SizedBox(
          //     child: Center(
          //       child: Text('10'),
          //     ),
          //   ),
          // ]),
        )
      ],
    );
  }
}
