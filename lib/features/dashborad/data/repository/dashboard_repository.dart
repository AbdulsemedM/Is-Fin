import 'dart:convert';

import 'package:ifb_loan/features/dashborad/data/data_provider/dashboard_data_provider.dart';

class DashboardRepository {
  final DashboardDataProvider dashboardDataProvider;

  DashboardRepository(this.dashboardDataProvider);
  Future<String> sendFcmToken(String fcmToken) async {
    try {
      final score = await dashboardDataProvider.sendFcmToken(fcmToken);
      final data = jsonDecode(score);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
