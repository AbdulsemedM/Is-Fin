import 'package:flutter/material.dart';

class CustomListButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const CustomListButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color(0xFFF5E8E1), // Background color similar to your example
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          elevation: 0, // No shadow
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
