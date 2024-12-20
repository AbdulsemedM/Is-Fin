import 'dart:convert';

import 'package:ifb_loan/features/finances/data/data_provider/finance_data_provider.dart';
import 'package:ifb_loan/features/finances/models/active_loan_model.dart';

class FinancesRepository {
  final FinanceDataProvider financeDataProvider;
  FinancesRepository(this.financeDataProvider);
  Future<List<ActiveLoanModel>> fetchActiveLoans() async {
    try {
      final activeLoan = await financeDataProvider.fetchActiveLoans();
      final data = jsonDecode(activeLoan);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      if (data['response'] is List) {
        final loan = (data['response'] as List)
            .map((myLoan) => ActiveLoanModel.fromMap(myLoan))
            .toList();
        print(loan);
        return loan;
      } else {
        throw 'Invalid data format';
      }
    } catch (e) {
      rethrow;
    }
  }
}
