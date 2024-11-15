// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/features/signup/data/data_provider/signup_data_provider.dart';
import 'package:ifb_loan/features/signup/models/signup_model.dart';

class SignupRepository {
  final SignupDataProvider signupDataProvider;
  SignupRepository(this.signupDataProvider);

  Future<SignupModel> sendSignup(String fullName, String phoneNumber,
      String password, String? email) async {
    try {
      final signupData = await signupDataProvider.sendSignup(
          fullName, phoneNumber, password, email);

      final data = jsonDecode(signupData);

      if (data['httpStatus'] != 201) {
        throw data['message'];
      }

      return SignupModel.fromMap(data['response']);
    } catch (e) {
      throw e.toString();
    }
  }
}
