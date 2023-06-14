part of 'fillup_bloc.dart';

abstract class FillupState extends Equatable {
  const FillupState();

  @override
  List<Object> get props => [];
}

class FillupInitialState extends FillupState {}

class FillupLodingState extends FillupState {}

class FilledUserState extends FillupState {
  final UserModel userdatas;

  const FilledUserState(this.userdatas);
}

class ErrorWhileFillingState extends FillupState {}
