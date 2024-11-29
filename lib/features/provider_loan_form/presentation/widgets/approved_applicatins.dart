import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_loan_list_widget.dart';

class ApprovedApplicatins extends StatefulWidget {
  final List<StatusProductListModel> loanformList;
  const ApprovedApplicatins({super.key, required this.loanformList});

  @override
  State<ApprovedApplicatins> createState() => _ApprovedApplicatinsState();
}

class _ApprovedApplicatinsState extends State<ApprovedApplicatins> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenHeight * 0.77,
      child: ListView(
        children: widget.loanformList.map((transaction) {
          return ProviderLoanListWidget(
            status: transaction.status,
            id: transaction.id,
            name: transaction.buyerFullName,
            amount: transaction.totalAmount?.toString() ?? "",
            description: transaction.sectorName,
            date: transaction.requestedAt,
            icon: transaction.status == "PENDING"
                ? Icons.timer
                : transaction.status == "ACCEPTED"
                    ? Icons.arrow_circle_up_sharp
                    : transaction.status == "APPROVED"
                        ? Icons.done
                        : Icons.close,
            iconColor: transaction.status == "PENDING"
                ? Colors.orange
                : transaction.status == "ACCEPTED"
                    ? Colors.green
                    : transaction.status == "APPROVED"
                        ? Colors.blue
                        : Colors.red,
          );
        }).toList(),
      ),
    );
  }
}
