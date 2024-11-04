import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class KycProgressCard extends StatelessWidget {
  final String title;
  final double percent;

  const KycProgressCard({
    Key? key,
    required this.title,
    required this.percent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: AppColors.primaryDarkColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Percentage Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${(percent * 100).toStringAsFixed(0)}%', // Display the percentage
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            // Progress Bar
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: percent, // Set the progress value
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                minHeight: 10,
              ),
            ),
            SizedBox(height: 16),
            // Steps Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Step 2",
                  style: TextStyle(color: Colors.white),
                ),
                Row(
                  children: [
                    Text(
                      "Step 3",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
