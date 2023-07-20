import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_management/const/color.dart';
import 'package:event_management/model/event_reqbooking_model.dart';
import 'package:flutter/material.dart';

import '../../../../../static/statics.dart';

class WidgetBookedWorks extends StatelessWidget {
  const WidgetBookedWorks({super.key, required this.professionDetais});
  final String professionDetais;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextStyle completed = const TextStyle(color: grey);
    TextStyle unComplete = const TextStyle(color: black);
    return StreamBuilder(
      stream: firestore
          .collection('bookingRequests')
          .where('recipientId', isEqualTo: professionDetais)
          .where('status', isEqualTo: 'accepted')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var datasFromStore = snapshot.data?.docs;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var eventDetails = datasFromStore![index].data();
              var bookRequest = EventBookingReq.fromMap(eventDetails);
              return BookedWorksListTile(
                completed: completed,
                unComplete: unComplete,
                partyType: bookRequest.partyType ?? 'Party Type',
                date: Utils.dateTimeConvert(bookRequest.date!).toString(),
                amountRange: bookRequest.amount ?? 'amountRange',
              );
            },
          );
        } else {
          return const Text('data');
        }
      },
    );
  }
}

class BookedWorksListTile extends StatelessWidget {
  const BookedWorksListTile({
    super.key,
    required this.unComplete,
    required this.completed,
    required this.partyType,
    required this.date,
    required this.amountRange,
  });
  final String partyType;
  final String date;
  final String amountRange;
  final TextStyle unComplete;
  final TextStyle completed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text(partyType, style: unComplete),
      subtitle: Text(amountRange),
      trailing: Text(date, style: unComplete),
    );
  }
}
