import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/provider_KYC/bloc/provider_kyc_bloc.dart';

class ProviderAccountWidget extends StatefulWidget {
  final String phoneNumber;
  const ProviderAccountWidget({super.key, required this.phoneNumber});

  @override
  State<ProviderAccountWidget> createState() => _ProviderAccountWidgetState();
}

class _ProviderAccountWidgetState extends State<ProviderAccountWidget> {
  String accountHolder = "";
  String accountNumber = "";
  var accountLoading = false;
  var accountSent = false;
  var otpLoading = false;
  var loadValues = false;
  GlobalKey<FormState> myKey1 = GlobalKey();
  GlobalKey<FormState> myKey2 = GlobalKey();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? validateAccountField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (value.trim().length != 13) {
      return 'This field must be at least 13 digits long';
    }
    return null; // Return null if validation passes
  }

  String? validateOTPField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required';
    } else if (value.trim().length != 6) {
      return 'This field must be at least 6 digits long';
    }
    return null; // Return null if validation passes
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<ProviderKycBloc, ProviderKycState>(
          listener: (context, state) {
            if (state is ProviderAccountKYCSentLoading) {
              setState(() {
                accountLoading = true;
                accountSent = true;
              });
            } else if (state is ProviderAccountKYCSentSuccess) {
              setState(() {
                accountLoading = false;
              });
              displaySnack(
                  context, "Account info. sent successfully", Colors.black);
            } else if (state is ProviderAccountKYCSentError) {
              setState(() {
                accountLoading = false;
                accountSent = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            }
            ///////////////////////////////////////////////////////////////
            else if (state is ProviderOTPKYCSentLoading) {
              setState(() {
                // loadValues = false;
                // accountLoading = false;
                // displaySnack(context, state.errorMessage, Colors.red);
              });
            } else if (state is ProviderOTPKYCSentSuccess) {
              setState(() {
                displaySnack(
                    context, "Account Verified Successfully", Colors.black);
              });
            } else if (state is ProviderOTPKYCSentError) {
              setState(() {
                // loadValues = false;
                // accountLoading = false;
                displaySnack(context, state.errorMessage, Colors.red);
              });
            }
          },
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Complete all the fields below"),
              ),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: Colors.grey, // Set the color of the divider
                    thickness: 1,
                  )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Bank Info."),
                  ),
                  Expanded(
                      child: Divider(
                    color: Colors.grey, // Set the color of the divider
                    thickness: 1,
                  )),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Form(
                      key: myKey1,
                      child: TextFormField(
                        enabled: !accountSent,
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) => validateAccountField(value),
                        decoration: InputDecoration(
                          labelText: 'Account Number',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1, // Make the button take less space
                    child: MyButton(
                      backgroundColor: accountLoading || accountSent
                          ? AppColors.iconColor
                          : AppColors.primaryDarkColor,
                      onPressed: accountLoading || accountSent
                          ? () {}
                          : () {
                              if (myKey1.currentState!.validate()) {
                                context
                                    .read<ProviderKycBloc>()
                                    .add(ProviderAccountKYCSent(
                                      accountNumber:
                                          _accountNumberController.text,
                                      phoneNumber: widget.phoneNumber,
                                    ));
                              }
                            },
                      buttonText: accountLoading
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
                              style: TextStyle(
                                  color: Colors.white,
                                  // fontSize: 10,
                                  fontWeight: FontWeight.w600),
                            ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Divider(),
              ),
              Row(
                children: [
                  Form(
                    key: myKey2,
                    child: Expanded(
                      flex: 2,
                      child: TextFormField(
                        enabled: accountSent,
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        validator: (value) => validateOTPField(value),
                        decoration: InputDecoration(
                          labelText: 'OTP',
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: MyButton(
                        backgroundColor: otpLoading || !accountSent
                            ? AppColors.iconColor
                            : AppColors.primaryDarkColor,
                        onPressed: otpLoading || !accountSent
                            ? () {}
                            : () {
                                if (myKey2.currentState!.validate() &&
                                    myKey1.currentState!.validate()) {
                                  context.read<ProviderKycBloc>().add(
                                      ProviderOTPKYCSent(
                                          otp: _otpController.text,
                                          phoneNumber: widget.phoneNumber));
                                }
                              },
                        buttonText: otpLoading
                            ? SizedBox(
                                height: ScreenConfig.screenHeight * 0.02,
                                width: ScreenConfig.screenHeight * 0.02,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: AppColors.primaryColor,
                                ),
                              )
                            : !accountSent
                                ? const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    "Add",
                                    style: TextStyle(color: Colors.white),
                                  )),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                child: Divider(),
              ),
              // if (!loadValues || !accountLoading || accountNumber != "")
              // AccountCard(
              //   name: accountHolder,
              //   id: accountNumber,
              //   onAccept: () {
              //     // Handle accept action
              //   },
              //   onReject: () {
              //     // Handle reject action
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
