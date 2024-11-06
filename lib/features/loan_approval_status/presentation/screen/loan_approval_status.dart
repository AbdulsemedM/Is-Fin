import 'package:flutter/material.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_status_table.dart';

class LoanApprovalStatus extends StatefulWidget {
  const LoanApprovalStatus({super.key});

  @override
  State<LoanApprovalStatus> createState() => _LoanApprovalStatusState();
}

class _LoanApprovalStatusState extends State<LoanApprovalStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Approval Status",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Text(
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                  'Your loan application from ABC General Trading  has been approved by the product owner and now it is under review by the bank’s officials. The bank will put it’s benefits to the product and will let you know the final offer soon.'),
              LoanStatusTable(items: [
                {'name': 'Laptop', 'quantity': 3, 'total': '81,000'},
                {'name': 'Tablet Phone', 'quantity': 10, 'total': '64,000'},
                {'name': 'Smart Phone', 'quantity': 7, 'total': '49,000'},
                {'name': 'Smart TV', 'quantity': 10, 'total': '72,000'},
              ]),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "ETB 127,000",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
