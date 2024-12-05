import 'package:flutter/material.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_approval_murabaha_screen.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_approval_status.dart';
import 'package:intl/intl.dart';

class LoanListWidget extends StatelessWidget {
  final String id;
  final String name;
  final String amount;
  final String description;
  final String date;
  final String status;
  final IconData icon;
  final Color iconColor;
  final String? promiseToPurchaseDocument;
  final String? murabahaAgreementDocument;
  final String? agentAgreementDocument;
  final String? undertakingAgreementtDocument;

  const LoanListWidget({
    super.key,
    required this.id,
    required this.name,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.icon,
    required this.iconColor,
    required this.promiseToPurchaseDocument,
    required this.murabahaAgreementDocument,
    required this.agentAgreementDocument,
    required this.undertakingAgreementtDocument,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (status == "ACCEPTED") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanApprovalStatus(
                        id: id,
                        name: name,
                        pdfUrl: promiseToPurchaseDocument!,
                      )));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => LoanApprovedScreen(
          //               name: name,
          //               amount: amount,
          //             )));
        } else if (status == "PENDING") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Pending'),
              content: const Text(
                  'The loan application is pending approval from the merchant'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'))
              ],
            ),
          );
        } else if (status == "UNDER_REVIEW") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Under Review'),
              content: const Text(
                  'The loan application is under review by the Bank officers'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'))
              ],
            ),
          );
        } else if (status == "MURABAHA_AGREEMENT") {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoanApprovalMurabahaScreen(
                        id: id,
                        murabahaAgreementDocument: murabahaAgreementDocument!,
                      )));
        } else if (status == "UNDER_TAKING") {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Under Taking'),
              content: const Text(
                  'The loan application is approved and will be fulfilled once the product owner confirms it.'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'))
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
