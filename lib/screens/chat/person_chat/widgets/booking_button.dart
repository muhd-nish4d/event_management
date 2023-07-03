import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../const/color.dart';
import '../../../../const/sizes.dart';

class BookingEventButton extends StatelessWidget {
  const BookingEventButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final data = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(const Duration(days: 1)),
            lastDate: DateTime.now());
        Timer(const Duration(milliseconds: 60), () {
          _showMyDialog(context);
        });
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: orange),
      child: const Text('Book your Party', style: TextStyle(color: white)),
    );
  }

  Future<void> _showMyDialog(BuildContext ctx) async {
    return showDialog<void>(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Abount Party'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'Your Party type',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
                itemsGapHeight,
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: const TextField(
                        maxLines: 3,
                        minLines: 1,
                        decoration: InputDecoration(
                            hintText: 'About your Party',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Send Request'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
