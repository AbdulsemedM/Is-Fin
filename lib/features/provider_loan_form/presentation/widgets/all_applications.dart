import 'package:flutter/widgets.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/provider_loan_list_widget.dart';

class AllApplications extends StatefulWidget {
  final List<Map<String, dynamic>> loanformList;

  const AllApplications({super.key, required this.loanformList});

  @override
  State<AllApplications> createState() => _AllApplicationsState();
}

class _AllApplicationsState extends State<AllApplications> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
    );
  }
}
