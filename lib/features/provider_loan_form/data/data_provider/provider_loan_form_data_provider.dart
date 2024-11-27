import 'package:ifb_loan/configuration/api_constants.dart';
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
}
