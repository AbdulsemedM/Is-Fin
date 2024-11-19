// auth_interceptor.dart
import 'package:ifb_loan/configuration/auth_service.dart';

class AuthInterceptor {
  String? token;

  AuthInterceptor({this.token});

  // Fetches token and assigns it to the instance variable
  Future<void> fetchToken() async {
    try {
      final authService = AuthService();
      token = await authService.getToken(); // Assign directly
      print('Token fetched: $token');
    } catch (e) {
      print('Failed to fetch token: $e');
    }
  }

  // Generates headers with the token (if available)
  Future<Map<String, String>> getHeaders() async {
    if (token == null) {
      await fetchToken(); // Ensure the token is fetched
    }
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
