part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final SignupModel signupModel;

  SignupSuccess({required this.signupModel});
}

final class SignupFailure extends SignupState {
  final String errorMessage;

  SignupFailure(this.errorMessage);
}
