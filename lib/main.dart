import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/data/data_provider/KYC_data_provider.dart';
import 'package:ifb_loan/features/KYC/data/repository/KYC_repository.dart';
import 'package:ifb_loan/features/login/bloc/login_bloc.dart';
import 'package:ifb_loan/features/login/data/data_provider/login_data_provider.dart';
import 'package:ifb_loan/features/login/data/repository/login_repository.dart';
import 'package:ifb_loan/features/signup/bloc/signup_bloc.dart';
import 'package:ifb_loan/features/signup/data/data_provider/signup_data_provider.dart';
import 'package:ifb_loan/features/signup/data/repository/signup_repository.dart';
import 'package:ifb_loan/features/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final bool isFirstTime = await _checkFirstTime();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryDarkColor,
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (context) =>
              SignupBloc(SignupRepository(SignupDataProvider()))),
      BlocProvider(
          create: (contex) => LoginBloc(LoginRepository(LoginDataProvider()))),
      BlocProvider(
          create: (contex) => KycBloc(KycRepository(KycDataProvider())))
    ],
    child: MyApp(isFirstTime: isFirstTime),
  ));
}

Future<bool> _checkFirstTime() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false); // Set flag for future sessions
  }

  return isFirstTime;
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      theme: AppTheme.themeData(),
      home: SplashScreenPage(),
    );
  }
}
