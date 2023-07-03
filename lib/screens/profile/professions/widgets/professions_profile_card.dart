import 'package:event_management/screens/profile/professions/widgets/cleint_view/professions_profile_cleint_view.dart';
import 'package:event_management/screens/profile/professions/widgets/user_view/user_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../Bloc/image_fetch/image_fetch_bloc.dart';
import '../../../../model/post_model.dart';
import '../../../../model/user_model.dart';
import '../../../../widgets/circular_progress_indicator.dart';

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
    BlocProvider.of<ImageFetchBloc>(context).add(ImageFetchInitialEvent());
    return BlocBuilder<ImageFetchBloc, ImageFetchState>(
      builder: (context, state) {
        if (state is ImageFetchLoadedState) {
          int hi = lengthImage(state.allPosts, profession);

          return Padding(
              padding: const EdgeInsets.all(2.0),
              child: isCleintView
                  ? ProfessionsProfileCleintView(
                      profession: profession,
                      postCount: hi,
                    )
                  : const ProfessionsProfileUserView());
        } else if (state is ImageFetchLoadingState) {
          return Container(
            height: 405,
            child: CustomProgressIndicator(),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  int lengthImage(List<Post> post, UserModel user) {
    int count = 0;
    for (var element in post) {
      if (element.creatorId == user.uid) {
        count++;
      }
    }
    return count;
  }
}
