import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_status_table.dart';

class LoanApprovalStatus extends StatefulWidget {
  final String id;
  const LoanApprovalStatus({super.key, required this.id});

  @override
  State<LoanApprovalStatus> createState() => _LoanApprovalStatusState();
}

class _LoanApprovalStatusState extends State<LoanApprovalStatus> {
  var loading = false;
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
              const LoanStatusTable(items: [
                {'name': 'Laptop', 'quantity': 3, 'total': '81,000'},
                {'name': 'Tablet Phone', 'quantity': 10, 'total': '64,000'},
                {'name': 'Smart Phone', 'quantity': 7, 'total': '49,000'},
                {'name': 'Smart TV', 'quantity': 10, 'total': '72,000'},
              ]),
              const SizedBox(height: 16),
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                    "If you accept these offer from the merchant click the button bellow and the bank officials will review the loan application"),
              ),
              MyButton(
                  backgroundColor: loading
                      ? AppColors.iconColor
                      : AppColors.primaryDarkColor,
                  onPressed: loading
                      ? () {}
                      : () {
                          setState(() {
                            loading = true;
                          });
                        },
                  buttonText: loading
                      ? SizedBox(
                          height: ScreenConfig.screenHeight * 0.02,
                          width: ScreenConfig.screenHeight * 0.02,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Text(
                          "Accept Offer",
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
