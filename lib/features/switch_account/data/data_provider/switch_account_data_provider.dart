import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class SwitchAccountDataProvider {
  Future<String> fetchAccounts() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest('/api/kyc/account/linked');
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> fetchActiveAccount() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest('/api/kyc/account/active');
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> switchAccount(String accountType) async {
    try {
      final body = {
        "accountType": accountType,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest('/api/kyc/account/switch', body);
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> linkAccount(String accountNumber, String accountType) async {
    try {
      final body = {
        "accountNumber": accountNumber,
        "accountType": accountType,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest('/api/kyc/account/link', body);
      return response.body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
