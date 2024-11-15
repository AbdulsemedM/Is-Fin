part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}

class SignupSent extends SignupEvent {
  final String fullName;
  final String phoneNumber;
  final String password;
  final String? email;
  SignupSent({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    this.email,
  });
}
