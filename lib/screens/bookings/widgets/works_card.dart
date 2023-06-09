import 'package:flutter/material.dart';

class WidgetCardWorks extends StatelessWidget {
  const WidgetCardWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            backgroundColor: Colors.red[50],
            childrenPadding: EdgeInsets.all(10),
            expandedAlignment: Alignment.topLeft,
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('User Name'),
            children: const [
              Text('Date'),
              Text('Place'),
              Text('Event type'),
              Text('Event bio'),
              Text('Contact No'),
            ],
          ),
        ),
      ),
      itemCount: 10,
    );
  }
}
