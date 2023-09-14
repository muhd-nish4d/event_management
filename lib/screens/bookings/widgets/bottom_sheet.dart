import 'dart:developer';

import 'package:event_management/const/color.dart';
import 'package:event_management/model/event_reqbooking_model.dart';
import 'package:event_management/static/feedback_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Future<void> showFeedbackBox(BuildContext ctx, EventBookingReq request) async {
  final TextEditingController feedbackController = TextEditingController();
  double rating = 1;
  return showDialog(
    context: ctx,
    builder: (context) => AlertDialog(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel')),
          TextButton(
              onPressed: () {
                FeedbackUtils.feedbackSubmitted(request,
                    rating: rating, feedback: feedbackController.text.trim());
                Navigator.pop(context);
              },
              child: const Text('Submit')),
        ],
        title: const Text('Send your Feedback'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.center,
                  child: RatingBar(
                    glow: false,
                    initialRating: 1,
                    itemSize: 30,
                    allowHalfRating: false,
                    ratingWidget: RatingWidget(
                        full: const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        half: const Icon(Icons.star),
                        empty: const Icon(
                          Icons.star_border_outlined,
                          color: grey,
                        )),
                    onRatingUpdate: (value) {
                      log("${value.toString()} ${value.runtimeType}");
                      rating = value;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextFormField(
                  controller: feedbackController,
                  minLines: 3,
                  maxLines: 5,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                ),
              ),
            ],
          ),
        )),
  );
}
