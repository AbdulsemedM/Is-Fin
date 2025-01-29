import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/signup/bloc/signup_bloc.dart';
import 'package:ifb_loan/features/signup/presentation/screen/signup_otp.dart';
import 'package:url_launcher/url_launcher.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  bool loading = false;
  bool obscurePassword1 = true;
  bool obscurePassword2 = true;
  GlobalKey<FormState> myKey = GlobalKey();
  bool termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return
        // BlocProvider(
        //   create: (_) => SignupBloc(SignupRepository(SignupDataProvider())),
        // child:
        Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocListener<SignupBloc, SignupState>(
          listener: (context, state) {
            // print("all the states");
            // print(state);
            if (state is OtpSentLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is OtpSentSuccess) {
              setState(() {
                loading = false;
              });
              displaySnack(context, "Fill the OTP sent to your phone number",
                  Colors.black);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupOtp(
                          name: fullNameController.text,
                          phoneNumber: phoneNumberController.text,
                          password: passwordController
                              .text))); // Navigate back on success
            } else if (state is OtpSentFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: ScreenConfig.screenHeight * 0.02,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios_new_outlined)),
                  )
                ],
              ),
              // SizedBox(
              //   height: ScreenConfig.screenHeight * 0.04,
              // ),
              // Center(
              //     child: SizedBox(
              //         height: ScreenConfig.screenHeight * 0.12,
              //         child: Image.asset("assets/images/ifb2.png"))),
              SizedBox(height: ScreenConfig.screenHeight * 0.02),
              Text("Signup".tr,
                  style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Enter your details below to create your account and get started"
                        .tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
              ),
              Form(
                  key: myKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Full Name".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: fullNameController,
                          keyboardType: TextInputType.name,
                          decoration: AppDecorations.getAppInputDecoration(
                              // pIconData: Icons.phone_android,
                              hintText: 'eg: Abdu Abdi',
                              myBorder: false,
                              context: context),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Full name is required'.tr;
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Phone Number".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: AppDecorations.getAppInputDecoration(
                              // pIconData: Icons.phone_android,
                              hintText: 'eg: 0987654321',
                              myBorder: false,
                              context: context),
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
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Password".tr,
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
                          obscureText: obscurePassword1,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.greyColor,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "******",
                            prefixIconColor: AppColors.iconColor,
                            suffixIconColor: AppColors.iconColor,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: IconButton(
                                  icon: Icon(obscurePassword1
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword1 = !obscurePassword1;
                                    });
                                  },
                                )),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Password is required'.tr;
                            } else if (!isPasswordStrong(value!)) {
                              return 'Must be 6 characters and contain both letters and numbers'
                                  .tr;
                            } else if (isSequentialString(value)) {
                              return 'Password must not be sequential'.tr;
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Confirm Password".tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: cPasswordController,
                          obscureText: obscurePassword2,
                          obscuringCharacter: "*",
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColors.greyColor,
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                            hintText: "******",
                            prefixIconColor: AppColors.iconColor,
                            suffixIconColor: AppColors.iconColor,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Icon(Icons.lock),
                            ),
                            suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: IconButton(
                                  icon: Icon(obscurePassword2
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword2 = !obscurePassword2;
                                    });
                                  },
                                )),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Confirm password is required'.tr;
                            } else if (value != passwordController.text) {
                              return "Password doesn't match".tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: ScreenConfig.screenHeight * 0.02,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  termsAccepted = value ?? false;
                                });
                              },
                            ),
                            Expanded(
                              child: Wrap(
                                children: [
                                  Text(
                                    "I agree to the ".tr,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Replace with your terms URL
                                      launchUrl(Uri.parse(
                                          'https://michumizan.com/privacy-policy'));
                                    },
                                    child: Text(
                                      "Terms".tr,
                                      style: TextStyle(
                                        color: AppColors.primaryDarkColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    " and ".tr,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Replace with your conditions URL
                                      launchUrl(Uri.parse(
                                          'https://michumizan.com/privacy-policy'));
                                    },
                                    child: Text(
                                      "Conditions".tr,
                                      style: TextStyle(
                                        color: AppColors.primaryDarkColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: ScreenConfig.screenHeight * 0.04,
                        ),
                        MyButton(
                          height: ScreenConfig.screenHeight * 0.055,
                          width: ScreenConfig.screenWidth,
                          backgroundColor: loading
                              ? AppColors.iconColor
                              : AppColors.primaryDarkColor,
                          onPressed: loading
                              ? () {} // Disable button when loading or terms not accepted
                              : () {
                                  if (myKey.currentState!.validate()) {
                                    if (termsAccepted) {
                                      context.read<SignupBloc>().add(SendOtp(
                                            phoneNumber:
                                                phoneNumberController.text,
                                          ));
                                    } else {
                                      displaySnack(
                                          context,
                                          "You must accept the terms and conditions to proceed",
                                          Colors.red);
                                    }
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
                                  "Signup".tr,
                                  style: const TextStyle(color: AppColors.bg1),
                                ),
                        ),
                      ],
                    ),
                  )),
              SizedBox(
                height: ScreenConfig.screenHeight * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Do you have an account?  ".tr,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login".tr,
                      style: TextStyle(
                          fontSize: ScreenConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryDarkColor),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  bool isPasswordStrong(String password) {
    if (password.length < 6) return false;

    // Check for at least one number
    bool hasNumber = password.contains(RegExp(r'[0-9]'));

    // Check for at least one letter
    bool hasLetter = password.contains(RegExp(r'[a-zA-Z]'));

    // Check if password is not just sequential numbers or letters
    // bool isSequential = isSequentialString(password);

    return hasNumber && hasLetter;
  }

  bool isSequentialString(String str) {
    // Convert to lowercase for case-insensitive check
    str = str.toLowerCase();

    // Check for sequential numbers (e.g., "123", "345")
    String numbers = "0123456789";

    // Check for sequential letters (e.g., "abc", "def")
    String letters = "abcdefghijklmnopqrstuvwxyz";

    // Check both forward and reverse sequences
    for (int i = 0; i < str.length - 2; i++) {
      String chunk = str.substring(i, i + 3);

      // Check in numbers
      if (numbers.contains(chunk)) return true;
      if (numbers.split('').reversed.join().contains(chunk)) return true;

      // Check in letters
      if (letters.contains(chunk)) return true;
      if (letters.split('').reversed.join().contains(chunk)) return true;
    }

    return false;
  }
}
