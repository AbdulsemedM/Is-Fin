import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/localization_string.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/core/presentation/widgets/base_screen.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/data/data_provider/KYC_data_provider.dart';
import 'package:ifb_loan/features/KYC/data/repository/KYC_repository.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/bloc/providers_bloc.dart';
import 'package:ifb_loan/features/business_partner/data/data_provider/provider_data_provider.dart';
import 'package:ifb_loan/features/business_partner/data/repository/provider_repository.dart';
import 'package:ifb_loan/features/dashborad/bloc/dashboard_bloc.dart';
import 'package:ifb_loan/features/finances/bloc/finances_bloc.dart';
import 'package:ifb_loan/features/finances/data/data_provider/finance_data_provider.dart';
import 'package:ifb_loan/features/finances/data/repository/finances_repository.dart';
import 'package:ifb_loan/features/home/bloc/home_bloc.dart';
import 'package:ifb_loan/features/home/data/data_provider/home_data_provider.dart';
import 'package:ifb_loan/features/home/data/repository/home_repository.dart';
import 'package:ifb_loan/features/landing_page/presentation/screen/landing_page_screen.dart';
import 'package:ifb_loan/features/loan_application/bloc/loan_app_bloc.dart';
import 'package:ifb_loan/features/loan_application/data/data_provider/loan_app_provider.dart';
import 'package:ifb_loan/features/loan_application/data/repository/loan_app_repository.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/data/data_provider/loan_approval_status_data_provider.dart';
import 'package:ifb_loan/features/loan_approval_status/data/repository/loan_approval_status_repository.dart';
import 'package:ifb_loan/features/loan_repayment/bloc/loan_repayment_bloc.dart';
import 'package:ifb_loan/features/loan_repayment/data/data_provider/loan_provider_data_provider.dart';
import 'package:ifb_loan/features/loan_repayment/data/repository/loan_repayment_repository.dart';
import 'package:ifb_loan/features/login/bloc/login_bloc.dart';
import 'package:ifb_loan/features/login/data/data_provider/login_data_provider.dart';
import 'package:ifb_loan/features/login/data/repository/login_repository.dart';
import 'package:ifb_loan/features/login/presentation/screen/login_screen.dart';
import 'package:ifb_loan/features/otp/bloc/otp_bloc.dart';
import 'package:ifb_loan/features/otp/data/data_provider/otp_data_provider.dart';
import 'package:ifb_loan/features/otp/data/repository/otp_repository.dart';
import 'package:ifb_loan/features/profile/bloc/profile_bloc.dart';
import 'package:ifb_loan/features/profile/data/data_provider/profile_data_provider.dart';
import 'package:ifb_loan/features/profile/data/repository/profile_repository.dart';
import 'package:ifb_loan/features/provider_KYC/bloc/provider_kyc_bloc.dart';
import 'package:ifb_loan/features/provider_KYC/data/data_provider/provider_KYC_data_provider.dart';
import 'package:ifb_loan/features/provider_KYC/data/repository/provider_KYC_repository.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:ifb_loan/features/provider_loan_form/data/data_provider/provider_loan_form_data_provider.dart';
import 'package:ifb_loan/features/provider_loan_form/data/repository/provider_loan_form_repository.dart';
import 'package:ifb_loan/features/rate_provider/bloc/rate_provider_bloc.dart';
import 'package:ifb_loan/features/rate_provider/data/data_provider/rate_provider_data_provider.dart';
import 'package:ifb_loan/features/rate_provider/data/repository/rate_provider_repository.dart';
import 'package:ifb_loan/features/signup/bloc/signup_bloc.dart';
import 'package:ifb_loan/features/signup/data/data_provider/signup_data_provider.dart';
import 'package:ifb_loan/features/signup/data/repository/signup_repository.dart';
import 'package:ifb_loan/features/splash_screen/splash_screen.dart';
import 'package:ifb_loan/features/switch_account/bloc/account_bloc.dart';
import 'package:ifb_loan/features/switch_account/data/data_provider/switch_account_data_provider.dart';
import 'package:ifb_loan/features/switch_account/data/repository/switch_account_repository.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';
import 'core/services/background_timeout_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!const bool.fromEnvironment('ALLOW_EMULATOR')) {
    // Terminate or handle emulator-specific logic
    print("Running on emulator is not allowed.");
  }
  final bool isFirstTime = await _checkFirstTime();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: AppColors.primaryDarkColor,
    statusBarIconBrightness: Brightness.light,
  ));

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
    // You might want to show a user-friendly message or handle the error appropriately
  }

  await Permission.notification.isDenied.then((isDenied) {
    if (isDenied) {
      Permission.notification.request();
    }
  });
  Future<bool> isEmulator() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.isPhysicalDevice != true;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.isPhysicalDevice != true;
    }
    return false;
  }

  String? lang = await LanguageManager().getLanguage();
  bool emulator = await isEmulator();
  lang ??= '';
  if (emulator) {
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
                LoanApprovalStatusRepository(
                    LoanApprovalStatusDataProvider()))),
        BlocProvider(
            create: (contex) =>
                FinancesBloc(FinancesRepository(FinanceDataProvider()))),
        BlocProvider(
            create: (contex) =>
                OtpBloc(OtpRepository(otpDataProvider: OtpDataProvider()))),
        BlocProvider(
            create: (contex) => HomeBloc(HomeRepository(HomeDataProvider()))),
        BlocProvider(
            create: (contex) => ProviderKycBloc(
                ProviderKYCRepository(ProviderKycDataProvider()))),
        BlocProvider(
            create: (contex) => LoanRepaymentBloc(
                LoanRepaymentRepository(LoanRepaymentDataProvider()))),
        BlocProvider(create: (contex) => DashboardBloc()),
        BlocProvider(create: (contex) => UserTypeCubit()),
        BlocProvider(
            create: (contex) => AccountBloc(
                SwitchAccountRepository(SwitchAccountDataProvider()))),
        BlocProvider(
            create: (contex) => RateProviderBloc(
                RateProviderRepository(RateProviderDataProvider()))),
        BlocProvider(
            create: (context) =>
                ProfileBloc(ProfileRepository(ProfileDataProvider()))),
      ],
      child: BaseScreen(
        child: MyApp(
          isFirstTime: isFirstTime,
          lang: lang,
        ),
      ),
    ));
  } else {
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('This app cannot run on an emulator.'),
          ),
        ),
      ),
    );
  }
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

Future<bool> isEmulator() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.isPhysicalDevice != true;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice != true;
  }
  return false;
}

class MyApp extends StatefulWidget {
  final String lang;
  final bool isFirstTime;
  const MyApp({super.key, required this.isFirstTime, required this.lang});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    BackgroundTimeoutService.updateLastActiveTime();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    BackgroundTimeoutService.stopBackgroundTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        // App goes to background
        BackgroundTimeoutService.startBackgroundTimer();
        break;
      case AppLifecycleState.resumed:
        // App comes to foreground
        BackgroundTimeoutService.stopBackgroundTimer();
        BackgroundTimeoutService.updateLastActiveTime();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: LocalizationString(),
      locale: widget.lang == "English"
          ? const Locale('en', 'US')
          : widget.lang == "አማርኛ"
              ? const Locale('am', 'ET')
              : widget.lang == "Afaan Oromoo"
                  ? const Locale('or', 'ET')
                  : const Locale("en", "US"),
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData(),
      getPages: [
        GetPage(
          name: '/login',
          page: () => const LoginScreen(),
        ),
      ],
      home: widget.isFirstTime ? const LandingPage() : const SplashScreenPage(),
    );
  }
}
