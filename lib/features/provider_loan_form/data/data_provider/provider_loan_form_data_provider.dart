import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class ProviderLoanFormDataProvider {
  Future<String> fetchProviderLoanFormList() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/supplier/request");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> fetchRequestedProductsById(String id) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/supplier/request/$id");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendRequestedProductsPrice(
      List<RequestedProductsModel> products,
      String id,
      String expirationDate,
      String status) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        "status": status,
        "priceExpirationDate": expirationDate,
        "products": products.map((prod) {
          return {
            "id": prod.id,
            "productPrice": prod.productPrice,
          };
        }).toList(),
      };
      final response = await apiProvider.postRequest(
          "/api/product/supplier/request/$id", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
