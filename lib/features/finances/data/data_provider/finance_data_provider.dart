import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class FinanceDataProvider {
  Future<String> fetchActiveLoans() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/loan/activeLoan");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
