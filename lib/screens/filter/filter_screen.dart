import 'package:event_management/const/images.dart';
import 'package:event_management/screens/filter/widgets/filter_cards.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../../const/sizes.dart';

class ScreenFilter extends StatelessWidget {
  const ScreenFilter({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    Size screenSize = MediaQuery.of(context).size;
    return ListView(
      padding: const EdgeInsets.all(10),
      children: [
        FilterCard(
            title: 'Event Management',
            color: cardColorEventManagement,
            image: filterEventManagement,
            width: screenSize.width,
            isGrid: false),
        itemsGapHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCard(
                title: 'Venue',
                image: filterVenue,
                color: cardColorVenue,
                width: screenSize.width * .46,
                isGrid: true),
            FilterCard(
                title: 'Food &\nBeverage',
                image: filterFood,
                color: cardColorFood,
                width: screenSize.width * .46,
                isGrid: true),
          ],
        ),
        itemsGapHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCard(
                title: 'Outfit',
                image: filterFashion,
                color: fashionCard,
                width: screenSize.width * .46,
                isGrid: true),
            FilterCard(
                title: 'Jewellery',
                image: filterRing,
                color: cardColorJweld,
                width: screenSize.width * .46,
                isGrid: true),
          ],
        ),
        itemsGapHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCard(
                title: 'Makeup',
                image: filterMakeUp,
                color: cardColorMakeUp,
                width: screenSize.width * .46,
                isGrid: true),
            FilterCard(
                title: 'Photographers',
                image: filterCameraMan,
                color: cardColorCamera,
                width: screenSize.width * .46,
                isGrid: true),
          ],
        ),
        itemsGapHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCard(
                title: 'Catering',
                image: filterServe,
                color: cardColorserv,
                width: screenSize.width * .46,
                isGrid: true),
            FilterCard(
                title: 'Band',
                image: filterBand,
                color: cardColorBand,
                width: screenSize.width * .46,
                isGrid: true),
          ],
        ),
        itemsGapHeight,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FilterCard(
                title: 'Cards &\nInvitation',
                image: filterCard,
                color: cardColorCard,
                width: screenSize.width * .46,
                isGrid: true),
            // FilterCard(
            //     title: 'Venue',
            //     image: filterEventManagement,
            //     color: eventManagementCard,
            //     width: screenSize.width * .46,
            //     isGrid: true),
          ],
        ),
        // GridView(
        //   shrinkWrap: true,
        //   physics: NeverScrollableScrollPhysics(),

        //   gridDelegate:
        //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10),
        //   children: [
        //     FilterCard(
        //         title: 'Venue',
        //         image: filterEventManagement,
        //         color: eventManagementCard,
        //         width: screenSize.width,
        //         isGrid: true),
        //   ],
        // )
      ],
    );
  }
}
