import 'dart:convert';

import 'package:ifb_loan/features/rate_provider/data/data_provider/rate_provider_data_provider.dart';

class RateProviderRepository {
  final RateProviderDataProvider rateProviderDataProvider;

  RateProviderRepository(this.rateProviderDataProvider);

  Future<String> rateProvider(
      String supplierId, double rating, String comment) async {
    try {
      final response = await rateProviderDataProvider.rateProvider(
          supplierId, rating, comment);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}