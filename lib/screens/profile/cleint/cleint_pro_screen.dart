import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management/model/user_model.dart';
import 'package:event_management/screens/profile/professions/tab_views/follow/follwing.dart';
import 'package:event_management/screens/settings/settigs_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Bloc/fillup/fillup_bloc.dart';
import '../../../const/color.dart';
import '../../../widgets/user_listtile.dart';

class ScreenCleintProfile extends StatelessWidget {
  const ScreenCleintProfile({super.key, this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            user == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: orange,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: const Text(
                          'Bookings',
                          style: TextStyle(color: white),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    const ScreenSettingsMenu()));
                          },
                          icon: const Icon(Icons.menu_outlined))
                    ],
                  )
                : IconButton(
                    onPressed: () {}, icon: const Icon(Icons.arrow_back)),
            const SizedBox(height: 20),
            user == null
                ? BlocBuilder<FillupBloc, FillupState>(
                    builder: (context, state) {
                      if (state is FillupLodingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is FilledUserState) {
                        var user = state.userdatas;
                        return Row(
                          children: [
                            user.profileImage == null
                                ? const CircleAvatar(
                                    radius: 60,
                                    child: Icon(
                                      Icons.person,
                                      color: white,
                                      size: 70,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: CachedNetworkImage(
                                        placeholder: (context, url) =>
                                            Container(
                                              color: grey.withOpacity(0.5),
                                            ),
                                        fit: BoxFit.cover,
                                        width: 130,
                                        height: 130,
                                        imageUrl: user.profileImage!),
                                  ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user.ownerName ?? 'User Name',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: const [
                                    Icon(Icons.work_outline_rounded),
                                    Text('Cleint'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.phone),
                                    Text(user.phoneNumber ?? 'Phone No'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  )
                : Row(
                    children: [
                      user?.profileImage == null
                          ? const CircleAvatar(
                              radius: 60,
                              child: Icon(
                                Icons.person,
                                color: white,
                                size: 70,
                              ),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                        color: grey.withOpacity(0.5),
                                      ),
                                  fit: BoxFit.cover,
                                  width: 130,
                                  height: 130,
                                  imageUrl: user!.profileImage!),
                            ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            user!.ownerName ?? 'User Name',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: const [
                              Icon(Icons.work_outline_rounded),
                              Text('Cleint'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              Text(user!.phoneNumber ?? 'Phone No'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Following',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Divider(),
            Expanded(
              child: WidgetProfessionsFollow(followers: user!.following!),
            )
          ],
        ),
      ),
    );
  }
}
