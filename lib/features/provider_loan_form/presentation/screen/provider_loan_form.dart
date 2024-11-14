import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/all_applications.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/approved_applicatins.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/new_applications.dart';

class ProviderLoanForm extends StatefulWidget {
  const ProviderLoanForm({super.key});

  @override
  State<ProviderLoanForm> createState() => _ProviderLoanFormState();
}

class _ProviderLoanFormState extends State<ProviderLoanForm> {
  final _selectedSegment = ValueNotifier('new');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Provider Loan Form",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: Column(
            children: [
              Text(
                "Fill a Form",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // _buildLabel('Multiple Items'),
                  AdvancedSegment(
                    activeStyle: const TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w700),
                    inactiveStyle: const TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w500),
                    itemPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    backgroundColor: AppColors.iconColor,
                    sliderColor: AppColors.primaryDarkColor,
                    controller: _selectedSegment,
                    segments: {
                      'new': 'New',
                      'all': 'All',
                      'approved': 'Approved',
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder<String>(
                    valueListenable: _selectedSegment,
                    builder: (_, selectedSegment, __) {
                      if (selectedSegment == 'new') {
                        return NewApplications(
                          loanformList: loanformList,
                        );
                      } else if (selectedSegment == 'all') {
                        return AllApplications(
                          loanformList: loanformList,
                        );
                      } else if (selectedSegment == 'approved') {
                        return ApprovedApplicatins(
                          loanformList: loanformList,
                        );
                      }
                      return SizedBox.shrink(); // Empty widget if no match
                    },
                  ),
                  // SizedBox(
                  //   height: 100,
                  //   child: ListView(
                  //     children: loanformList.map((transaction) {
                  //       return ProviderLoanListWidget(
                  //         name: transaction["name"],
                  //         amount: transaction["amount"],
                  //         description: transaction["description"],
                  //         date: transaction["date"],
                  //         icon: transaction["icon"],
                  //         iconColor: transaction["iconColor"],
                  //       );
                  //     }).toList(),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> loanformList = [
    {
      "name": "Abdulsemed Mussema",
      "amount": "ETB 300,000",
      "description": "Electronics",
      "date": "Sep. 23, 2023",
      "icon": Icons.refresh,
      "iconColor": Colors.blue,
    },
    {
      "name": "Muhidin Misbah",
      "amount": "ETB 100,000",
      "description": "spare parts",
      "date": "Jul. 17, 2024",
      "icon": Icons.timer,
      "iconColor": Colors.orange,
    },
    {
      "name": "Abdulsemed Mussema",
      "amount": "ETB 204,000",
      "description": "Agriculture",
      "date": "Jul. 02, 2022",
      "icon": Icons.close,
      "iconColor": Colors.red,
    },
    {
      "name": "Yared Mesele",
      "amount": "ETB 200,000",
      "description": "Agriculture",
      "date": "Sep. 23, 2023",
      "icon": Icons.check,
      "iconColor": Colors.green,
    },
    {
      "name": "Abdulsemed Mussema",
      "amount": "ETB 204,000",
      "description": "Agriculture",
      "date": "Jul. 02, 2022",
      "icon": Icons.close,
      "iconColor": Colors.red,
    },
    {
      "name": "Yared Mesele",
      "amount": "ETB 200,000",
      "description": "Agriculture",
      "date": "Sep. 23, 2023",
      "icon": Icons.check,
      "iconColor": Colors.green,
    },
  ];
}
