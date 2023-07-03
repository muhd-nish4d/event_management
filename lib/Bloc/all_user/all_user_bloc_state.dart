part of 'all_user_bloc_bloc.dart';

abstract class AllUserBlocState extends Equatable {
  const AllUserBlocState();

  @override
  List<Object> get props => [];
}

class AllUserBlocInitialState extends AllUserBlocState {}

class AllUserBlocLoadingState extends AllUserBlocState {}

class AllUserBlocLoadedState extends AllUserBlocState {
  final List<UserModel> allUser;

  const AllUserBlocLoadedState({required this.allUser});
}

class AllProfessionsLoadedState extends AllUserBlocState {
  final List<UserModel> allProfessions;

  const AllProfessionsLoadedState({required this.allProfessions});
}

class AllProfessionsSearchState extends AllUserBlocState {
  final List<UserModel> searchedProfessions;

  const AllProfessionsSearchState({required this.searchedProfessions});
}

class AllUserBlocErrorState extends AllUserBlocState {
  final String? error;

  const AllUserBlocErrorState(this.error);
}
