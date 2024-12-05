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
            id: transaction.id,
            promiseToPurchaseDocument:
                transaction.promiseToPurchaseDocument ?? "",
            murabahaAgreementDocument:
                transaction.murabahaAgreementDocument ?? "",
            agentAgreementDocument: transaction.agentAgreementDocument ?? "",
            undertakingAgreementtDocument:
                transaction.undertakingAgreementDocument ?? "",
            status: transaction.status,
            name: transaction.supplierFullName,
            amount: transaction.totalAmount?.toString() ?? "",
            description: transaction.sectorName,
            date: transaction.requestedAt,
            icon: transaction.status == "PENDING"
                ? Icons.timer
                : transaction.status == "ACCEPTED"
                    ? Icons.arrow_circle_up_sharp
                    : transaction.status == "APPROVED"
                        ? Icons.done
                        : transaction.status == "UNDER_REVIEW"
                            ? Icons.access_alarms_outlined
                            : transaction.status == "MURABAHA_AGREEMENT"
                                ? Icons.list
                                : transaction.status == "UNDER_TAKING"
                                    ? Icons.takeout_dining_outlined
                                    : Icons.close,
            iconColor: transaction.status == "PENDING"
                ? Colors.orange
                : transaction.status == "ACCEPTED"
                    ? Colors.green
                    : transaction.status == "APPROVED"
                        ? Colors.blue
                        : transaction.status == "UNDER_REVIEW"
                            ? Colors.amber
                            : transaction.status == "MURABAHA_AGREEMENT"
                                ? Colors.purple
                                : transaction.status == "UNDER_TAKING"
                                    ? Colors.brown
                                    : Colors.red,
          );
        }).toList(),
      ),
    );
  }
}
