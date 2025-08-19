String formatPdfUrl(String url) {
  // Use RegExp to match any host (IP or domain) and port before /api/
  return url.replaceFirst(
      RegExp(r'https?://[^/]+(?=\/api\/)'),
      'https://michumizan.coopbankoromiasc.com');
      // 'http://10.8.100.45:8080');
}
