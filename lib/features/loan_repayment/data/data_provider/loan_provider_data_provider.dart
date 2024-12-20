import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class LoanRepaymentDataProvider {
  Future<String> getRepaymentHistory() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/payment");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
