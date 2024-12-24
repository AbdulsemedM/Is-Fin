import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/finances/bloc/finances_bloc.dart';
import 'package:ifb_loan/features/finances/models/active_loan_model.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/loan_display_card.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/screen/loan_repayment_screen.dart';

class OverallLoanList extends StatefulWidget {
  const OverallLoanList({super.key});

  @override
  State<OverallLoanList> createState() => _OverallLoanListState();
}

class _OverallLoanListState extends State<OverallLoanList> {
  @override
  void initState() {
    super.initState();
    fetchLoans();
  }

  fetchLoans() async {
    context.read<FinancesBloc>().add(FetchActiveLoans());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Overall Loan List",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocBuilder<FinancesBloc, FinancesState>(
        builder: (context, state) {
          if (state is ActiveLoansFetchedLoading) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is ActiveLoansFetchedFailure) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Failed to load loans',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            );
          }

          final loans = state is ActiveLoansFetchedSuccess
              ? state.activeLoans
              : <ActiveLoanModel>[];

          if (loans.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'No loans available',
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
            );
          }

          return SizedBox(
            height: ScreenConfig.screenHeight,
            child: ListView.builder(
              itemCount: loans.length,
              itemBuilder: (context, index) {
                final loan = loans[index];
                return GestureDetector(
                  onTap: () {
                    if (loan.loanStatus == 'ACTIVE') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoanRepaymentScreen(
                            penalty: loan.penaltyAmount,
                            outStandingAmount: loan.outstandingAmount,
                            name: loan.name,
                            id: loan.id,
                            sector: loan.sector,
                            totalPayableAmount: loan.totalPayableAmount,
                            productQuantity: loan.productQuantity,
                          ),
                        ),
                      ).then((value) => fetchLoans());
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: LoanCard(
                      penalty: loan.penaltyAmount,
                      outStandingAmount: loan.outstandingAmount,
                      loanTitle: loan.name,
                      loanDescription: loan.productQuantity,
                      amount: loan.totalPayableAmount,
                      backgroundColor: _getBackgroundColor(index),
                      image: _getLoanImage(loan.sector),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getBackgroundColor(int index) {
    // Alternate colors for the loan cards
    return index % 2 == 0 ? Colors.blue.shade100 : Colors.orange.shade100;
  }

  Image _getLoanImage(String type) {
    // Return different images based on loan type
    switch (type.toLowerCase()) {
      case 'electronics':
        return Image.asset(
          'assets/images/elec.png',
          fit: BoxFit.contain,
        );
      case 'agriculture':
        return Image.asset(
          'assets/images/agri.png',
          fit: BoxFit.contain,
        );
      default:
        return Image.asset(
          'assets/images/default.png', // Default image
          fit: BoxFit.contain,
        );
    }
  }
}
