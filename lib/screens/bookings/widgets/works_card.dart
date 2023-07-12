import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/static/statics.dart';
import 'package:event_management/widgets/circular_progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/event_reqbooking_model.dart';

class WidgetCardWorks extends StatelessWidget {
  const WidgetCardWorks({super.key});

  @override
  Widget build(BuildContext context) {
    // getAcceptedRequests();
    return FutureBuilder(
      future: getAcceptedRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final request = snapshot.data![index];
              final String? date = Utils.dateTimeConvert(request.date!);
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    backgroundColor: Colors.red[50],
                    childrenPadding: const EdgeInsets.all(10),
                    expandedAlignment: Alignment.topLeft,
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(request.partyType ?? 'Party'),
                    children: [
                      Text(date ?? 'Date'),
                      Text(request.location ?? 'Location'),
                      // Text('Event type'),
                      Text(request.partyType ?? 'Event bio'),
                      Text(request.amount ?? 'Amount'),
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        } else {
          return const CustomProgressIndicator();
        }
      },
    );
  }

  Future<List<EventBookingReq>> getAcceptedRequests() async {
    List<EventBookingReq> bookedEvents = [];
    // Assuming you have already authenticated the user
    final User user = FirebaseAuth.instance.currentUser!;

// Get a reference to the "request" collection
    final CollectionReference requestCollection =
        FirebaseFirestore.instance.collection('bookingRequests');

// Build a query to filter the documents based on user and status
    QuerySnapshot querySnapshot = await requestCollection
        .where('recipientId', isEqualTo: user.uid)
        .where('status', isEqualTo: 'accepted')
        .get();

    if (querySnapshot.size > 0) {
      // Documents matching the criteria exist
      List<EventBookingReq> documents = querySnapshot.docs
          .map((e) => EventBookingReq.fromMap(e.data() as Map<String, dynamic>))
          .toList();

      // Iterate through the documents
      for (var doc in documents) {
        bookedEvents.add(doc);
      }
    } else {
      log('No requests found matching the criteria.');
    }
    return bookedEvents;
  }
}
