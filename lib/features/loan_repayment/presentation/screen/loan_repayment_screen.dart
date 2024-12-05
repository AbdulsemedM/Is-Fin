import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/loan_display_card.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/widgets/repayment_list_card.dart';

class LoanRepaymentScreen extends StatefulWidget {
  const LoanRepaymentScreen({super.key});

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Repayment Status",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              LoanCard(
                loanTitle: 'Loan 1',
                loanDescription: '10 Mobiles and 10 TVs',
                amount: "1150",
                // lender: 'ABC General Trading',
                backgroundColor: Colors.blue.shade100,
                image: Image.asset(
                  'assets/images/elec.png', // replace with your image asset
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Repayment Schedules",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenConfig.screenHeight * 0.7,
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: paymentData.length,
                  itemBuilder: (context, index) {
                    final payment = paymentData[index];
                    return PaymentCard(
                      roundNumber: payment['roundNumber'],
                      date: payment['date'],
                      status: payment['status'],
                      statusColor: payment['statusColor'],
                      amount: payment['amount'],
                      currency: payment['currency'],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> paymentData = [
    {
      'roundNumber': 4,
      'date': 'Sep 20, 2024',
      'status': 'Pending',
      'statusColor': Colors.amber,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
    {
      'roundNumber': 3,
      'date': 'May 20, 2024',
      'status': 'Paid',
      'statusColor': Colors.green,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
    {
      'roundNumber': 3,
      'date': 'May 20, 2024',
      'status': 'Paid',
      'statusColor': Colors.green,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
    {
      'roundNumber': 4,
      'date': 'Sep 20, 2024',
      'status': 'Pending',
      'statusColor': Colors.green,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
    {
      'roundNumber': 3,
      'date': 'May 20, 2024',
      'status': 'Paid',
      'statusColor': Colors.green,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
    {
      'roundNumber': 4,
      'date': 'Sep 20, 2024',
      'status': 'Pending',
      'statusColor': Colors.amber,
      'amount': '30,000.32',
      'currency': 'ETB',
    },
  ];
}
