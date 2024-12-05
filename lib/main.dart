import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/data/data_provider/KYC_data_provider.dart';
import 'package:ifb_loan/features/KYC/data/repository/KYC_repository.dart';
import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/business_partner/data/data_provider/provider_data_provider.dart';
import 'package:ifb_loan/features/business_partner/data/repository/provider_repository.dart';
import 'package:ifb_loan/features/finances/bloc/finances_bloc.dart';
import 'package:ifb_loan/features/finances/data/data_provider/finance_data_provider.dart';
import 'package:ifb_loan/features/finances/data/repository/finances_repository.dart';
import 'package:ifb_loan/features/landing_page/presentation/screen/landing_page_screen.dart';
import 'package:ifb_loan/features/loan_application/bloc/loan_app_bloc.dart';
import 'package:ifb_loan/features/loan_application/data/data_provider/loan_app_provider.dart';
import 'package:ifb_loan/features/loan_application/data/repository/loan_app_repository.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/data/data_provider/loan_approval_status_data_provider.dart';
import 'package:ifb_loan/features/loan_approval_status/data/repository/loan_approval_status_repository.dart';
import 'package:ifb_loan/features/login/bloc/login_bloc.dart';
import 'package:ifb_loan/features/login/data/data_provider/login_data_provider.dart';
import 'package:ifb_loan/features/login/data/repository/login_repository.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:ifb_loan/features/provider_loan_form/data/data_provider/provider_loan_form_data_provider.dart';
import 'package:ifb_loan/features/provider_loan_form/data/repository/provider_loan_form_repository.dart';
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
          create: (contex) =>
              LoginBloc(LoginRepository(LoginDataProvider(), UserManager()))),
      BlocProvider(
          create: (contex) => KycBloc(KycRepository(KycDataProvider()))),
      BlocProvider(
          create: (contex) =>
              ProvidersBloc(ProviderRepository(ProviderDataProvider()))),
      BlocProvider(
          create: (contex) =>
              LoanAppBloc(LoanAppRepository(LoanAppProvider()))),
      BlocProvider(
          create: (contex) => ProviderLoanFormBloc(
              ProviderLoanFormRepository(ProviderLoanFormDataProvider()))),
      BlocProvider(
          create: (contex) => LoanApprovalStatusBloc(
              LoanApprovalStatusRepository(LoanApprovalStatusDataProvider()))),
      BlocProvider(
          create: (contex) =>
              FinancesBloc(FinancesRepository(FinanceDataProvider()))),
    ],
    child: MyApp(isFirstTime: isFirstTime),
  ));
}

class ProviderLoanFormProvider {}

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
      home: isFirstTime ? const LandingPage() : const SplashScreenPage(),
    );
  }
}
