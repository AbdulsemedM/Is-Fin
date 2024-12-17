import 'dart:convert';

import 'package:ifb_loan/features/loan_approval_status/data/data_provider/loan_approval_status_data_provider.dart';
import 'package:ifb_loan/features/loan_approval_status/model/murabah_aggrement_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/murabaha_card_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/offered_products_price_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';

class LoanApprovalStatusRepository {
  final LoanApprovalStatusDataProvider loanApprovalStatusDataProvider;
  LoanApprovalStatusRepository(this.loanApprovalStatusDataProvider);

  Future<List<StatusProductListModel>> fetchLoanApprovalStatusList() async {
    try {
      final statusList =
          await loanApprovalStatusDataProvider.fetchLoanApprovalStatusList();

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

  Future<List<OfferedProductsPriceModel>> fetchLoanApprovalStatusDetails(
      String id) async {
    try {
      final statusDetails = await loanApprovalStatusDataProvider
          .fetchLoanApprovalStatusDetails(id);
      final data = jsonDecode(statusDetails);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      final List<dynamic> productList = data['response'];
      return productList
          .map((product) => OfferedProductsPriceModel.fromMap(product))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> acceptOffer(String id, String status,
      List<OfferedProductsPriceModel> productList) async {
    try {
      final response = await loanApprovalStatusDataProvider.acceptOffer(
          id, status, productList);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<MurabahaAgreementModel> fetchMurabahaAgreement(String id) async {
    try {
      final response =
          await loanApprovalStatusDataProvider.fetchMurabahaAgreement(id);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return MurabahaAgreementModel.fromMap(data['response']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> acceptMurabahaOffer(String id, String status) async {
    try {
      final response =
          await loanApprovalStatusDataProvider.acceptMuranahaOffer(id, status);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      rethrow;
    }
  }

  Future<MurabahaCardModel> fetchMurabahaCard(String id) async {
    try {
      final response =
          await loanApprovalStatusDataProvider.fetchMurabahaCard(id);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      print("data['response']");
      print(data['response']);
      return MurabahaCardModel.fromMap(data['response']);
    } catch (e) {
      rethrow;
    }
  }
}
