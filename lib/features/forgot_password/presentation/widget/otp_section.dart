import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';

class OtpSection extends StatelessWidget {
  final TextEditingController otpController;
  final bool loading;
  final VoidCallback onSubmit;
  final GlobalKey<FormState> myKey1;

  const OtpSection({
    super.key,
    required this.myKey1,
    required this.otpController,
    required this.loading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: myKey1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Enter OTP".tr,
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
                return 'OTP is required'.tr;
              } else if (value!.length != 6) {
                return 'Invalid OTP format'.tr;
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
      ),
    );
  }
}
