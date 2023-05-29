import 'package:event_management/const/color.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          height: 340,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    blurRadius: 10, spreadRadius: 3, blurStyle: BlurStyle.outer)
              ]),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const CircleAvatar(
                      backgroundColor: grey,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Name',
                          style: TextStyle(color: black),
                        ),
                        Row(
                          children: const [
                            Text('Profession'),
                            SizedBox(width: 5),
                            CircleAvatar(
                                radius: 3, backgroundColor: grey),
                            Text('Place')
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.person_add_alt_1))
                  ],
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/image/beautiful-woman-long-red-dress-walks-around-city-with-her-husband.jpg',
                        ))),
              ),
              // Image.asset(
              //   'assets/image/5dcc5d9bce6550c6fc59b3c4cffae51c.jpg',
              // ),
              SizedBox(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_rounded))
                  ],
                ),
              ),
            ],
          )),
    );
  }
}