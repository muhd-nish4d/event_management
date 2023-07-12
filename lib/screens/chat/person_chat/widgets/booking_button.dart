import 'dart:async';
import 'dart:developer';

import 'package:event_management/model/event_reqbooking_model.dart';
import 'package:flutter/material.dart';

import '../../../../const/color.dart';
import '../../../../const/sizes.dart';
import '../../../../static/statics.dart';

class BookingEventButton extends StatelessWidget {
  BookingEventButton({
    super.key,
    required this.recipientId,
  });
  final String recipientId;
  TextEditingController partyTypeController = TextEditingController();
  TextEditingController partyAmountController = TextEditingController();
  TextEditingController partyLocationController = TextEditingController();
  TextEditingController partyAboutController = TextEditingController();
  late String bookingDate;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 84)));
        if (date != null) {
          bookingDate = date.toString();
          Timer(const Duration(milliseconds: 60), () {
            _showMyDialog(context);
          });
        }
      },
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: primaryColor),
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
                    child: TextField(
                        controller: partyTypeController,
                        decoration: const InputDecoration(
                            hintText: 'Your Party type',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
                itemsGapHeight,
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                        controller: partyAmountController,
                        decoration: const InputDecoration(
                            hintText: 'Amount',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
                itemsGapHeight,
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                        controller: partyLocationController,
                        decoration: const InputDecoration(
                            hintText: 'Location',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10)))),
                itemsGapHeight,
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                        controller: partyAboutController,
                        maxLines: 3,
                        minLines: 1,
                        decoration: const InputDecoration(
                            hintText: 'About your Party',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(10))))
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Send Request'),
              onPressed: () async {
                await acceptButtonCliked();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> acceptButtonCliked() async {
    final partyType = partyTypeController.text.trim();
    final amount = partyAmountController.text.trim();
    final location = partyLocationController.text.trim();
    final aboutParty = partyAboutController.text.trim();
    final request = EventBookingReq(
      aboutParty: aboutParty,
      partyType: partyType,
      location: location,
      amount: amount,
      date: bookingDate,
      senderId: '',
      recipientId: recipientId,
      status: 'notResponded',
    );
    await Utils.sendReqForEventBook(request);
    log('sented');
  }
}
