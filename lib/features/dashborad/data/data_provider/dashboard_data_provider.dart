import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class DashboardDataProvider {
  Future<String> sendFcmToken(String fcmToken) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest("/api/user/registerToken", {
        "token": fcmToken,
      });
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
