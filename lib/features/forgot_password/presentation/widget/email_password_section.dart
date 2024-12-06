import 'package:flutter/material.dart';
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
                  "Phone Number",
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
                return 'Phone number is required';
              } else if (value!.length != 10) {
                return 'Invalid phone number format';
              } else if (!value.startsWith("09")) {
                return 'Invalid phone number format';
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
                  "New Password",
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
                return 'password is required';
              } else if (value!.length < 6) {
                return 'Password must be at least 6 characters long';
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
                  "Confirm Password",
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
                return 'password is required';
              }
              //  else if (value!.length < 6) {
              //   return 'Password must be at least 6 characters long';
              // }
              else if (value != passwordController.text) {
                return 'Password does not match';
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
                : const Text(
                    "Send OTP",
                    style: TextStyle(color: AppColors.bg1),
                  ),
          ),
        ],
      ),
    );
  }
}
