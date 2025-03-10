import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_loan_form_screen.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_undertaking_screen.dart';
import 'package:intl/intl.dart';

class ProviderLoanListWidget extends StatelessWidget {
  final String name;
  final String amount;
  final String description;
  final String date;
  final IconData icon;
  final Color iconColor;
  final String id;
  final String status;
  final String? undertakingAgreementtDocument;
  final String? agentAgreementDocument;
  final String? rejectionReason;

  const ProviderLoanListWidget({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
    required this.description,
    required this.date,
    required this.icon,
    required this.iconColor,
    required this.status,
    required this.undertakingAgreementtDocument,
    required this.agentAgreementDocument,
    required this.rejectionReason,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "PENDING") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProviderLoanFormScreen(
                        id: id,
                        name: name,
                      )));
        } else if (status == "LOAN_ACCEPTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Finance Accepted'.tr),
              content: Text('The Finance application is now approved'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "ACCEPTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Pending'.tr),
              content: Text(
                  'The finance application is pending approval from the customer'
                      .tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "UNDER_REVIEW") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Under Review'.tr),
              content: Text(
                  'The finance application is under review by the Bank officers'
                      .tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "REJECTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Rejected'.tr),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height *
                      0.7, // Max 70% of screen height
                  maxWidth: MediaQuery.of(context).size.width *
                      0.8, // Max 80% of screen width
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Makes column wrap its content
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('The finance application is rejected'.tr),
                      const SizedBox(height: 8),
                      Text(rejectionReason ?? ""),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "UNDER_TAKING") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProviderUndertakingScreen(
                        id: id,
                        undertakingAgreementtDocument:
                            undertakingAgreementtDocument!,
                        // agentAgreementDocument: agentAgreementDocument!
                      )));
        } else if (status == "AGREEMENT_ACCEPTED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Agreements Accepted'.tr),
              content: Text('The finance application is now approved.'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        } else if (status == "CLOSED") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Closed'.tr),
              content: Text('The finance application is closed.'.tr),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'.tr))
              ],
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: iconColor.withOpacity(0.2),
              radius: 24,
              child: Icon(
                icon,
                color: iconColor,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('MMM. dd yyyy').format(DateTime.parse(date)),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount != ""
                      ? "ETB ${NumberFormat('#,###').format(double.parse(amount))}"
                      : "",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
