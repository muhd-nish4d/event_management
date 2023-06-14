part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PhoneNumberSubmittedEvent extends LoginEvent {
  final String phoneNumber;

  const PhoneNumberSubmittedEvent(this.phoneNumber);
}

class OtpVerificationEvent extends LoginEvent {
  final String otp;

  const OtpVerificationEvent(this.otp);
}

class LogOutEvent extends LoginEvent{}
