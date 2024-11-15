// api_provider.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ifb_loan/configuration/api_constants.dart';
import 'auth_interceptor.dart';
import 'error_interceptor.dart';
import 'logging_interceptor.dart';

class ApiProvider {
  // final String baseUrl;
  final AuthInterceptor authInterceptor;
  final ErrorInterceptor errorInterceptor;
  final LoggingInterceptor loggingInterceptor;

  ApiProvider({
    // required this.baseUrl,
    required this.authInterceptor,
    required this.errorInterceptor,
    required this.loggingInterceptor,
  });
  Future<http.Response> getRequest(String endpoint) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await authInterceptor.getHeaders();

    try {
      final response = await http.get(url, headers: headers);
      loggingInterceptor.logRequest(url.toString(), 'GET', headers, null);
      loggingInterceptor.logResponse(response);
      errorInterceptor.checkError(response);
      return response;
    } catch (error) {
      loggingInterceptor.logError(error);
      rethrow;
    }
  }

  Future<http.Response> postRequest(
      String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('${ApiConstants.baseUrl}$endpoint');
    final headers = await authInterceptor.getHeaders();

    try {
      print("here is the provider");
      print(body);
      print(url);
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      loggingInterceptor.logRequest(url.toString(), 'POST', headers, body);
      loggingInterceptor.logResponse(response);
      errorInterceptor.checkError(response);
      return response;
    } catch (error) {
      loggingInterceptor.logError(error);
      rethrow;
    }
  }
}
