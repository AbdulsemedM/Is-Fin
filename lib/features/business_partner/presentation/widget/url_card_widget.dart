import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';

class UrlCard extends StatelessWidget {
  final String url;
  final VoidCallback onShare;

  const UrlCard({
    super.key,
    required this.url,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          // URL text
          Expanded(
            child: Text(
              url,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Copy icon
          IconButton(
            icon: Icon(Icons.copy, color: Colors.grey[700]),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: url));
              displaySnack(context, "URL copied to clipboard", Colors.black);
            },
          ),

          // Share icon
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black87),
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}
