import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
// import 'package:ifb_loan/app/utils/app_theme.dart';

class LoanStatusCard extends StatelessWidget {
  final int completedLoans;
  final int pendingLoans;
  final int failedLoans;

  const LoanStatusCard({
    super.key,
    required this.completedLoans,
    required this.pendingLoans,
    required this.failedLoans,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildLoanStatusItem(
                completedLoans, 'Completed Loans', Colors.orange),
          ),
          _buildDivider(),
          Expanded(
            child: _buildLoanStatusItem(
                pendingLoans, 'Pending Loans', Colors.orange),
          ),
          _buildDivider(),
          Expanded(
            child: _buildLoanStatusItem(
                failedLoans, 'Failed Loans', Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildLoanStatusItem(int count, String label, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Flexible(
          child: Text(
            label.tr,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
            maxLines: 2,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 60,
      width: 1,
      color: AppColors.primaryDarkColor,
    );
  }
}
