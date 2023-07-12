import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/chat_model.dart';
import 'package:event_management/screens/chat/person_chat/widgets/appbar.dart';
import 'package:event_management/screens/chat/person_chat/widgets/booking_button.dart';
import 'package:event_management/screens/chat/person_chat/widgets/event_req_card.dart';
import 'package:event_management/static/statics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/event_reqbooking_model.dart';
import '../../../model/user_model.dart';

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
          backgroundColor: primaryColor,
          title: WidgetChatAppBarTitle(userDetails: user)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: StreamBuilder<QuerySnapshot>(
                stream: firebaseFirestore
                    .collection('chatRoom')
                    .doc(chatRoomId)
                    .collection('chats')
                    .orderBy('timeStamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
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
                      return Align(
                        alignment: message.sender == auth.currentUser?.uid
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Card(
                            color: message.sender == auth.currentUser?.uid
                                ? primaryColor
                                : Colors.grey[50],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                message.message!,
                                style: TextStyle(
                                    color:
                                        message.sender == auth.currentUser?.uid
                                            ? white
                                            : black),
                              ),
                            )),
                      );
                      // ListTile(
                      //   title: Text(message.sender!),
                      //   subtitle: Text(message.message!),
                      //   onTap: () {
                      //     // Handle tapping on a message if needed
                      //   },
                      // );
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
              //         color: primaryColor,
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
            StreamBuilder<List<EventBookingReq>>(
              stream: Utils.getBookingRequestsStream(
                  user.uid!), // Replace with your own stream
              builder: (BuildContext context,
                  AsyncSnapshot<List<EventBookingReq>> snapshot) {
                if (snapshot.hasError) {
                  // Handle the error state
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for data
                  return const CircularProgressIndicator();
                }

                List<EventBookingReq> bookingRequests = snapshot.data ?? [];

                if (bookingRequests.isEmpty) {
                  // Show a message when there are no booking requests
                  return const Text('');
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: bookingRequests.length,
                  itemBuilder: (BuildContext context, int index) {
                    EventBookingReq bookingReq = bookingRequests[index];
                    log('sender ${bookingReq.senderId} == ${user.uid}');
                    log('reci ${bookingReq.recipientId} == ${auth.currentUser?.uid}');
                    // Retrieve event details from the booking request or fetch from Firestore

                    // String eventType = bookingReq.;
                    // DateTime eventDate = bookingReq.eventDate;

                    return EventReqCard(eventDetails: bookingReq);
                  },
                );
              },
            ),

            // const Visibility(visible: false, child: EventReqCard()),
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
                Expanded(
                    child: BookingEventButton(
                  recipientId: user.uid!,
                )),
                IconButton(
                  onPressed: () {
                    _sendMessage();
                  },
                  icon: const Icon(
                    Icons.share,
                    color: white,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor: primaryColor,
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
