import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
// import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';
import 'package:ifb_loan/features/otp/bloc/otp_bloc.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String password;

  const OtpScreen(
      {super.key, required this.phoneNumber, required this.password});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool loading = false;
  bool activateResend = false;
  @override
  void initState() {
    super.initState();
    context
        .read<OtpBloc>()
        .add(SendPhoneNumber(phoneNumber: widget.phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
    );

    return Scaffold(
      body: BlocListener<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is PhoneNumberSentFailure) {
            setState(() {
              activateResend = true;
            });
          } else if (state is OTPSentLoading) {
            setState(() {
              loading = true;
            });
          } else if (state is OTPSentSuccess) {
            setState(() {
              loading = false;
            });
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false, // This removes all previous routes
            );
          } else if (state is OTPSentFailure) {
            setState(() {
              loading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryDarkColor,
                AppColors.iconColor,
              ],
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We have sent an OTP to ${widget.phoneNumber}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Pinput(
                    enabled: !loading,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    showCursor: true,
                    cursor: Container(
                      height: 30,
                      width: 2,
                      color: Colors.white,
                    ),
                    onCompleted: (pin) {
                      context.read<OtpBloc>().add(SendOTP(
                          password: widget.password,
                          otp: pin,
                          phoneNumber: widget.phoneNumber));
                    },
                  ),
                  const SizedBox(height: 32),
                  MyButton(
                      // height: ScreenConfig.screenHeight * 0.06,
                      width: ScreenConfig.screenWidth * 0.5,
                      backgroundColor:
                          activateResend ? AppColors.iconColor : AppColors.bg1,
                      onPressed: activateResend
                          ? () {}
                          : () {
                              //  Delaying navigation to LoginScreen for demonstration
                              setState(() {
                                activateResend = true;
                              });
                              Future.delayed(const Duration(seconds: 4), () {
                                // Navigator.pushReplacement(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const LoginScreen()));
                              });
                            },
                      buttonText: activateResend
                          ? SizedBox(
                              height: ScreenConfig.screenHeight * 0.02,
                              width: ScreenConfig.screenHeight * 0.02,
                              child: const CircularProgressIndicator(
                                strokeWidth: 3,
                                color: AppColors.primaryColor,
                              ),
                            )
                          : const Text(
                              "Resend",
                              style: TextStyle(
                                  color: AppColors.primaryDarkColor,
                                  fontWeight: FontWeight.w700),
                            )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
