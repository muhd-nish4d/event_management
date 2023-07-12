import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../Bloc/fillup/fillup_bloc.dart';
import '../../../../../const/color.dart';

class ProfessionsProfileUserView extends StatelessWidget {
  const ProfessionsProfileUserView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FillupBloc, FillupState>(
      builder: (context, state) {
        if (state is FilledUserState) {
          var datas = state.userdatas;
          return Card(
            elevation: 5,
            child: SizedBox(
              height: 400,
              // decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(10),
              //     boxShadow: const [BoxShadow(blurRadius: 5)]),
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10)),
                        height: double.infinity,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 200,
                              ),
                              Text(
                                datas.companyName ?? 'Company Name',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.work_outline_outlined),
                                  Text(datas.profession ?? 'Profession'),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.call),
                                  Text(datas.phoneNumber ?? 'Phone Number'),
                                ],
                              ),
                              // Row(
                              //   children: const [
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: Colors.yellow,
                              //       size: 15,
                              //     ),
                              //     Icon(
                              //       Icons.star,
                              //       color: grey,
                              //       size: 15,
                              //     )
                              //   ],
                              // ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 40,
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: const [
                                        Text('5'),
                                        Text('Posts')
                                      ],
                                    ),
                                    const VerticalDivider(),
                                    Column(
                                      children: const [
                                        Text('52'),
                                        Text('Followers')
                                      ],
                                    ),
                                    const VerticalDivider(),
                                    Column(
                                      children: const [
                                        Text('43'),
                                        Text('Following')
                                      ],
                                    ),
                                    const VerticalDivider(),
                                    Column(
                                      children: const [
                                        Text('12'),
                                        Text('Work')
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        // image: datas.coverImage != null
                        //     ? DecorationImage(
                        //         fit: BoxFit.cover,
                        //         image: NetworkImage(datas.coverImage!))
                        //     :
                      ),
                      child: datas.companyName!.isEmpty
                          ? const SizedBox()
                          : ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                              child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                  imageUrl: datas.coverImage!),
                            ),
                    ),
                  ),
                  Positioned(
                    // alignment: Alignment.centerLeft,
                    top: 100,
                    left: 20,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        datas.profileImage == null
                            ? const CircleAvatar(
                                radius: 50,
                                backgroundColor: grey,
                                child: Icon(
                                  Icons.person,
                                  color: white,
                                  size: 40,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                    imageUrl: datas.profileImage!),
                              ),
                        // CircleAvatar(
                        //     radius: 50,
                        //     backgroundColor: grey,
                        //     backgroundImage:

                        //   ),
                        Text(datas.ownerName ?? 'Owner Name'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (state is FillupLodingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      },
    );
  }
}
