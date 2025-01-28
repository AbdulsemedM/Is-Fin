import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_list_widget.dart';

class AllLoanApplications extends StatefulWidget {
  final List<StatusProductListModel> loanformList;

  const AllLoanApplications({super.key, required this.loanformList});

  @override
  State<AllLoanApplications> createState() => _AllLoanApplicationsState();
}

class _AllLoanApplicationsState extends State<AllLoanApplications> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenHeight * 0.77,
      child: ListView(
        children: widget.loanformList.map((transaction) {
          return LoanListWidget(
            id: transaction.id,
            rejectionReason: transaction.rejectionReason ?? "",
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
                                    ? Icons.bubble_chart_outlined
                                    : transaction.status == "AGREEMENT_ACCEPTED"
                                        ? Icons.done
                                        : transaction.status == "LOAN_ACCEPTED"
                                            ? Icons.check_circle
                                            : transaction.status == "CLOSED"
                                                ? Icons.auto_awesome_outlined
                                                : Icons.close,
            iconColor: transaction.status == "PENDING"
                ? Colors.orange
                : transaction.status == "ACCEPTED"
                    ? Colors.lime
                    : transaction.status == "APPROVED"
                        ? Colors.blue
                        : transaction.status == "UNDER_REVIEW"
                            ? Colors.amber
                            : transaction.status == "MURABAHA_AGREEMENT"
                                ? Colors.purple
                                : transaction.status == "UNDER_TAKING"
                                    ? Colors.cyan
                                    : transaction.status == "AGREEMENT_ACCEPTED"
                                        ? Colors.green
                                        : transaction.status == "LOAN_ACCEPTED"
                                            ? const Color.fromARGB(
                                                255, 33, 243, 191)
                                            : transaction.status == "CLOSED"
                                                ? Colors.indigo
                                                : Colors.red,
          );
        }).toList(),
      ),
    );
  }
}
