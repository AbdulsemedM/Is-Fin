import 'package:flutter/material.dart';

class HomeIconWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onClicked; // Callback function for click events

  const HomeIconWidget({super.key, 
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClicked, // Call the onClicked function when tapped
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
