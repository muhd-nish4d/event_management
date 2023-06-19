part of 'all_user_bloc_bloc.dart';

abstract class AllUserBlocState extends Equatable {
  const AllUserBlocState();

  @override
  List<Object> get props => [];
}

class AllUserBlocInitialState extends AllUserBlocState {}

class AllUserBlocLoadingState extends AllUserBlocState {}

class AllUserBlocLoadedState extends AllUserBlocState {
  final List<UserModel> userDatas;

  const AllUserBlocLoadedState(this.userDatas);
}

class AllUserBlocErrorState extends AllUserBlocState {}
