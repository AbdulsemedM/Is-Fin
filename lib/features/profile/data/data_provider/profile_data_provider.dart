import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class ProfileDataProvider {
  Future<String> getProfile()async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/user/profile");
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> updateProfile(bool isPublic) async {
    try {
      final body = {
        "isPublic": isPublic,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.putRequest("/api/user/profile", body);
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}