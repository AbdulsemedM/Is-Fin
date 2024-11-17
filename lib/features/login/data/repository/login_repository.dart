// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/configuration/auth_service.dart';
import 'package:ifb_loan/features/login/data/data_provider/login_data_provider.dart';

class LoginRepository {
  final LoginDataProvider loginDataProvider;
  LoginRepository(this.loginDataProvider);

  Future<String> sendLogin(String phoneNumber, String password) async {
    final authService = AuthService();
    try {
      print("here we gooooo");
      final loginData =
          await loginDataProvider.sendLogin(phoneNumber, password);

      final data = jsonDecode(loginData);
      if (data['httpStatus'] != 200) {
        // Log the message if needed
        print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }

      // Store the token if the login is successful
      await authService.storeToken(data['response']['token']);

      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      print('Caught Exception: $e');
      throw e; // This will throw only the `message` part if thrown from above
    }
  }
}
