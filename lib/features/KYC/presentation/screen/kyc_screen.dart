import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/bank_link.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/business_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/personal_info.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/upload_images.dart';
// import 'package:ifb_loan/features/user_type/user_type_cubit.dart';

enum UserType { customer, provider }

class CompleteKYCDetail extends StatefulWidget {
  const CompleteKYCDetail({super.key});

  @override
  _CompleteKYCDetailState createState() => _CompleteKYCDetailState();
}

class _CompleteKYCDetailState extends State<CompleteKYCDetail> {
  int _selectedValue = 3; // Initial tab selected
  final UserManager userManager = UserManager();
  bool isProvider = false; // Add state variable for provider status

  // Define your different screens as widgets
  final Map<int, Widget> _screens = const {
    3: BankLink(),
    1: PersonalInfo(),
    2: BusinessInfo(),
    4: UploadImages(),
  };
  @override
  void initState() {
    super.initState();
    context.read<KycBloc>().add(KYCStatusFetched());
    // Fetch initial user type status
    context.read<KycBloc>().add(FetchUserType());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complete KYC'.tr,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<KycBloc, KycState>(
        listener: (context, state) {
          if (state is UserTypeFetchedSuccess) {
            setState(() {
              isProvider = state.isSupplier;
            });
          }
          if (state is UserTypeChangedSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User type updated successfully'),
                backgroundColor: Colors.green,
              ),
            );
          }
          if (state is UserTypeChangedFailure ||
              state is UserTypeFetchedFailure) {
            final error = state is UserTypeChangedFailure
                ? state.errorMessage
                : (state as UserTypeFetchedFailure).errorMessage;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<KycBloc, KycState>(
          builder: (context, state) {
            bool isLoading = state is UserTypeFetchedLoading ||
                state is UserTypeChangedLoading;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 7),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  color: isProvider
                                      ? AppColors.primaryDarkColor
                                          .withOpacity(0.15)
                                      : AppColors.primaryDarkColor
                                          .withOpacity(0.05),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(10),
                                child: isLoading
                                    ? const SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: AppColors.primaryDarkColor,
                                        ),
                                      )
                                    : Icon(
                                        isProvider
                                            ? Icons.business_center_rounded
                                            : Icons.person_rounded,
                                        color: isProvider
                                            ? AppColors.primaryDarkColor
                                            : AppColors.primaryDarkColor
                                                .withOpacity(0.7),
                                        size: 28,
                                      ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isProvider ? "Provider" : "Customer",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        color: AppColors.primaryDarkColor,
                                      ),
                                    ),
                                    AnimatedSwitcher(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: Text(
                                        isProvider
                                            ? "You are registering as a provider."
                                            : "You are registering as a customer.",
                                        key: ValueKey(isProvider),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              GestureDetector(
                                onTap: () {
                                  if (!isLoading) {
                                    context.read<KycBloc>().add(ChangeUserType(
                                        isSupplier: !isProvider));
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 54,
                                  height: 28,
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: isProvider
                                        ? AppColors.primaryDarkColor
                                        : Colors.grey[300],
                                  ),
                                  child: AnimatedAlign(
                                    duration: const Duration(milliseconds: 300),
                                    alignment: isProvider
                                        ? Alignment.centerRight
                                        : Alignment.centerLeft,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2,
                                            offset: Offset(0, 1),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        isProvider
                                            ? Icons.business_center_rounded
                                            : Icons.person_rounded,
                                        size: 16,
                                        color: isProvider
                                            ? AppColors.primaryDarkColor
                                            : AppColors.primaryDarkColor
                                                .withOpacity(0.7),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      CustomSlidingSegmentedControl<int>(
                        initialValue: _selectedValue,
                        children: {
                          3: Text(
                            'Bank'.tr,
                            style: const TextStyle(
                                color: AppColors.bgColor,
                                fontWeight: FontWeight.w500),
                          ),
                          1: Text(
                            'Pers. Info.'.tr,
                            style: const TextStyle(
                                color: AppColors.bgColor,
                                fontWeight: FontWeight.w500),
                          ),
                          2: Text(
                            'Bus. Info.'.tr,
                            style: const TextStyle(
                                color: AppColors.bgColor,
                                fontWeight: FontWeight.w500),
                          ),
                          4: Text(
                            'Upload File'.tr,
                            style: const TextStyle(
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
                    ],
                  ),
                ),
                Expanded(
                  // Display the selected screen based on _selectedValue
                  child: _screens[_selectedValue] ?? Container(),
                ),
              ],
            );
          },
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
          title: Row(
            children: [
              const Icon(
                Icons.cancel_rounded, // A red cancel icon to signify rejection
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text(
                "Rejected".tr,
                style: const TextStyle(
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
              Text(
                "You can resubmit your KYC info. and we'll review it ASAP.".tr,
                style: const TextStyle(
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
              child: Text(
                "OK".tr,
                style: const TextStyle(color: Colors.red),
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
          title: Row(
            children: [
              const Icon(
                Icons.hourglass_empty, // An hourglass icon to indicate pending
                color: Colors.orange,
              ),
              const SizedBox(width: 10),
              Text(
                "Pending".tr,
                style: const TextStyle(
                  color: Colors.orange, // Orange text for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your KYC submission is under review.".tr,
                style: const TextStyle(
                  color: Colors.orange, // Darker orange for the content text
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We will notify you once the review is complete.".tr,
                style: const TextStyle(
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
              child: Text(
                "OK".tr,
                style: const TextStyle(color: Colors.orange),
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
          title: Row(
            children: [
              const Icon(
                Icons.check_circle, // A green checkmark icon for success
                color: Colors.green,
              ),
              const SizedBox(width: 10),
              Text(
                "Success".tr,
                style: const TextStyle(
                  color: Colors.green, // Green text for the title
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Your KYC submission has been approved.".tr,
                style: const TextStyle(
                  color: Colors.green, // Darker green for the content text
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Thank you for completing your KYC process.".tr,
                style: const TextStyle(
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
              child: Text(
                "OK".tr,
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }
}

class UserTypeCubit extends Cubit<UserType> {
  UserTypeCubit() : super(UserType.customer); // Default is customer

  void setUserType(UserType type) => emit(type);
}
