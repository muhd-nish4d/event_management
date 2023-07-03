import 'package:flutter/material.dart';

class EventReqCard extends StatelessWidget {
  const EventReqCard({
    super.key,
  });

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
              const Text('Event Type',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const Text('About Event'),
              const Text('10 / Apr / 2022'),
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