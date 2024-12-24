import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/loan_display_card.dart';
import 'package:ifb_loan/features/loan_repayment/bloc/loan_repayment_bloc.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/screen/payment_page.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/widgets/repayment_list_card.dart';
// import 'package:ifb_loan/features/repayment/presentation/screen/reciept_screen.dart';
import 'package:intl/intl.dart';

class LoanRepaymentScreen extends StatefulWidget {
  final String name;
  final String id;
  final String sector;
  final String totalPayableAmount;
  final String productQuantity;
  final String penalty;
  final String outStandingAmount;
  const LoanRepaymentScreen(
      {super.key,
      required this.name,
      required this.id,
      required this.sector,
      required this.totalPayableAmount,
      required this.productQuantity,
      required this.penalty,
      required this.outStandingAmount});

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LoanRepaymentBloc>().add(GetRepaymentHistoryEvent());
  }

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
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const ReceiptPage(
                  //       transactionId:
                  //           'TXN123', // Replace with actual transaction ID
                  //       customerName:
                  //           'John Doe', // Replace with actual customer name
                  //       amount: 199.99, // Replace with actual amount
                  //     ),
                  //   ),
                  // );
                },
                child: LoanCard(
                  penalty: widget.penalty,
                  outStandingAmount: widget.outStandingAmount,
                  loanTitle: widget.name,
                  loanDescription: widget.productQuantity,
                  amount: widget.totalPayableAmount,
                  // lender: 'ABC General Trading',
                  backgroundColor: Colors.blue.shade100,
                  image: widget.sector.toLowerCase() == "electronics"
                      ? Image.asset(
                          'assets/images/elec.png', // replace with your image asset
                          fit: BoxFit.contain,
                        )
                      : widget.sector.toLowerCase() == "agriculture"
                          ? Image.asset(
                              'assets/images/agri.png', // replace with your image asset
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              'assets/images/elec.png', // replace with your image asset
                              fit: BoxFit.contain,
                            ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: MyButton(
                    backgroundColor: AppColors.primaryDarkColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            loanId: widget.id,
                          ),
                        ),
                      );
                    },
                    buttonText: Text("Pay",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    "Repayment History",
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              BlocBuilder<LoanRepaymentBloc, LoanRepaymentState>(
                builder: (context, state) {
                  if (state is LoanRepaymentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is LoanRepaymentSuccess) {
                    if (state.repaymentHistory.isEmpty) {
                      return const Center(
                          child: Text("No repayment history found"));
                    }
                    return SizedBox(
                      height: ScreenConfig.screenHeight * 0.7,
                      child: ListView.builder(
                        itemCount: state.repaymentHistory.length,
                        itemBuilder: (context, index) {
                          final payment = state.repaymentHistory[index];
                          return PaymentCard(
                            transactionId: payment.transactionId,
                            date: payment.paymentDate,
                            status: "Paid",
                            statusColor: Colors.green,
                            amount: NumberFormat('#,###.##')
                                .format(double.parse(payment.amount)),
                            currency: "ETB",
                          );
                        },
                      ),
                    );
                  }
                  if (state is LoanRepaymentFailure) {
                    return Text(state.errorMessage);
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
