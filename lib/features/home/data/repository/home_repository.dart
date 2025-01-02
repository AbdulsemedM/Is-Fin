import 'dart:convert';

import 'package:ifb_loan/features/home/data/data_provider/home_data_provider.dart';
import 'package:ifb_loan/features/home/models/creadit_score_model.dart';

class HomeRepository {
  final HomeDataProvider homeDataProvider;

  HomeRepository(this.homeDataProvider);
  Future<CreditScoreModel> fetchCreditScore() async {
    try {
      final score = await homeDataProvider.fetchCreditScore();
      final data = jsonDecode(score);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return CreditScoreModel.fromMap(data['response']);
    } catch (e) {
      rethrow;
    }
  }
}
