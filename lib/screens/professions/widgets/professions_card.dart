import 'package:event_management/screens/chat/person_chat/chatting_screen.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:event_management/screens/profile/user_profile.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';

class ProfessionsCard extends StatelessWidget {
  const ProfessionsCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [BoxShadow(blurRadius: 4)]),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const ScreenProfessionsProfile(isCleintView: true)));
              },
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: const BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        height: double.infinity,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 100,
                              ),
                              const Text('Owner Name'),
                              const Text(
                                'Company Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const Text('Profession'),
                              Row(
                                children: const [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 15,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: grey,
                                    size: 15,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image:
                                  AssetImage('assets/image/userbackcard.jpg'))),
                    ),
                  ),
                  const Positioned(
                      // alignment: Alignment.centerLeft,
                      top: 50,
                      left: 20,
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: grey,
                        child: Icon(
                          Icons.person,
                          color: white,
                          size: 40,
                        ),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: white,
                ),
                child: Column(
                  children: [
                    const Divider(
                      height: 0,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ScreenChat()));
                            },
                            child: const Text('Chat'),
                          ),
                          const VerticalDivider(),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Follow'),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
