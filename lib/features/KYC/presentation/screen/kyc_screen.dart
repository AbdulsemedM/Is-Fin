import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/bank_link.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/business_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/personal_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/upload_images.dart';

class CompleteKYCDetail extends StatefulWidget {
  @override
  _CompleteKYCDetailState createState() => _CompleteKYCDetailState();
}

class _CompleteKYCDetailState extends State<CompleteKYCDetail> {
  int _selectedValue = 1; // Initial tab selected

  // Define your different screens as widgets
  final Map<int, Widget> _screens = {
    1: PersonalInfo(),
    2: BusinessInfo(),
    3: BankLink(),
    4: UploadImages(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Complete KYC',
        style: Theme.of(context).textTheme.displaySmall,
      )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomSlidingSegmentedControl<int>(
                initialValue: _selectedValue,
                children: const {
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
                  3: Text(
                    'Bank Link',
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
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                duration: Duration(milliseconds: 300),
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
