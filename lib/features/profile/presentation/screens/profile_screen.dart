import 'package:flutter/material.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/custome_list_button.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/kyc_card_widget.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/loan_status_card.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/upper_circular_design.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Background curves
            CustomPaint(
              size: Size(double.infinity, 200), // Adjust height as needed
              painter: CurvedPainter(),
            ),
            // Add content inside the stack if needed, e.g., profile picture, settings icon
            Positioned(
              top: 70,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                        'assets/images/profile.png'), // Replace with actual image
                  ),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        Text(
          "Hi, Abdulsemed M.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: KycProgressCard(
            title: 'KYC Completed',
            percent: 0.74, // 74%
          ),
        ),
        Column(
          children: [
            CustomListButton(
              icon: Icons.info,
              title: 'Complete KYC',
              onPressed: () {
                // Callback for Complete KYC button
              },
            ),
            CustomListButton(
              icon: Icons.add,
              title: 'Add Business Partner',
              onPressed: () {
                // Callback for Add Business Partner button
              },
            ),
            LoanStatusCard(
              completedLoans: 13,
              pendingLoans: 2,
              failedLoans: 0,
            ),
          ],
        )
      ],
    );
  }
}
