import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class LoanApprovalStatusDataProvider {
  Future<String> fetchLoanApprovalStatusList() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/buyer/request");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
