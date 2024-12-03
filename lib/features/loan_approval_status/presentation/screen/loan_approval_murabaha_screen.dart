import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';

class LoanApprovalMurabahaScreen extends StatefulWidget {
  final String murabahaAgreementDocument;
  final String id;
  const LoanApprovalMurabahaScreen({
    super.key,
    required this.murabahaAgreementDocument,
    required this.id,
  });

  @override
  State<LoanApprovalMurabahaScreen> createState() =>
      _LoanApprovalMurabahaScreenState();
}

class _LoanApprovalMurabahaScreenState
    extends State<LoanApprovalMurabahaScreen> {
  String originalPrice = '';
  String markUp = '';
  String repaymentPlan = '';
  String supplierName = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murabaha Agreement'),
      ),
      body: BlocListener<LoanApprovalStatusBloc, LoanApprovalStatusState>(
        listener: (context, state) {
          if (state is FetchMurabahaAgreementSuccess) {
            setState(() {
              isLoading = false;
              originalPrice = state.murabahaAgreement.originalPrice;
              markUp = state.murabahaAgreement.markUp;
              repaymentPlan = state.murabahaAgreement.repaymentPlan;
              supplierName = state.murabahaAgreement.supplierName;
            });
          } else if (state is FetchMurabahaAgreementFailure) {
            displaySnack(context, state.errorMessage, Colors.red);
            Navigator.pop(context);
          } else if (state is FetchMurabahaAgreementLoading) {
            setState(() {
              isLoading = true;
            });
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Text(
                          "Congratulation! Your loan application from $supplierName has been approved by the product owner and by the bank officials. The total price as the owner gives is ETB $originalPrice, then the bank has added it’s benefits to the product price and now the final offer is ETB ${double.parse(markUp) + double.parse(originalPrice)} in $repaymentPlan repayment plan.Now you have pick your product from the owner ASAP.")
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
