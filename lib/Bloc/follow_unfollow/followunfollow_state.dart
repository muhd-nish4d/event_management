part of 'followunfollow_bloc.dart';

abstract class FollowUnfollowState extends Equatable {
  const FollowUnfollowState();

  @override
  List<Object> get props => [];
}

class FollowUnfollowInitialState extends FollowUnfollowState {}

class FollowUnfollowLoadingState extends FollowUnfollowState {}

class FollowedState extends FollowUnfollowState {}

class UnfollowedSate extends FollowUnfollowState {}

class FollowErrorState extends FollowUnfollowState {
  final String error;

  const FollowErrorState(this.error);
}
