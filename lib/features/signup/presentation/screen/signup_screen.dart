import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/signup/bloc/signup_bloc.dart';

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
            if (state is SignupLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is SignupSuccess) {
              setState(() {
                loading = false;
              });
              displaySnack(
                  context, "Account created successfully", Colors.black);
              Navigator.pop(context); // Navigate back on success
            } else if (state is SignupFailure) {
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
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(Icons.arrow_back_ios_new_outlined),
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
              Text("Signup", style: Theme.of(context).textTheme.displayLarge),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "Enter your details below to create your account and get started",
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
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Full Name",
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
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Phone Number",
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
                              return 'Phone number is required';
                            } else if (value!.length < 10) {
                              return 'Phone number should be at least 10 digits';
                            } else if (!value.startsWith("09")) {
                              return 'Invalid phone number format';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Password",
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Password is required';
                            } else if (value!.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                "Confirm Password",
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
                            contentPadding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Confirm password is required';
                            } else if (value != passwordController.text) {
                              return "Password doesn't much";
                            }
                            return null;
                          },
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
                              ? () {} // Disable button when loading is true
                              : () {
                                  if (myKey.currentState!.validate()) {
                                    context.read<SignupBloc>().add(SignupSent(
                                          fullName: fullNameController.text,
                                          phoneNumber:
                                              phoneNumberController.text,
                                          password: passwordController.text,
                                          // email: emailController.text,
                                        ));
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
                                  "Signup",
                                  style: TextStyle(color: AppColors.bg1),
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
                    "Do you have an account?  ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Login",
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
}
