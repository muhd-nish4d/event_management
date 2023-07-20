import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../const/color.dart';
import '../../../../const/sizes.dart';
import '../../../../model/user_model.dart';

class WidgetChatAppBarTitle extends StatelessWidget {
  const WidgetChatAppBarTitle({
    super.key,
    required this.userDetails,
  });
  final UserModel userDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        userDetails.profileImage == null
            ? const CircleAvatar(child: Icon(Icons.person, color: white))
            : userDetails.profileImage == ''
                ? const CircleAvatar(child: Icon(Icons.person, color: white))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                              color: grey.withOpacity(0.5),
                            ),
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        imageUrl: userDetails.profileImage!),
                  ),
        itemsGapWidth,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                userDetails.userType == UserType.profession
                    ? userDetails.companyName ?? 'Company Name'
                    : userDetails.ownerName ?? 'Owner Name',
                style:
                    const TextStyle(fontWeight: FontWeight.bold, color: white)),
            // Row(
            //   children: [
            //     Text(userDetails.profession ?? 'Profession',
            //         style: const TextStyle(fontSize: 15, color: white)),
            //     Icon(Icons.star, color: Colors.yellow, size: 15),
            //     Icon(Icons.star, color: Colors.yellow, size: 15),
            //     Icon(Icons.star, color: Colors.yellow, size: 15),
            //     Icon(Icons.star, color: Colors.yellow, size: 15),
            //     Icon(Icons.star, color: grey, size: 15),
            //   ],
            // )
          ],
        )
      ],
    );
  }
}
