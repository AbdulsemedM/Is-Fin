import 'package:flutter/material.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class OtpSection extends StatelessWidget {
  final TextEditingController otpController;
  final bool loading;
  final VoidCallback onSubmit;

  const OtpSection({
    super.key,
    required this.otpController,
    required this.loading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Enter OTP",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        TextFormField(
          // controller: myProductUnitPrice,
          keyboardType: TextInputType.number,
          decoration: AppDecorations.getAppInputDecoration(
            myBorder: false,
            pIconData: Icons.lock_open,
            hintText: '******',
            context: context,
          ),
          validator: (value) {
            if (value?.isEmpty == true) {
              return 'OTP is required';
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
          onPressed: loading ? () {} : onSubmit,
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
                  "Submit",
                  style: TextStyle(color: AppColors.bg1),
                ),
        ),
      ],
    );
  }
}
