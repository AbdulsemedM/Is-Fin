import 'dart:convert';

import 'package:ifb_loan/features/profile/data/data_provider/profile_data_provider.dart';

class ProfileRepository {
  final ProfileDataProvider profileDataProvider;
  ProfileRepository(this.profileDataProvider);

  Future<bool> getProfile() async {
    try {
      final response = await profileDataProvider.getProfile();
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['response']['isPublic'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> updateProfile(bool isPublic) async {
    try {
      final response = await profileDataProvider.updateProfile(isPublic);
      final data = jsonDecode(response);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}