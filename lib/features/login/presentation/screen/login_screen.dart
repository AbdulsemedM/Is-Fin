import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/dashborad/dashboard_page.dart';
import 'package:ifb_loan/features/forgot_password/presentation/screen/forgot_password.dart';
import 'package:ifb_loan/features/login/bloc/login_bloc.dart';
import 'package:ifb_loan/features/signup/presentation/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey();
  bool obscurePassword = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          // print("all the states");
          // print(state);
          if (state is LoginLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is LoginSuccess) {
            setState(() {
              loading = false;
            });
            displaySnack(context, "Logged in successfully", Colors.black);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const DashboardPage())); // Navigate back on success
          } else if (state is LoginFailure) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Language",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
              SizedBox(
                height: ScreenConfig.screenHeight * 0.05,
              ),
              Center(
                  child: SizedBox(
                      height: ScreenConfig.screenHeight * 0.15,
                      child: Image.asset("assets/images/ifb2.png"))),
              SizedBox(height: ScreenConfig.screenHeight * 0.05),
              Text(
                "IFB Business Loan",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: AppColors.secondaryDarkColor),
              ),
              const SizedBox(
                height: 10,
              ),
              Text("Signin to your account",
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              Form(
                  key: myKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
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
                            myBorder: false,
                            pIconData: Icons.phone_android,
                            hintText: 'eg: 0987654321',
                            context: context,
                          ),
                          validator: (value) {
                            if (value?.isEmpty == true) {
                              return 'Phone number is required';
                            } else if (value!.length != 10) {
                              return 'Invalid phone number format';
                            } else if (!value.startsWith("09")) {
                              return 'Invalid phone number format';
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
                          obscureText: obscurePassword,
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
                                  icon: Icon(obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword = !obscurePassword;
                                    });
                                  },
                                )),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 16),
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPassword()),
                                  );
                                },
                                child: Text(
                                  "Forgot Password?",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontSize: 16,
                                          decoration: TextDecoration.underline,
                                          color: AppColors.primaryColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(
                        //   height: ScreenConfig.screenHeight * 0.04,
                        // ),
                        MyButton(
                          height: ScreenConfig.screenHeight * 0.055,
                          width: ScreenConfig.screenWidth,
                          backgroundColor: loading
                              ? AppColors.iconColor
                              : AppColors.primaryDarkColor,
                          onPressed: loading
                              ? () {}
                              : () async {
                                  if (myKey.currentState!.validate()) {
                                    context.read<LoginBloc>().add(LoginFetched(
                                          phoneNumber:
                                              phoneNumberController.text,
                                          password: passwordController.text,
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
                                  "Login",
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
                    "Don't have an account?  ",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignupScreen()));
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          color: AppColors.primaryDarkColor,
                          fontSize: ScreenConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
