import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/features/loan_approval_status/model/offered_products_price_model.dart';
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

  Future<String> fetchLoanApprovalStatusDetails(String id) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/buyer/request/$id");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> acceptOffer(String id, String status,
      List<OfferedProductsPriceModel>? productList) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        "status": status,
        if (status != "ACCEPTED" &&
            productList != null &&
            productList.isNotEmpty)
          "products": productList.map((prod) {
            return {
              "id": prod.id,
              "quantity": prod.quantity,
            };
          }).toList(),
      };
      final response =
          await apiProvider.putRequest("/api/product/buyer/request/$id", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> fetchMurabahaAgreement(String id) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/buyer/request/markup/$id");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> acceptMuranahaOffer(String id, String status) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {"status": status};
      final response = await apiProvider.postRequest(
          "api/product/buyer/request/markup/$id", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
