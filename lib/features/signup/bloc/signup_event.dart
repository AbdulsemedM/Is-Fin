part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupSent extends SignupEvent {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String otp;
  final String? email;
  SignupSent({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.otp,
    this.email,
  });
}

class SendOtp extends SignupEvent {
  final String phoneNumber;
  SendOtp({required this.phoneNumber});
}
