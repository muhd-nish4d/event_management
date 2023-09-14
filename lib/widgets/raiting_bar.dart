import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';

class RatingContainer extends StatelessWidget {
  const RatingContainer({super.key, required this.feedbackRating});
  final double feedbackRating;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      width: 60,
      decoration: BoxDecoration(
          color: feedbackRating == 1
              ? Colors.red
              : feedbackRating == 2
                  ? Colors.orange
                  : feedbackRating == 3
                      ? Colors.yellow
                      : feedbackRating == 4
                          ? Colors.greenAccent
                          : Colors.green,
          borderRadius: BorderRadius.circular(10)),
      child: FittedBox(
          child: Row(
        children: [
          const Icon(Icons.star_rate_rounded, size: 20, color: white),
          Text(
            feedbackRating.toString(),
            style: const TextStyle(color: white),
          ),
        ],
      )),
    );
  }
}
