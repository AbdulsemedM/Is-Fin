import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/loan_list_widget.dart';

class NewLoanApplications extends StatefulWidget {
  final List<StatusProductListModel> loanformList;
  const NewLoanApplications({super.key, required this.loanformList});

  @override
  State<NewLoanApplications> createState() => _NewLoanApplicationsState();
}

class _NewLoanApplicationsState extends State<NewLoanApplications> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const ProviderLoanFormScreen()));
      },
      child: SizedBox(
        height: ScreenConfig.screenHeight * 0.77,
        child: ListView(
          children: widget.loanformList.map((transaction) {
            return LoanListWidget(
              id: transaction.id,
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
      ),
    );
  }
}
