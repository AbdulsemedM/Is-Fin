import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/business_partners_screen.dart';
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
  var loading = false;
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
            const Positioned(
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
        const Text(
          "Hi, Abdulsemed M.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: KycProgressCard(
            title: 'KYC Completed',
            percent: 0.74, // 74%
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomListButton(
                icon: Icons.info,
                title: 'Complete KYC',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CompleteKYCDetail()));
                },
              ),
              CustomListButton(
                icon: Icons.add,
                title: 'Add Business Partner',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessPartnersScreen()));
                },
              ),
              SizedBox(height: 10),
              const LoanStatusCard(
                completedLoans: 13,
                pendingLoans: 2,
                failedLoans: 0,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                    textAlign: TextAlign.center,
                    "If you are here as a product seller and wanted to fill a form or check status please click the button bellow"),
              ),
              MyButton(
                  backgroundColor: loading
                      ? AppColors.iconColor
                      : AppColors.primaryDarkColor,
                  onPressed: loading
                      ? () {}
                      : () {
                          setState(() {
                            loading = true;
                          });
                        },
                  buttonText: loading
                      ? SizedBox(
                          height: ScreenConfig.screenHeight * 0.02,
                          width: ScreenConfig.screenHeight * 0.02,
                          child: const CircularProgressIndicator(
                            strokeWidth: 3,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const Text(
                          "Click Here",
                          style: TextStyle(color: Colors.white),
                        )),
            ],
          ),
        )
      ],
    );
  }
}
