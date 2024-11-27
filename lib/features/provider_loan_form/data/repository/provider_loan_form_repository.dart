import 'dart:convert';

import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/data/data_provider/provider_loan_form_data_provider.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';

class ProviderLoanFormRepository {
  final ProviderLoanFormDataProvider providerLoanFormDataProvider;
  ProviderLoanFormRepository(this.providerLoanFormDataProvider);

  Future<List<StatusProductListModel>> fetchProviderLoanFormList() async {
    try {
      final statusList =
          await providerLoanFormDataProvider.fetchProviderLoanFormList();

      final data = jsonDecode(statusList);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        final statusLists = (data['response'] as List)
            .map((statusMap) => StatusProductListModel.fromMap(statusMap))
            .toList();
        return statusLists;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<RequestedProductsModel>> fetchRequestedProductsById(
      String id) async {
    try {
      final requestedProducts =
          await providerLoanFormDataProvider.fetchRequestedProductsById(id);

      final data = jsonDecode(requestedProducts);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        final requestedProductsList = (data['response'] as List)
            .map((requestedProductsMap) =>
                RequestedProductsModel.fromMap(requestedProductsMap))
            .toList();
        return requestedProductsList;
      } else {
        throw "Invalid response format: Expected a list";
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
