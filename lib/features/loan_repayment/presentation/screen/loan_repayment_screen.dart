import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/finances/bloc/finances_bloc.dart';
import 'package:ifb_loan/features/finances/models/active_loan_model.dart';
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
  final String loanStatus;
  const LoanRepaymentScreen(
      {super.key,
      required this.name,
      required this.id,
      required this.sector,
      required this.totalPayableAmount,
      required this.productQuantity,
      required this.penalty,
      required this.outStandingAmount,
      required this.loanStatus});

  @override
  State<LoanRepaymentScreen> createState() => _LoanRepaymentScreenState();
}

class _LoanRepaymentScreenState extends State<LoanRepaymentScreen> {
  @override
  void initState() {
    super.initState();
    fetchLoans();
    context
        .read<LoanRepaymentBloc>()
        .add(GetRepaymentHistoryEvent(loanId: widget.id));
  }

  fetchLoans() async {
    context.read<FinancesBloc>().add(FetchActiveLoans());
  }

  ActiveLoanModel? activeLoan;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Repayment Status",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<FinancesBloc, FinancesState>(
        builder: (context, state) {
          if (state is ActiveLoansFetchedSuccess) {
            activeLoan =
                state.activeLoans.firstWhere((loan) => loan.id == widget.id);
          }
          return Column(
            children: [
              SingleChildScrollView(
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
                          loanStatus: activeLoan?.loanStatus ?? '',
                          penalty: activeLoan?.penaltyAmount ?? '',
                          outStandingAmount:
                              activeLoan?.outstandingAmount ?? '',
                          loanTitle: activeLoan?.name ?? '',
                          loanDescription: activeLoan?.productQuantity ?? '',
                          amount: activeLoan?.totalPayableAmount ?? '',
                          // lender: 'ABC General Trading',
                          backgroundColor: activeLoan?.loanStatus == "ACTIVE"
                              ? Colors.blue.shade100
                              : Colors.orange.shade100,
                          image:
                              activeLoan?.sector.toLowerCase() == "electronics"
                                  ? Image.asset(
                                      'assets/images/elec.png', // replace with your image asset
                                      fit: BoxFit.contain,
                                    )
                                  : activeLoan?.sector.toLowerCase() ==
                                          "agriculture"
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
                      if (activeLoan?.loanStatus == "ACTIVE")
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: MyButton(
                              backgroundColor: AppColors.primaryDarkColor,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PaymentPage(
                                      loanId: activeLoan?.id ?? '',
                                      amount:
                                          activeLoan?.outstandingAmount ?? '',
                                    ),
                                  ),
                                ).then((value) {
                                  print('value');
                                  context.read<LoanRepaymentBloc>().add(
                                      GetRepaymentHistoryEvent(
                                          loanId: widget.id));
                                });
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
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is LoanRepaymentSuccess) {
                            if (state.repaymentHistory.isEmpty) {
                              return const Center(
                                  child: Text("No repayment history found"));
                            }
                            return SizedBox(
                              height: ScreenConfig.screenHeight * 0.55,
                              child: ListView.builder(
                                itemCount: state.repaymentHistory.length,
                                itemBuilder: (context, index) {
                                  var payments = List.from(
                                      state.repaymentHistory)
                                    ..sort((a, b) =>
                                        b.paymentDate.compareTo(a.paymentDate));
                                  final payment = payments[index];

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
            ],
          );
        },
      ),
    );
  }
}
