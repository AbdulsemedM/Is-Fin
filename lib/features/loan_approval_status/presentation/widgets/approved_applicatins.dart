import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_list_widget.dart';

class ApprovedLoanApplicatins extends StatefulWidget {
  final List<StatusProductListModel> loanformList;
  const ApprovedLoanApplicatins({super.key, required this.loanformList});

  @override
  State<ApprovedLoanApplicatins> createState() =>
      _ApprovedLoanApplicatinsState();
}

class _ApprovedLoanApplicatinsState extends State<ApprovedLoanApplicatins> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenHeight * 0.77,
      child: ListView(
        children: widget.loanformList.map((transaction) {
          return LoanListWidget(
            name: transaction.supplierFullName,
            amount: transaction.totalAmount?.toString() ?? "",
            description: transaction.sectorName,
            date: transaction.requestedAt,
            icon: transaction.status == "PENDING"
                ? Icons.timer
                : transaction.status == "APPROVED"
                    ? Icons.check
                    : Icons.close,
            iconColor: transaction.status == "PENDING"
                ? Colors.orange
                : transaction.status == "APPROVED"
                    ? Colors.green
                    : Colors.red,
          );
        }).toList(),
      ),
    );
  }
}
