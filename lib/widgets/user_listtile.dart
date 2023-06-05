import 'package:flutter/material.dart';

import '../const/color.dart';

class UsersTile extends StatelessWidget {
  const UsersTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ListTile(
          leading: const CircleAvatar(
            child: Icon(
              Icons.person,
              color: white,
            ),
          ),
          title: const Text('Company Name'),
          subtitle: Row(
            children: [
              const Text('Profession'),
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
          ),
          trailing: IconButton(
              onPressed: () {}, icon: const Icon(Icons.person_add_alt_1_sharp)),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0,
        );
      },
      itemCount: 10,
    );
  }
}
