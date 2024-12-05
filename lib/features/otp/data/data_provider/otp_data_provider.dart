import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class OtpDataProvider {
  Future<String> sendOTP(
      String otp, String password, String phoneNUmber) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        'otp': otp,
        'password': password,
        'phoneNUmber': phoneNUmber,
      };
      final response = await apiProvider.postRequest("otp", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendPhoneNumber(String phoneNumber) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        'phoneNUmber': phoneNumber,
      };
      final response = await apiProvider.postRequest("otp", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
