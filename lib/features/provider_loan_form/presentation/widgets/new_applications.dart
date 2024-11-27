import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_loan_form_screen.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_loan_list_widget.dart';

class NewApplications extends StatefulWidget {
  final List<Map<String, dynamic>> loanformList;
  const NewApplications({super.key, required this.loanformList});

  @override
  State<NewApplications> createState() => _NewApplicationsState();
}

class _NewApplicationsState extends State<NewApplications> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ProviderLoanFormScreen()));
      },
      child: SizedBox(
        height: ScreenConfig.screenHeight * 0.77,
        child: ListView(
          children: widget.loanformList.map((transaction) {
            return ProviderLoanListWidget(
              name: transaction["name"],
              amount: transaction["amount"],
              description: transaction["description"],
              date: transaction["date"],
              icon: transaction["icon"],
              iconColor: transaction["iconColor"],
            );
          }).toList(),
        ),
      ),
    );
  }
}
