import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class RateProviderDataProvider {
  Future<String> rateProvider(
      String supplierId, double rating, String comment) async {
    try {
      final body = {
        "supplierId": supplierId,
        "rating": rating,
        "comment": comment,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest(
          "/api/suppliers/my-suppliers/$supplierId/rate", body);
      return response.body;
    } catch (e) {
      throw Exception(e);
    }
  }
}
