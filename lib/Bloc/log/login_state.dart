part of 'login_bloc.dart';
abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LogInitialState extends LoginState {}

class LogLoadingState extends LoginState {}

class CodeSentState extends LoginState {}

class CodeVerifiedState extends LoginState {}

class LoggedInState extends LoginState {
  final User firebaseUser;

  const LoggedInState(this.firebaseUser);
}

class UserFilledState extends LoginState{}

class LoggedOutState extends LoginState {}

class ErrorState extends LoginState {
  final String error;

  const ErrorState(this.error);
}
// class LoginInitialState extends LoginState {}
