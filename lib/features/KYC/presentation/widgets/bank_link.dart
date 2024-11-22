import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/presentation/widgets/bank_account_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BankLink extends StatefulWidget {
  const BankLink({super.key});

  @override
  State<BankLink> createState() => _BankLinkState();
}

class _BankLinkState extends State<BankLink> {
  var loading = false;
  var loadValues = false;
  GlobalKey<FormState> myKey1 = GlobalKey();
  GlobalKey<FormState> myKey2 = GlobalKey();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  String? accountInfo;
  @override
  void initState() {
    super.initState();
  }

  Future<String?> getAccountInfo() async {
    setState(() {
      loadValues = true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Retrieve the JSON string
    PhoneNumberManager phoneManager = PhoneNumberManager();
    String? phone = await phoneManager.getPhoneNumber();
    final String? jsonString = prefs.getString('account_info_$phone');

    if (jsonString != null) {
      setState(() {
        accountInfo = jsonString;
      });
      _initializeTextFields();
      setState(() {
        loadValues = false;
      });
      return accountInfo;
    }
    // context.read<KycBloc>().add(BusinessKYCFetched());
    setState(() {
      loadValues = false;
    });
    return null; // Return null if no data is found
  }

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
    } else if (value.trim().length < 6) {
      return 'This field must be at least 6 digits long';
    }
    return null; // Return null if validation passes
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocListener<KycBloc, KycState>(
          listener: (context, state) {
            if (state is KycAccountSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is KycAccountSentSuccess) {
              setState(() {
                loading = false;
              });
              displaySnack(
                  context, "Account info. sent successfully", Colors.black);
            } else if (state is KycAccountSentFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
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
                  Form(
                    key: myKey1,
                    child: Expanded(
                      child: TextFormField(
                        controller: _accountNumberController,
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
                    child: MyButton(
                        backgroundColor: loading
                            ? AppColors.iconColor
                            : AppColors.primaryDarkColor,
                        onPressed: loading
                            ? () {}
                            : () {
                                if (myKey1.currentState!.validate()) {
                                  context.read<KycBloc>().add(AccountKYCSent(
                                      accountNumber:
                                          _accountNumberController.text));
                                }
                              },
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
                                style: TextStyle(color: Colors.white),
                              )),
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
                      child: TextFormField(
                        controller: _otpController,
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
                    child: MyButton(
                        backgroundColor: loading
                            ? AppColors.iconColor
                            : AppColors.primaryDarkColor,
                        onPressed: loading
                            ? () {}
                            : () {
                                if (myKey2.currentState!.validate() &&
                                    myKey1.currentState!.validate()) {
                                  context.read<KycBloc>().add(OTPKYCSent(
                                      otpNumber: _otpController.text));
                                }
                              },
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
              AccountCard(
                name: 'Abdulsemed Mussema',
                id: '1022200133387',
                onAccept: () {
                  // Handle accept action
                },
                onReject: () {
                  // Handle reject action
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _initializeTextFields() async {
    _accountNumberController.text = accountInfo!;
  }
}
