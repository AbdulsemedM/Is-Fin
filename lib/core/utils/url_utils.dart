String formatPdfUrl(String url) {
  // Use RegExp to match any host (IP or domain) and port before /api/
  return url.replaceFirst(RegExp(r'https?://[^/]+(?=\/api\/)'),
      'https://michumizan.coopbankoromiasc.com');
}
