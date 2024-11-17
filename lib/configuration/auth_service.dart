import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  // Store the token
  Future<void> storeToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  // Retrieve the token
  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // Delete the token
  Future<void> deleteToken() async {
    await _storage.delete(key: 'auth_token');
  }
}
