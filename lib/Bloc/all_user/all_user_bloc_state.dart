part of 'all_user_bloc_bloc.dart';

abstract class AllUserBlocState extends Equatable {
  const AllUserBlocState();

  @override
  List<Object> get props => [];
}

class AllUserBlocInitialState extends AllUserBlocState {}

class AllUserBlocLoadingState extends AllUserBlocState {}

class AllUserBlocLoadedState extends AllUserBlocState {
  final Stream<QuerySnapshot<Map<String, dynamic>>>? professionsDocs;

  const AllUserBlocLoadedState({required this.professionsDocs});
}

class AllUserBlocErrorState extends AllUserBlocState {
  final String? error;

  const AllUserBlocErrorState(this.error);
}
