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

final class OtpSentLoading extends SignupState {}

final class OtpSentSuccess extends SignupState {
  final String message;

  OtpSentSuccess(this.message);
}

final class OtpSentFailure extends SignupState {
  final String errorMessage;

  OtpSentFailure(this.errorMessage);
}
