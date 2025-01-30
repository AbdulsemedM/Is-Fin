import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:io';

class SecureHttpClient extends http.BaseClient {
  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    SecurityContext context = SecurityContext(withTrustedRoots: true);

    try {
      // Load your certificate
      ByteData data =
          await rootBundle.load('assets/certificates/your_certificate.pem');
      context.setTrustedCertificatesBytes(data.buffer.asUint8List());

      // Create HttpClient with the secure context
      HttpClient client = HttpClient(context: context);

      // Verify hostname
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        // Implement additional certificate validation if needed
        return false; // Return false to reject invalid certificates
      };

      return _inner.send(request);
    } catch (e) {
      throw Exception('Certificate validation failed: $e');
    }
  }

  @override
  void close() {
    _inner.close();
  }
}
