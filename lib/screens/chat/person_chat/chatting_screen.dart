import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/chat_model.dart';
import 'package:event_management/screens/chat/person_chat/const/massege.dart';
import 'package:event_management/screens/chat/person_chat/widgets/appbar.dart';
import 'package:event_management/screens/chat/person_chat/widgets/booking_button.dart';
import 'package:event_management/screens/chat/person_chat/widgets/event_req_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../../model/user_model.dart';
import 'model/massege_model.dart';

class ScreenChat extends StatelessWidget {
  ScreenChat({super.key, required this.user, this.chatRoomId});
  final UserModel user;
  final String? chatRoomId;
  TextEditingController chatMessageController = TextEditingController();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: orange,
          title: WidgetChatAppBarTitle(userDetails: user)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore
                    .collection('chatRoom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy('timeStamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final messages = snapshot.data!.docs;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = ChatMessage.fromMap(
                          messages[index].data() as Map<String, dynamic>);

                      // final sender = message['sender'];
                      // final text = message['message'];
                      return ListTile(
                        title: Text(message.sender!),
                        subtitle: Text(message.message!),
                        onTap: () {
                          // Handle tapping on a message if needed
                        },
                      );
                    },
                  );
                },
              ),
              //     GroupedListView<Message, DateTime>(
              //   useStickyGroupSeparators: true,
              //   floatingHeader: true,
              //   elements: messages,
              //   groupBy: (message) => DateTime(
              //       message.time.year, message.time.month, message.time.day),
              //   groupHeaderBuilder: (message) => SizedBox(
              //     height: 40,
              //     child: Center(
              //       child: Card(
              //         color: orange,
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text(
              //             DateFormat.yMMMMd().format(message.time),
              //             style: const TextStyle(color: white, fontSize: 10),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //   itemBuilder: (context, message) {
              //     return Align(
              //       alignment: message.isSentByMe
              //           ? Alignment.centerRight
              //           : Alignment.centerLeft,
              //       child: Card(
              //         elevation: 5,
              //         child: Column(
              //           children: [
              //             Padding(
              //               padding: const EdgeInsets.all(8.0),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Text(message.text),
              //                   Text(
              //                     '${message.time.hour} : ${message.time.minute} am',
              //                     style: const TextStyle(fontSize: 10),
              //                   )
              //                 ],
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     );
              //   },
              // )
            ),
            const Visibility(visible: false, child: EventReqCard()),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[350]),
                child: TextField(
                    controller: chatMessageController,
                    maxLines: 4,
                    minLines: 1,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type your message',
                        contentPadding: EdgeInsets.all(10)))),
            Row(
              children: [
                const Expanded(child: BookingEventButton()),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
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

  void _sendMessage() async {
    final String messageText = chatMessageController.text.trim();

    String? currentUser = auth.currentUser?.uid;
    if (messageText.isNotEmpty) {
      try {
        final newMessage = ChatMessage(
          sender: currentUser,
          message: messageText,
          timeStamp: DateTime.now().microsecondsSinceEpoch.toString(),
        );
        await firebaseFirestore
            .collection('chatRoom')
            .doc(chatRoomId)
            .collection('chats')
            .add(newMessage.toMap())
            .then((value) => chatMessageController.clear());
        log('message uploaded');
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
