import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class SignupDataProvider {
  Future<String> sendSignup(String fullName, String phoneNumber,
      String password, String? email) async {
    try {
      final body = {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "password": password,
        if (email != null) "email": email
      };
      // print(body);
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest("/api/auth/signup", body);
      return response.body;
    } catch (e) {
      // print(e.toString());
      throw e.toString();
    }
  }
}
