import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/otp/data/repository/otp_repository.dart';
part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final OtpRepository otpRepository;
  OtpBloc(this.otpRepository) : super(OtpInitial()) {
    on<SendOTP>(_onSendOTP);
    on<SendPhoneNumber>(_onSendPhoneNumber); //
  }
  Future<void> _onSendOTP(SendOTP event, Emitter<OtpState> emit) async {
    emit(OTPSentLoading());
    try {
      final message = await otpRepository.sendOTP(
          event.otp, event.password, event.phoneNumber);
      emit(OTPSentSuccess(message: message));
    } catch (e) {
      emit(OTPSentFailure(errorMessage: e.toString()));
    }
  }

  Future<void> _onSendPhoneNumber(
      SendPhoneNumber event, Emitter<OtpState> emit) async {
    emit(PhoneNumberSentLoading());
    try {
      final message = await otpRepository.sendPhoneNumber(event.phoneNumber);
      emit(PhoneNumberSentSuccess(message: message));
    } catch (e) {
      emit(PhoneNumberSentFailure(errorMessage: e.toString()));
    }
  }
}
