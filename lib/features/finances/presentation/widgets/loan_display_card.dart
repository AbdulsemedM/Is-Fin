import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanCard extends StatelessWidget {
  final String loanTitle;
  final String loanDescription;
  final String amount;
  // final String lender;
  final Color backgroundColor;
  final String currency;
  final Widget image;
  final String penalty;
  final String outStandingAmount;
  final String loanStatus;

  const LoanCard({
    super.key,
    required this.loanTitle,
    required this.loanDescription,
    required this.amount,
    // required this.lender,
    required this.backgroundColor,
    this.currency = 'ETB',
    required this.image,
    required this.penalty,
    required this.outStandingAmount,
    required this.loanStatus,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(loanTitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    )),
                if (loanStatus != "ACTIVE")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Inactive',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                if (loanStatus == "ACTIVE")
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Active',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Quantity: ${NumberFormat('#,###').format(double.parse(loanDescription))}",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${NumberFormat('#,###.##').format(double.parse(amount))} $currency',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'As of today: ${NumberFormat('#,###.##').format(double.parse(outStandingAmount))} ETB',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Penalty: ${NumberFormat('#,###.##').format(double.parse(penalty))} ETB',
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
