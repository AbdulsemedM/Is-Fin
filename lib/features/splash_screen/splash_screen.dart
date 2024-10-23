import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
// import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    // Delaying navigation to LoginScreen for demonstration
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig.init(context);
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: ScreenConfig.screenHeight * 0.1,
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
          SizedBox(
            height: ScreenConfig.screenHeight * 0.16,
          ),
          CircularProgressIndicator(
            color: AppColors.primaryDarkColor,
          ),
          Text(
            "Loading",
            style: Theme.of(context).textTheme.bodyLarge,
          )
        ],
      )),
    );
  }
}
