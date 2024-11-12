import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/add_bisiness_partner_screen.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/finances_widget.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/loan_display_card.dart';
import 'package:ifb_loan/features/loan_application/presentation/screen/loan_application_screen.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_approval_status.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/screen/loan_repayment_screen.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              "Finances",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: ScreenConfig.screenHeight * 0.45,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return FinancesCard(
                  icon: Icons.file_copy,
                  iconContainerColor: index == 0
                      ? Colors.blue.shade200
                      : index == 1
                          ? Colors.orange.shade200
                          : index == 2
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                  title: index == 0
                      ? "Loan Request"
                      : index == 1
                          ? "Loan Repay"
                          : index == 2
                              ? "Loan Status"
                              : "Add Provider",
                  subtitle: 'Subtitle $index',
                  containerColor: index == 0
                      ? Colors.blue.shade100
                      : index == 1
                          ? Colors.orange.shade100
                          : index == 2
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                  onTap: () {
                    if (index == 0) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoanApplicationScreen()));
                    } else if (index == 3) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AddBisinessPartnerScreen()));
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoanApprovalStatus()));
                    }
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "Overall loan History",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(
          height: ScreenConfig.screenHeight * 0.4,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoanRepaymentScreen()));
                },
                child: LoanCard(
                  loanTitle: 'Loan 1',
                  loanDescription: '10 Mobiles and 10 TVs',
                  amount: 1150,
                  lender: 'ABC General Trading',
                  backgroundColor: Colors.blue.shade100,
                  image: Image.asset(
                    'assets/images/elec.png', // replace with your image asset
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              LoanCard(
                loanTitle: 'Loan 2',
                loanDescription: 'Coffee plant grain picker',
                amount: 7000,
                lender: 'XYZ Import and Export',
                backgroundColor: Colors.orange.shade100,
                image: Image.asset(
                  'assets/images/agri.png', // replace with your image asset
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
