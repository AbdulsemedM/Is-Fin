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
}
