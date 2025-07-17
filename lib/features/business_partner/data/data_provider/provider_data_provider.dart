import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class ProviderDataProvider {
  Future<String> sendProvider(String phoneNumber) async {
    try {
      final body = {"phoneNumber": phoneNumber};
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest("/api/user/verifyUser", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> verifyProvider(String phoneNumber, String name) async {
    try {
      final body = {"phoneNumber": phoneNumber, "fullName": name};
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest("/api/user/partner", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> getProvider(bool isRateProvider) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      if (isRateProvider) {
        final response = await apiProvider.getRequest("/api/suppliers/my-suppliers");
        return response.body;
      } else {
        final response = await apiProvider.getRequest("/api/user/partner");
        return response.body;
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
