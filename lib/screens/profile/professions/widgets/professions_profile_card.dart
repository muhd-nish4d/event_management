import 'package:event_management/screens/profile/professions/widgets/cleint_view/professions_profile_cleint_view.dart';
import 'package:event_management/screens/profile/professions/widgets/user_view/user_view.dart';
import 'package:flutter/material.dart';
import '../../../../model/user_model.dart';

class ProfessionsProfileCard extends StatelessWidget {
  final bool isCleintView;
  final UserModel profession;
  const ProfessionsProfileCard({
    super.key,
    required this.isCleintView,
    required this.profession,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: isCleintView
            ? ProfessionsProfileCleintView(profession: profession)
            : const ProfessionsProfileUserView());
  }
}
