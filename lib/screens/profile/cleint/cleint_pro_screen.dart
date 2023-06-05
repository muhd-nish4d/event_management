import 'package:flutter/material.dart';

import '../../../const/color.dart';
import '../../../widgets/user_listtile.dart';

class ScreenCleintProfile extends StatelessWidget {
  const ScreenCleintProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  onPressed: () {}, icon: const Icon(Icons.menu_outlined))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const CircleAvatar(
                radius: 60,
                child: Icon(
                  Icons.person,
                  color: white,
                  size: 70,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'User name',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                    children: const [
                      Icon(Icons.place_outlined),
                      Text('Place'),
                    ],
                  ),
                ],
              )
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
          const Expanded(
            child: UsersTile(),
          )
        ],
      ),
    );
  }
}
