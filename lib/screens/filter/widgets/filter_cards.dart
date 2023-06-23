import 'package:event_management/screens/professions/professions.dart';
import 'package:flutter/material.dart';

import '../../../const/color.dart';

class FilterCard extends StatelessWidget {
  const FilterCard(
      {super.key,
      required this.image,
      required this.color,
      required this.width,
      required this.title,
      required this.isGrid,
      required this.filterKey});
  final String image;
  final Color color;
  final double width;
  final String title;
  final bool isGrid;
  final String filterKey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Scaffold(
                    body: SafeArea(
                        child: ScreenProfession(
                  fromAnotherScreen: true,
                  filterKey: filterKey,
                )))));
      },
      child: Stack(
        alignment: isGrid
            ? AlignmentDirectional.bottomStart
            : AlignmentDirectional.center,
        children: [
          Container(
              height: 110,
              width: width,
              decoration: BoxDecoration(
                  boxShadow: const [BoxShadow(blurRadius: 4,color: grey)],
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover, image: AssetImage(image)))),
          Container(
            height: 110,
            width: width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: color),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width - 18,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                textAlign: isGrid ? TextAlign.start : TextAlign.center,
                style: const TextStyle(
                    height: 1,
                    color: white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
