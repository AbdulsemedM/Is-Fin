import 'dart:convert';

import 'package:ifb_loan/features/loan_approval_status/data/data_provider/loan_approval_status_data_provider.dart';
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
}
