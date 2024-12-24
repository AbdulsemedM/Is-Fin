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

  Future<String> makePayment(String loanId, String amount) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        "loanId": loanId,
        "amount": amount,
        "paymentMethod": "MOBILE",
      };
      print(body);
      final response = await apiProvider.postRequest("/api/payment", body);
      print(response.body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
