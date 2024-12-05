part of 'otp_bloc.dart';

@immutable
sealed class OtpEvent {}

final class SendOTP extends OtpEvent {
  final String otp;
  final String password;
  final String phoneNumber;
  SendOTP(
      {required this.password, required this.otp, required this.phoneNumber});
}

final class SendPhoneNumber extends OtpEvent {
  final String phoneNumber;
  SendPhoneNumber({required this.phoneNumber});
}
