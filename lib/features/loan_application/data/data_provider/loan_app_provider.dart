import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/features/loan_application/models/products_request_model.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class LoanAppProvider {
  Future<String> fetchSectors() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/product/sector");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchRepayment() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/repaymentduration");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchtUnitofMeasurement() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/product/unitOfMeasurement");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> sendProductRequest(ProductsRequestModel product) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final body = {
        "productRequest": product.products.map((prod) {
          return {
            "productName": prod.productName,
            "quantity": prod.productQuantity,
            "productDescription": prod.productDescription,
            "unitOfMeasurement": prod.productUnitofMeasurement,
          };
        }).toList(),
        "sectorName": product.sector,
        "repaymentCycleDuration": product.repymentPlan,
        "phoneNumber": product.provider,
      };

      final response =
          await apiProvider.postRequest("/api/product/buyer/request", body);
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }
}
