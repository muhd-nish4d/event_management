import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';

class ScreenNotifiaction extends StatelessWidget {
  const ScreenNotifiaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white.withOpacity(0),
          title: const Text('Notifications',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1))),
      body: SafeArea(
          child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: RichText(
              text: const TextSpan(
                text: 'Now ',
                style: TextStyle(color: black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'User Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' Following You'),
                ],
              ),
            ),
            subtitle: const Text('Profession'),
          ),
          ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: RichText(
              text: const TextSpan(
                style: TextStyle(color: black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'User Name',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: ' Liked your post'),
                ],
              ),
            ),
            subtitle: const Text('Profession'),
            trailing: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                            'assets/image/5dcc5d9bce6550c6fc59b3c4cffae51c.jpg')))),
          ),
          Card(
            child: ListTile(
              leading: const CircleAvatar(child: Icon(Icons.person)),
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(color: black),
                    children: <TextSpan>[
                      TextSpan(
                          text: '01 / Apr / 2022 Username',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' has a '),
                      TextSpan(
                          text: 'Event type',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              subtitle: Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text('Decline')),
                  TextButton(onPressed: () {}, child: const Text('Accept')),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
