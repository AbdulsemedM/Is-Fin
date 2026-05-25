import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class LoanRepaymentDataProvider {
  Future<String> getRepaymentHistory(String loanId) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/payment/$loanId");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> makePayment(String loanId, String amount) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final userType = await UserManager().getUserType();
      final isInformal = userType == 'IN_FORMAL';
      final body = isInformal
          ? {
              'loanId': loanId,
              'amount': amount,
            }
          : {
              'loanId': loanId,
              'amount': amount,
              'paymentMethod': 'MOBILE',
            };
      final endpoint =
          isInformal ? '/api/payment/process' : '/api/payment';
      print(body);
      final response = await apiProvider.postRequest(endpoint, body);
      print(response.body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
