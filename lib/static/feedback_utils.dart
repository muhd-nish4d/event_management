import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/model/event_reqbooking_model.dart';

class FeedbackUtils {
  static Future<void> feedbackSubmitted(EventBookingReq request,
      {required double rating, required String feedback}) async {
    final CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('bookingRequests');

    Query query = collectionRef
        .where('senderId', isEqualTo: request.senderId)
        .where('recipientId', isEqualTo: request.recipientId)
        .where('about', isEqualTo: request.aboutParty)
        .where('amount', isEqualTo: request.amount)
        .where('date', isEqualTo: request.date)
        .where('place', isEqualTo: request.location)
        .where('partyType', isEqualTo: request.partyType);

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.size > 0) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs[0];

      String documentId = documentSnapshot.id;

      collectionRef.doc(documentId).update({
        'feedback': {'rating': rating, 'feedback': feedback},
      });
    } else {
      log('No document found with the specified field data.');
    }
  }
}
