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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(eventDetails.aboutParty ?? ''),
              Text(eventDetails.date?.substring(0, 10) ?? ''),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: const Text('Decline')),
                  TextButton(onPressed: () {}, child: const Text('Accept'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
