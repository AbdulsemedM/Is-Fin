import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/business_partner/presentation/widget/url_card_widget.dart';
import 'package:ifb_loan/features/provider_KYC/presentation/screen/provider_KYC_screen.dart';

class AddBisinessPartnerScreen extends StatefulWidget {
  const AddBisinessPartnerScreen({super.key});

  @override
  State<AddBisinessPartnerScreen> createState() =>
      _AddBisinessPartnerScreenState();
}

class _AddBisinessPartnerScreenState extends State<AddBisinessPartnerScreen> {
  var loading = false;
  var loading2 = false;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _partnerNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey();
  final TextEditingController _partnerPhoneNumberController =
      TextEditingController();
  GlobalKey<FormState> myKey1 = GlobalKey();
  GlobalKey<FormState> myKey2 = GlobalKey();
  String? validateField(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'This field is required'.tr;
    }
    return null; // Return null if validation passes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Business Partner".tr,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<ProvidersBloc, ProvidersState>(
        listener: (context, state) {
          if (state is ProviderSendLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is ProviderSendSuccess) {
            setState(() {
              loading = false;
              _partnerNameController.text = state.provider['fullName']!;
              _partnerPhoneNumberController.text =
                  state.provider['phoneNumber']!;
            });
          } else if (state is ProviderSendFailure) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          } else if (state is ProviderVerifyLoading) {
            setState(() {
              loading2 = true;
            });
          } else if (state is ProviderVerifySuccess) {
            setState(() {
              loading2 = false;
            });
            context.read<ProvidersBloc>().add(ProviderFetch());
            displaySnack(context, state.message, Colors.black);
            Navigator.pop(context, true);
          } else if (state is ProviderVerifyFailure) {
            setState(() {
              loading2 = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: myKey1,
                  child: TextFormField(
                    controller: _phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Business Partner\'s Phone Number'.tr,
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
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
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            if (myKey1.currentState!.validate()) {
                              context.read<ProvidersBloc>().add(ProviderSend(
                                  phoneNumber: _phoneNumberController.text));
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
                        : Text(
                            "Verify Partner".tr,
                            style: TextStyle(color: Colors.white),
                          )),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
                  child: Divider(),
                ),
                Form(
                  key: myKey2,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _partnerNameController,
                        decoration: InputDecoration(
                          labelText: 'Partners Name'.tr,
                          filled: true,
                          enabled: false,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) => validateField(value),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _partnerPhoneNumberController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: 'Partne\'s Phone Number'.tr,
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) {
                          if (value?.isEmpty == true) {
                            return 'Phone number is required'.tr;
                          } else if (value!.length < 10) {
                            return 'Phone number should be at least 10 digits'
                                .tr;
                          } else if (!value.startsWith("09")) {
                            return 'Invalid phone number format'.tr;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    backgroundColor: loading2
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading2
                        ? () {}
                        : () {
                            context.read<ProvidersBloc>().add(ProviderVerify(
                                phoneNumber: _partnerPhoneNumberController.text,
                                name: _partnerNameController.text));
                          },
                    buttonText: loading2
                        ? SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                            width: ScreenConfig.screenHeight * 0.02,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : Text(
                            "Submit".tr,
                            style: const TextStyle(color: Colors.white),
                          )),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                      "If your business partner is not registered you can invite them to join the platform by the following link or you can fill all the KYC on behalf of them by clicking the bottom button and let them join the platform and just accept the loan term and conditions"
                          .tr),
                ),
                UrlCard(
                  url:
                      'https://play.google.com/store/apps/details?id=com.example.app',
                  onShare: () {
                    // Define share functionality here
                  },
                ),
                const SizedBox(height: 24),
                MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Phone Number'.tr),
                                content: SingleChildScrollView(
                                  child: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                        maxHeight: 300), // Adjust as needed
                                    child: Column(
                                      mainAxisSize: MainAxisSize
                                          .min, // Ensures the column wraps its content
                                      children: [
                                        Text(
                                          'Add the phone number of the person to be registered'
                                              .tr,
                                        ),
                                        Form(
                                          key: myKey,
                                          child: TextFormField(
                                            controller: phoneNumberController,
                                            keyboardType: TextInputType.number,
                                            decoration: AppDecorations
                                                .getAppInputDecoration(
                                              myBorder: false,
                                              pIconData: Icons.phone_android,
                                              hintText: 'eg: 0987654321',
                                              context: context,
                                            ),
                                            validator: (value) {
                                              if (value?.isEmpty == true) {
                                                return 'Phone number is required'
                                                    .tr;
                                              } else if (value!.length != 10) {
                                                return 'Invalid phone number format'
                                                    .tr;
                                              } else if (!value
                                                  .startsWith("09")) {
                                                return 'Invalid phone number format'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Close'.tr),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (myKey.currentState!.validate()) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProviderKycScreen(
                                                        phoneNumber:
                                                            phoneNumberController
                                                                .text)));
                                      }
                                    },
                                    child: Text('Add'.tr),
                                  ),
                                ],
                              ),
                            );
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
                        : Text(
                            "Register your Partner".tr,
                            style: const TextStyle(color: Colors.white),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
