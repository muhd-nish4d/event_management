part of 'all_user_bloc_bloc.dart';

abstract class AllUserBlocEvent extends Equatable {
  const AllUserBlocEvent();

  @override
  List<Object> get props => [];
}

class UserInitialEvent extends AllUserBlocEvent{}
