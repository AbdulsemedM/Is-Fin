import 'dart:convert';

import 'package:ifb_loan/features/otp/data/data_provider/otp_data_provider.dart';

class OtpRepository {
  final OtpDataProvider otpDataProvider;

  OtpRepository({required this.otpDataProvider});
  Future<String> sendOTP(
      String otp, String password, String phoneNUmber) async {
    try {
      final String otpData =
          await otpDataProvider.sendOTP(otp, password, phoneNUmber);
      final data = jsonDecode(otpData);
      if (data['httpStatus'] == 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<String> sendPhoneNumber(String phoneNUmber) async {
    try {
      final String otpData = await otpDataProvider.sendPhoneNumber(phoneNUmber);
      final data = jsonDecode(otpData);
      if (data['httpStatus'] == 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      rethrow;
    }
  }
}
