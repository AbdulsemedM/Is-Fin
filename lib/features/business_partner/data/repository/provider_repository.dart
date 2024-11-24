// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/features/business_partner/data/data_provider/provider_data_provider.dart';

class ProviderRepository {
  final ProviderDataProvider providerDataProvider;
  ProviderRepository(this.providerDataProvider);

  Future<Map<String, String>> sendProvider(String phoneNumber) async {
    try {
      final providerData = await providerDataProvider.sendProvider(phoneNumber);

      final data = jsonDecode(providerData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      Map<String, String> provider = {
        "phoneNumber": data['response']['phoneNumber'],
        "fullName": data['response']['fullName']
      };

      return provider;
    } catch (e) {
      throw e;
    }
  }

  Future<String> verifyProvider(String phoneNumber, String name) async {
    try {
      final providerData =
          await providerDataProvider.verifyProvider(phoneNumber, name);

      final data = jsonDecode(providerData);
      if (data['httpStatus'] != 201) {
        throw data['message'];
      }

      return data['message'];
    } catch (e) {
      throw e;
    }
  }

  Future<List<Map<String, String>>> getProvider() async {
    try {
      final providerData = await providerDataProvider.getProvider();

      final data = jsonDecode(providerData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        List<Map<String, String>> providers = [];

        for (var item in data['response']) {
          providers.add({
            "phoneNumber": item['phoneNumber'].toString(),
            "fullName": item['fullName'].toString(),
          });
        }

        return providers;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      throw e;
    }
  }
}
