part of 'otp_bloc.dart';

@immutable
sealed class OtpState {}

final class OtpInitial extends OtpState {}

final class OTPSentLoading extends OtpState {}

final class OTPSentSuccess extends OtpState {
  final String message;

  OTPSentSuccess({required this.message});
}

final class OTPSentFailure extends OtpState {
  final String errorMessage;

  OTPSentFailure({required this.errorMessage});
}

final class PhoneNumberSentLoading extends OtpState {}

final class PhoneNumberSentSuccess extends OtpState {
  final String message;

  PhoneNumberSentSuccess({required this.message});
}

final class PhoneNumberSentFailure extends OtpState {
  final String errorMessage;

  PhoneNumberSentFailure({required this.errorMessage});
}
