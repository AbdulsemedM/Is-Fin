import 'package:flutter/material.dart';

class LoanCard extends StatelessWidget {
  final String loanTitle;
  final String loanDescription;
  final double amount;
  final String lender;
  final Color backgroundColor;
  final String currency;
  final Widget image;

  const LoanCard({
    super.key,
    required this.loanTitle,
    required this.loanDescription,
    required this.amount,
    required this.lender,
    required this.backgroundColor,
    this.currency = 'ETB',
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        trailing: SizedBox(
          width: 60,
          height: 60,
          child: image, // Display the image as leading icon
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              loanTitle,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              loanDescription,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${amount.toStringAsFixed(2)} $currency',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        // subtitle: Text(
        //   lender,
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: Colors.grey[800],
        //   ),
        // ),
      ),
    );
  }
}
