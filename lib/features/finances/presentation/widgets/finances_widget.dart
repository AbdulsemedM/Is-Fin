import 'package:flutter/material.dart';

class FinancesCard extends StatelessWidget {
  final IconData icon;
  final Color iconContainerColor;
  final String title;
  final String subtitle;
  final Color containerColor;
  final VoidCallback onTap;

  const FinancesCard({
    super.key,
    required this.icon,
    required this.iconContainerColor,
    required this.title,
    required this.subtitle,
    required this.containerColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: iconContainerColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24.0,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
