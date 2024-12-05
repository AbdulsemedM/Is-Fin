import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/bank_link.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/business_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/personal_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/upload_images.dart';

class CompleteKYCDetail extends StatefulWidget {
  const CompleteKYCDetail({super.key});

  @override
  _CompleteKYCDetailState createState() => _CompleteKYCDetailState();
}

class _CompleteKYCDetailState extends State<CompleteKYCDetail> {
  int _selectedValue = 3; // Initial tab selected
  final UserManager userManager = UserManager();

  // Define your different screens as widgets
  final Map<int, Widget> _screens = const {
    3: BankLink(),
    1: PersonalInfo(),
    2: BusinessInfo(),
    4: UploadImages(),
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<KycBloc>().add(KYCStatusFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'Complete KYC',
        style: Theme.of(context).textTheme.displaySmall,
      )),
      body: BlocListener<KycBloc, KycState>(
        listener: (context, state) async {
          if (state is KycStatusFetchedLoading) {
            // print("here accessing the status");
          }
          if (state is KycStatusFetchedSuccess) {
            await userManager.setKYCStatus(state.kycStatusInfo.approvalStatus);
            if (state.kycStatusInfo.approvalStatus == "REJECTED") {
              _showRejectDialog(context, state.kycStatusInfo.rejectReason!);
            }
            if (state.kycStatusInfo.approvalStatus == "PENDING") {
              _showPendingDialog(context);
            }
            if (state.kycStatusInfo.approvalStatus == "APPROVED") {
              _showSuccessDialog(context);
            }
          }
        },
        child: Column(
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
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w500),
                    ),
                    1: Text(
                      'Pers. Info.',
                      style: TextStyle(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w500),
                    ),
                    2: Text(
                      'Bus. Info',
                      style: TextStyle(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w500),
                    ),
                    4: Text(
                      'Upload Image',
                      style: TextStyle(
                          color: AppColors.bgColor,
                          fontWeight: FontWeight.w500),
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
      ),
    );
  }

  void _showRejectDialog(BuildContext context, String reason) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[50], // Light red background for rejection
          title: const Row(
            children: [
              Icon(
                Icons.cancel_rounded, // A red cancel icon to signify rejection
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                "Rejected",
                style: TextStyle(
                  color: Colors.red, // Red text for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                reason,
                style: TextStyle(
                  color: Colors.red[800], // Darker red for the content text
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "You can resubmit your KYC info. and we'll review it ASAP.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.red, // Same color theme for supporting text
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPendingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.yellow[50], // Light yellow background for pending
          title: const Row(
            children: [
              Icon(
                Icons.hourglass_empty, // An hourglass icon to indicate pending
                color: Colors.orange,
              ),
              SizedBox(width: 10),
              Text(
                "Pending",
                style: TextStyle(
                  color: Colors.orange, // Orange text for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your KYC submission is under review.",
                style: TextStyle(
                  color: Colors.orange, // Darker orange for the content text
                ),
              ),
              SizedBox(height: 10),
              Text(
                "We will notify you once the review is complete.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange, // Same color theme for supporting text
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.orange),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              Colors.green[50], // Light green background for success
          title: const Row(
            children: [
              Icon(
                Icons.check_circle, // A green checkmark icon for success
                color: Colors.green,
              ),
              SizedBox(width: 10),
              Text(
                "Success",
                style: TextStyle(
                  color: Colors.green, // Green text for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your KYC submission has been approved.",
                style: TextStyle(
                  color: Colors.green, // Darker green for the content text
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Thank you for completing your KYC process.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green, // Same color theme for supporting text
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}
