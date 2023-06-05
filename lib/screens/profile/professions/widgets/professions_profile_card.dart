import 'package:flutter/material.dart';

import '../../../../const/color.dart';

class ProfessionsProfileCard extends StatelessWidget {
  const ProfessionsProfileCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        height: 400,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [BoxShadow(blurRadius: 5)]),
        child: Stack(
          // alignment: Alignment.center,
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(10)),
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
                        const Text(
                          'Company Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.work_outline_outlined),
                            Text('Profession'),
                          ],
                        ),
                        Row(
                          children: const [
                            Icon(Icons.location_on_outlined),
                            Text('Place'),
                          ],
                        ),
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
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 40,
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: const [Text('5'), Text('Posts')],
                              ),
                              const VerticalDivider(),
                              Column(
                                children: const [Text('52'), Text('Followers')],
                              ),
                              const VerticalDivider(),
                              Column(
                                children: const [Text('43'), Text('Following')],
                              ),
                              const VerticalDivider(),
                              Column(
                                children: const [Text('12'), Text('Work')],
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/userbackcard.jpg'))),
              ),
            ),
            Positioned(
              // alignment: Alignment.centerLeft,
              top: 100,
              left: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: grey,
                    child: Icon(
                      Icons.person,
                      color: white,
                      size: 40,
                    ),
                  ),
                  Text('Owner Name'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
