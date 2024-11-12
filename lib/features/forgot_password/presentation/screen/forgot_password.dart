import 'package:flutter/material.dart';
import 'package:ifb_loan/features/forgot_password/presentation/widget/email_password_section.dart';
import 'package:ifb_loan/features/forgot_password/presentation/widget/otp_section.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool loading = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Email and Password Inputs with Send OTP Button
            EmailPasswordSection(
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
              loading: loading,
              onSendOtp: () async {
                setState(() {
                  loading = true;
                });
                await Future.delayed(const Duration(seconds: 4));
                setState(() {
                  loading = false;
                });
              },
            ),

            SizedBox(height: 24),

            // Divider
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),

            SizedBox(height: 24),

            // OTP Input and Submit Button
            OtpSection(
              otpController: _otpController,
              loading: loading,
              onSubmit: () async {
                setState(() {
                  loading = true;
                });
                await Future.delayed(const Duration(seconds: 4));
                setState(() {
                  loading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
