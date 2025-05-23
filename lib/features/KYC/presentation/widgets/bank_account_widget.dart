import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String name;
  final String id;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AccountCard({
    super.key,
    required this.name,
    required this.id,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Accept Icon
          GestureDetector(
            onTap: onAccept,
            child: CircleAvatar(
              backgroundColor: Colors.green[100],
              child: const Icon(
                Icons.check,
                color: Colors.green,
              ),
            ),
          ),
          const SizedBox(width: 12.0),

          // Name and ID
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  id,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Reject Icon
          // GestureDetector(
          //   onTap: onReject,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.red[100],
          //     child: Icon(
          //       Icons.close,
          //       color: Colors.red,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
