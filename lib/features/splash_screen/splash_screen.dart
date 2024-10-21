import 'package:flutter/material.dart';
// import 'package:ifb_loan/app/utils/app_theme.dart';
// import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  // void initState() {
  //   super.initState();
  //   // Delaying navigation to LoginScreen for demonstration
  //   Future.delayed(Duration(seconds: 4), () {
  //     Navigator.pushReplacement(context,
  //         MaterialPageRoute(builder: (context) => const LoginScreen()));
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 150,
          ),
          Center(
              child: SizedBox(
                  height: 150, child: Image.asset("assets/images/ifb2.png"))),
          SizedBox(height: 30),
          Text(
            "IFB Loan",
            style: Theme.of(context).textTheme.displayLarge,
          )
        ],
      )),
    );
  }
}
