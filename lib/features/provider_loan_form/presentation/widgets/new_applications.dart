import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_loan_list_widget.dart';

class NewApplications extends StatefulWidget {
  final List<StatusProductListModel> loanformList;
  const NewApplications({super.key, required this.loanformList});

  @override
  State<NewApplications> createState() => _NewApplicationsState();
}

class _NewApplicationsState extends State<NewApplications> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: ScreenConfig.screenHeight * 0.77,
        child: ListView(
          children: widget.loanformList.map((transaction) {
            return GestureDetector(
              onTap: () {},
              child: ProviderLoanListWidget(
                id: transaction.id,
                name: transaction.buyerFullName,
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
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
