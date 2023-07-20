import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/static/statics.dart';
import 'package:flutter/material.dart';

import '../../../../model/event_reqbooking_model.dart';

class EventReqCard extends StatelessWidget {
  const EventReqCard({
    super.key,
    required this.eventDetails,
    required this.chatRoomId,
  });
  final EventBookingReq eventDetails;
  final String chatRoomId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(eventDetails.partyType ?? 'Event Type',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              Text(eventDetails.aboutParty ?? ''),
              Text(eventDetails.date?.substring(0, 10) ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        declineButtonClicked();
                      },
                      child: const Text('Decline')),
                  TextButton(
                      onPressed: () {
                        acceptButtonClicked();
                        // log(eventDetails.recipientId!);
                      },
                      child: const Text('Accept'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void acceptButtonClicked() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('bookingRequests');

    Query query = collectionRef
        .where('senderId', isEqualTo: eventDetails.senderId)
        .where('recipientId', isEqualTo: eventDetails.recipientId)
        .where('partyType', isEqualTo: eventDetails.partyType);

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      String documentId = documentSnapshot.id;

      collectionRef.doc(documentId).update({
        'status': 'accepted',
      }).then((value) {
        log('Field updated successfully!');
        final parsedDate = Utils.dateTimeConvert(eventDetails.date!);
        Utils.sendMessage(
            message:
                "Thank you for choosing us! We're excited to confirm your ${eventDetails.partyType} on $parsedDate at ${eventDetails.location}. Looking forward to making it a memorable experience for you!",
            chatroomId: chatRoomId,
            isRequest: true);
      }).catchError((error) {
        log('Error updating field: $error');
      });
    } else {
      log('No document found with the specified field data.');
    }
  }

  void declineButtonClicked() async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('bookingRequests');

    Query query = collectionRef
        .where('senderId', isEqualTo: eventDetails.senderId)
        .where('recipientId', isEqualTo: eventDetails.recipientId)
        .where('partyType', isEqualTo: eventDetails.partyType);

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      String documentId = documentSnapshot.id;

      collectionRef.doc(documentId).update({
        'status': 'declined',
      }).then((value) {
        log('Field updated successfully!');
        final parsedDate = Utils.dateTimeConvert(eventDetails.date!);
        Utils.sendMessage(
            message:
                "We regret to inform you that we are unable to accommodate your ${eventDetails.partyType} request for $parsedDate at ${eventDetails.location}. We apologize for any inconvenience caused and hope to serve you in the future",
            chatroomId: chatRoomId,
            isRequest: true);
      }).catchError((error) {
        log('Error updating field: $error');
      });
    } else {
      log('No document found with the specified field data.');
    }
  }
}
