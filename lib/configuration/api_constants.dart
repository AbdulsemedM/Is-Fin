import 'package:ifb_loan/providers/provider_setup.dart';

class ApiConstants {
  static const String baseUrl = 'https://api.yourbaseurl.com/';
  Future<void> fetchData() async {
    final apiProvider = ProviderSetup.getApiProvider(
      baseUrl,
      authToken: 'your-auth-token',
    );
    try {
      final response = await apiProvider.getRequest('/endpoint');
      print('Data: ${response.body}');
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
}
