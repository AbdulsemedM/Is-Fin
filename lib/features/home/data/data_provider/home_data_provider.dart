import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class HomeDataProvider {
  Future<String> fetchCreditScore() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("endpoint");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
