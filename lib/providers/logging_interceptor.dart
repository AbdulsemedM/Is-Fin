// logging_interceptor.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoggingInterceptor {
  void logRequest(
      String url, String method, Map<String, String> headers, dynamic body) {
    print('Request: $method $url');
    print('Headers: ${jsonEncode(headers)}');
    if (body != null) print('Body: ${jsonEncode(body)}');
  }

  void logResponse(http.Response response) {
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');
  }

  void logError(Object error) {
    print('Request Error: $error');
  }
}
