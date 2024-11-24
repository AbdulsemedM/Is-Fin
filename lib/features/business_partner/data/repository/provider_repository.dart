// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/features/business_partner/data/data_provider/provider_data_provider.dart';

class ProviderRepository {
  final ProviderDataProvider providerDataProvider;
  ProviderRepository(this.providerDataProvider);

  Future<String> sendProvider(String phoneNumber) async {
    try {
      final providerData = await providerDataProvider.sendProvider(phoneNumber);

      final data = jsonDecode(providerData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }

      return data['response'];
    } catch (e) {
      throw e;
    }
  }
}
