import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/screens/profile/professions/profession.dart';
import 'package:flutter/material.dart';

import '../const/color.dart';
import '../model/user_model.dart';

class UsersTile extends StatelessWidget {
  const UsersTile({
    super.key,
    this.userDetails,
  });
  final UserModel? userDetails;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScreenProfessionsProfile(
                    isCleintView: true, userDetails: userDetails),
              ));
        },
        leading: userDetails!.profileImage != ''
            ? ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: CachedNetworkImage(
                    placeholder: (context, url) => Container(
                          color: grey.withOpacity(0.5),
                        ),
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                    imageUrl: userDetails!.profileImage!),
              )
            : const CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: white,
                ),
              ),
        title: Text(userDetails!.userType == UserType.profession
            ? userDetails!.companyName == ''
                ? 'Company Name'
                : userDetails!.companyName!
            : userDetails!.ownerName!),
        subtitle: userDetails!.userType == UserType.profession
            ? Row(
                children: [
                  Text(userDetails!.profession!),
                  Row(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Icon(
                        Icons.star,
                        color: grey,
                        size: 15,
                      )
                    ],
                  )
                ],
              )
            : const SizedBox(),
        trailing: userDetails!.userType == UserType.profession
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.person_add_alt_1_sharp))
            : const SizedBox());
  }
}
