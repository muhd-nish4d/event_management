import 'dart:async';

import 'package:event_management/const/color.dart';
import 'package:event_management/const/sizes.dart';
import 'package:event_management/screens/chat/person_chat/const/massege.dart';
import 'package:event_management/screens/chat/person_chat/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import 'model/massege_model.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(backgroundColor: orange, title: const WidgetChatAppBarTitle()),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: GroupedListView<Message, DateTime>(
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                  message.time.year, message.time.month, message.time.day),
              groupHeaderBuilder: (message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: orange,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat.yMMMMd().format(message.time),
                        style: const TextStyle(color: white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, message) {
                return Align(
                  alignment: message.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Card(
                    elevation: 5,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(message.text),
                              Text(
                                '${message.time.hour} : ${message.time.minute} am',
                                style: const TextStyle(fontSize: 10),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
            Visibility(
              // visible: false,
                child: Card(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Event Type',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const Text('About Event'),
                      const Text('10 / Apr / 2022'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {}, child: const Text('Decline')),
                          TextButton(
                              onPressed: () {}, child: const Text('Accept'))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[350]),
                child: const TextField(
                    maxLines: 4,
                    minLines: 1,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message',
                        contentPadding: EdgeInsets.all(10)))),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  onPressed: () async {
                    final data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(const Duration(days: 1)),
                        lastDate: DateTime.now());
                    Timer(const Duration(milliseconds: 60), () {
                      _showMyDialog(context);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: orange),
                  child: const Text('Book your Party',
                      style: TextStyle(color: white)),
                )),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.share,
                    color: white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: orange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog(BuildContext ctx) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Abount Party'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'Your Party type',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
                itemsGapHeight,
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: 'About your Party',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Send Request'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
