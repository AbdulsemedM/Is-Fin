import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class LoanApprovedScreen extends StatelessWidget {
  final String name;
  final String amount;

  const LoanApprovedScreen({
    super.key,
    required this.name,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [AppColors.bg1, AppColors.primaryColor],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Lottie animation
                    Lottie.asset(
                      'assets/animation/congrats.json',
                      height: 200,
                      repeat: true,
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Congratulations!'.tr,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your Finance request has been approved!'.tr,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(children: [
                          Text(
                            'ETB '.tr,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            amount,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ])),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    'Your Finance request has been successfully approved. You will be contacted shortly by our team for the next steps.'
                        .tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryDarkColor,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Back to Home'.tr,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
