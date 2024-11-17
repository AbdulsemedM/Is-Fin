part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginFetched extends LoginEvent {
  final String phoneNumber;
  final String password;

  LoginFetched({required this.phoneNumber, required this.password});
}
