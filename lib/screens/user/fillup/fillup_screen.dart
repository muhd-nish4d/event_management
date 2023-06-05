import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/bottum_nav.dart';
import 'package:event_management/screens/user/fillup/widgets/circle_avatar_edit.dart';
import 'package:flutter/material.dart';

class ScreenUserFillUp extends StatelessWidget {
  const ScreenUserFillUp({super.key, required this.isFullShow});

  final bool isFullShow;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: orange,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => ScreenMain()));
          },
          child: const Text(
            'Done',
            style: TextStyle(color: white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            isFullShow
                ? Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  color: orange,
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 4, offset: Offset(0, 4))
                                  ],
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              height: 150,
                              width: double.infinity),
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
                            onPressed: () {},
                            child: const Text('Take Cover Image')),
                      ),
                      Row(
                        children: const [
                          SizedBox(width: 30),
                          CircleAvatarEdit(),
                        ],
                      )
                    ],
                  )
                : const Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: CircleAvatarEdit(),
                  ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: isFullShow ? 'Company name' : 'Uesr name',
                        border: const OutlineInputBorder()),
                  ),
                  itemsGapHeight,
                  Visibility(
                    visible: isFullShow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: screenSize.width * .45,
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText: 'Owner name',
                                border: OutlineInputBorder()),
                          ),
                        ),
                        SizedBox(
                          width: screenSize.width * .45,
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText: 'Profession',
                                border: OutlineInputBorder()),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isFullShow ? itemsGapHeight : const SizedBox(),
                  const TextField(
                    decoration: InputDecoration(
                        hintText: 'Contact No:', border: OutlineInputBorder()),
                  ),
                  itemsGapHeight,
                  const TextField(
                    decoration: InputDecoration(
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
}
