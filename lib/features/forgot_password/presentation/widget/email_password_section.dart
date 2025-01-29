import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class EmailPasswordSection extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool loading;
  final VoidCallback onSendOtp;
  final GlobalKey<FormState> myKey;

  const EmailPasswordSection({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.loading,
    required this.onSendOtp,
    required this.myKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: myKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Phone Number".tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.number,
            decoration: AppDecorations.getAppInputDecoration(
              myBorder: false,
              pIconData: Icons.phone_android,
              hintText: 'Ex. 0987654321',
              context: context,
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Phone number is required'.tr;
              } else if (value!.length != 10) {
                return 'Invalid phone number format'.tr;
              } else if (!value.startsWith("09")) {
                return 'Invalid phone number format'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "New Password".tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: passwordController,
            keyboardType: TextInputType.text,
            decoration: AppDecorations.getAppInputDecoration(
              myBorder: false,
              pIconData: Icons.lock,
              hintText: '******',
              context: context,
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Password is required'.tr;
              } else if (value!.length < 6) {
                return 'Password must be at least 6 characters long'.tr;
              } else if (!isPasswordStrong(value)) {
                return 'Password must be at least 6 characters long'.tr;
              } else if (!isSequentialString(value)) {
                return 'Password must not be sequential'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Confirm Password".tr,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontSize: 16),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: confirmPasswordController,
            keyboardType: TextInputType.text,
            decoration: AppDecorations.getAppInputDecoration(
              myBorder: false,
              pIconData: Icons.lock,
              hintText: '******',
              context: context,
            ),
            validator: (value) {
              if (value?.isEmpty == true) {
                return 'Confirm password is required'.tr;
              }
              //  else if (value!.length < 6) {
              //   return 'Password must be at least 6 characters long';
              // }
              else if (value != passwordController.text) {
                return 'Password does not match'.tr;
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          MyButton(
            height: ScreenConfig.screenHeight * 0.055,
            width: ScreenConfig.screenWidth,
            backgroundColor:
                loading ? AppColors.iconColor : AppColors.primaryDarkColor,
            onPressed: loading ? () {} : onSendOtp,
            buttonText: loading
                ? SizedBox(
                    height: ScreenConfig.screenHeight * 0.02,
                    width: ScreenConfig.screenHeight * 0.02,
                    child: const CircularProgressIndicator(
                      strokeWidth: 3,
                      color: AppColors.primaryColor,
                    ),
                  )
                : Text(
                    "Send OTP".tr,
                    style: TextStyle(color: AppColors.bg1),
                  ),
          ),
        ],
      ),
    );
  }

  bool isPasswordStrong(String password) {
    if (password.length < 6) return false;

    // Check for at least one number
    bool hasNumber = password.contains(RegExp(r'[0-9]'));

    // Check for at least one letter
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));

    // Check if password is not just sequential numbers or letters
    bool isSequential = isSequentialString(password);

    return hasNumber && hasLetter && !isSequential;
  }

  bool isSequentialString(String str) {
    // Convert to lowercase for case-insensitive check
    str = str.toLowerCase();

    // Check for sequential numbers (e.g., "123", "345")
    String numbers = "0123456789";

    // Check for sequential letters (e.g., "abc", "def")
    String letters = "abcdefghijklmnopqrstuvwxyz";

    // Check both forward and reverse sequences
    for (int i = 0; i < str.length - 2; i++) {
      String chunk = str.substring(i, i + 3);

      // Check in numbers
      if (numbers.contains(chunk)) return true;
      if (numbers.split('').reversed.join().contains(chunk)) return true;

      // Check in letters
      if (letters.contains(chunk)) return true;
      if (letters.split('').reversed.join().contains(chunk)) return true;
    }

    return false;
  }
}
