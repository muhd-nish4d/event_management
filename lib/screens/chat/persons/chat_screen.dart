import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/chat/person_chat/chatting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenChatPersons extends StatelessWidget {
  const ScreenChatPersons({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            const Expanded(child: CupertinoSearchTextField()),
            itemsGapWidth
          ]),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                  ),
                  title: const Text('Company Name'),
                  subtitle: Row(
                    children: const [
                      Text('Profession'),
                      itemsGapWidth,
                      Text("'message'")
                    ],
                  ),
                  trailing: Text('0${index + 1} / Jan / 200$index'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ScreenChat()));
                  },
                );
              },
              itemCount: 9,
            ),
          ),
        ],
      ),
    ));
  }
}
