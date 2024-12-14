import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/provider_KYC/presentation/widget/provider_account_widget.dart';
import 'package:ifb_loan/features/provider_KYC/presentation/widget/provider_business_info_widget.dart';
import 'package:ifb_loan/features/provider_KYC/presentation/widget/provider_file_upload_widget.dart';
import 'package:ifb_loan/features/provider_KYC/presentation/widget/provider_personal_info_widget.dart';

class ProviderKycScreen extends StatefulWidget {
  const ProviderKycScreen({super.key});

  @override
  State<ProviderKycScreen> createState() => _ProviderKycScreenState();
}

class _ProviderKycScreenState extends State<ProviderKycScreen> {
  int _selectedValue = 3; // Initial tab selected

  // Define your different screens as widgets
  final Map<int, Widget> _screens = const {
    3: ProviderAccountWidget(),
    1: ProviderPersonalInfoWidget(),
    2: ProviderBusinessInfoWidget(),
    4: ProviderFileUploadWidget(),
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Provider KYC",
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomSlidingSegmentedControl<int>(
                initialValue: _selectedValue,
                children: const {
                  3: Text(
                    'Bank Link',
                    style: TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w500),
                  ),
                  1: Text(
                    'Pers. Info.',
                    style: TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w500),
                  ),
                  2: Text(
                    'Bus. Info',
                    style: TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w500),
                  ),
                  4: Text(
                    'Upload Image',
                    style: TextStyle(
                        color: AppColors.bgColor, fontWeight: FontWeight.w500),
                  ),
                },
                decoration: BoxDecoration(
                  color: AppColors.iconColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                thumbDecoration: BoxDecoration(
                  color: AppColors.primaryDarkColor,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.3),
                      blurRadius: 4.0,
                      spreadRadius: 1.0,
                      offset: const Offset(0.0, 2.0),
                    ),
                  ],
                ),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInToLinear,
                onValueChanged: (value) {
                  setState(() {
                    _selectedValue = value; // Update the selected value
                  });
                },
              ),
            ),
          ),
          Expanded(
            // Display the selected screen based on _selectedValue
            child: _screens[_selectedValue] ?? Container(),
          ),
        ],
      ),
    );
  }
}
