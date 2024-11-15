import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Loan Status"),
      ),
      body: Center(
        child: LoanStatusCard(),
      ),
    );
  }
}

class LoanStatusCard extends StatelessWidget {
  final double availableLoan = 15000.0;
  final double receivedLoan = 30000.0;
  final double maxLoan = 100000.0;

  @override
  Widget build(BuildContext context) {
    double loanProgress = receivedLoan / maxLoan;

    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Available Loan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "${availableLoan.toInt()} Birr",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${receivedLoan.toInt()} Birr received",
                style: TextStyle(
                  color: Colors.white, // Different color for emphasis
                  fontSize: 16.0, // Larger font size
                  fontWeight: FontWeight.w700, // Bold font
                ),
              ),
              Text(
                "${maxLoan.toInt()} Birr max",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: loanProgress,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 10,
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
