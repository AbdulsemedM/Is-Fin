import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loan Status"),
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

  const LoanStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    double loanProgress = receivedLoan / maxLoan;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Available Loan",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "ETB ${availableLoan.toInt()}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ETB ${receivedLoan.toInt()} received",
                style: const TextStyle(
                  color: Colors.white, // Different color for emphasis
                  fontSize: 16.0, // Larger font size
                  fontWeight: FontWeight.w700, // Bold font
                ),
              ),
              Text(
                "ETB ${maxLoan.toInt()} max",
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: loanProgress,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
