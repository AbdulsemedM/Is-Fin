import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UrlCard extends StatelessWidget {
  final String url;
  final VoidCallback onShare;

  const UrlCard({
    Key? key,
    required this.url,
    required this.onShare,
  }) : super(key: key);

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
              style: TextStyle(
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('URL copied to clipboard')),
              );
            },
          ),

          // Share icon
          IconButton(
            icon: Icon(Icons.share, color: Colors.black87),
            onPressed: onShare,
          ),
        ],
      ),
    );
  }
}
