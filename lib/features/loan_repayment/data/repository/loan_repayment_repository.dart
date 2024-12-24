import 'dart:convert';

import 'package:ifb_loan/features/loan_repayment/data/data_provider/loan_provider_data_provider.dart';
import 'package:ifb_loan/features/loan_repayment/models/repayment_history_model.dart';

class LoanRepaymentRepository {
  final LoanRepaymentDataProvider loanRepaymentDataProvider;
  LoanRepaymentRepository(this.loanRepaymentDataProvider);

  Future<List<RepaymentHistoryModel>> getRepaymentHistory() async {
    try {
      final response = await loanRepaymentDataProvider.getRepaymentHistory();
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        final responseList = data['response'] as List;
        return responseList
            .map((e) => RepaymentHistoryModel.fromMap(e))
            .toList();
      } else {
        throw 'Invalid data format';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, dynamic>> makePayment(String loanId, String amount) async {
    try {
      final response =
          await loanRepaymentDataProvider.makePayment(loanId, amount);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 201) {
        throw data['message'];
      }
      return data['response'];
    } catch (e) {
      throw e.toString();
    }
  }
}
