// error_interceptor.dart
import 'package:http/http.dart' as http;

class ErrorInterceptor {
  void checkError(http.Response response) {
    if (response.statusCode >= 400) {
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }
}
