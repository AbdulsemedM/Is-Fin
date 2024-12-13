import 'dart:convert';

import 'package:ifb_loan/features/home/data/data_provider/home_data_provider.dart';

class HomeRepository {
  final HomeDataProvider homeDataProvider;

  HomeRepository(this.homeDataProvider);
  Future<String> fetchCreditScore() async {
    try {
      final score = await homeDataProvider.fetchCreditScore();
      final data = jsonDecode(score);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['response']['total_score'].toString();
    } catch (e) {
      rethrow;
    }
  }
}
