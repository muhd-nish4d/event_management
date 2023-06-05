import 'package:event_management/screens/professions/widgets/professions_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenProfession extends StatelessWidget {
  final bool fromAnotherScreen;
  const ScreenProfession({super.key, required this.fromAnotherScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              fromAnotherScreen
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back))
                  : const SizedBox(),
              const Expanded(child: CupertinoSearchTextField()),
            ],
          ),
        ),
        Expanded(
            child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: .75,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return const ProfessionsCard();
          },
          itemCount: 4,
        ))
      ],
    );
  }
}
