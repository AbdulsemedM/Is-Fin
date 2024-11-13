// auth_interceptor.dart
class AuthInterceptor {
  final String? token;

  AuthInterceptor({this.token});

  Future<Map<String, String>> getHeaders() async {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
