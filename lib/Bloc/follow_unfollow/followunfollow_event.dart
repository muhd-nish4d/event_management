part of 'followunfollow_bloc.dart';

abstract class FollowUnfollowEvent extends Equatable {
  const FollowUnfollowEvent();

  @override
  List<Object> get props => [];
}

class UserFollowInitialEvent extends FollowUnfollowEvent {
  final UserModel user;

  const UserFollowInitialEvent(this.user);
}

class UserFollowEvent extends FollowUnfollowEvent {
  final String userId;

  const UserFollowEvent(this.userId);
}

class UserUnfollowEvent extends FollowUnfollowEvent {
  final String userId;

  const UserUnfollowEvent(this.userId);
}
// class UserFollowEvent extends FollowUnfollowEvent{}
