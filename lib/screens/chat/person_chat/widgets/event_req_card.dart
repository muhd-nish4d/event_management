import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../model/event_reqbooking_model.dart';

class EventReqCard extends StatelessWidget {
  const EventReqCard({
    super.key,
    required this.eventDetails,
  });
  final EventBookingReq eventDetails;

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
                  TextButton(onPressed: () {}, child: const Text('Decline')),
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
    // &&
    //     'recipientId' == eventDetails.recipientId &&
    //     'partyType' == eventDetails.partyType &&
    //     'date' == eventDetails.date &&
    //     'about' == eventDetails.aboutParty &&
    //     'amount' == eventDetails.amount &&
    //     'place' == eventDetails.location &&
    //     'status' == eventDetails.status);

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      String documentId = documentSnapshot.id;

      collectionRef.doc(documentId).update({
        'status': 'accepted',
      }).then((value) {
        log('Field updated successfully!');
      }).catchError((error) {
        log('Error updating field: $error');
      });
    } else {
      log('No document found with the specified field data.');
    }
  }
}
