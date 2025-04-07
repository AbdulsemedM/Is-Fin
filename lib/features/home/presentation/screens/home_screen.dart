import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
// import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/business_partners_screen.dart';
import 'package:ifb_loan/features/home/bloc/home_bloc.dart';
// import 'package:ifb_loan/configuration/auth_service.dart';
import 'package:ifb_loan/features/home/presentation/widgets/home_icon_widget.dart';
import 'package:ifb_loan/features/home/presentation/widgets/multiple_range_guage_widget.dart';
import 'package:ifb_loan/features/home/presentation/widgets/slider_widget.dart';
// import 'package:ifb_loan/features/home/presentation/widgets/balance.dart';
import 'package:ifb_loan/features/loan_application/presentation/screen/loan_application_screen.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_loan_list_screen.dart';
import 'package:intl/intl.dart';
// import 'package:ifb_loan/features/settings/presentation/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  String kycStatus = "null";
  UserManager userManager = UserManager();
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FetcheCreditScore());
    fetchUserStatus();
  }

  fetchUserStatus() async {
    print("Fetching user status");
    try {
      String myName = (await userManager.getFullName())!;
      String kyc = (await userManager.getKYCStatus()).toString();

      setState(() {
        name = myName;
        kycStatus = kyc;
      });
    } catch (e) {
      // print('Error fetching user status: $e');
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning!".tr;
    } else if (hour < 17) {
      return "Good Afternoon!".tr;
    } else {
      return "Good Evening!".tr;
    }
  }

  Widget _buildLegendItem(
      BuildContext context, String label, Color color, String range) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.tr,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          range,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
      child: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Hello ".tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28),
                                  ),
                                  TextSpan(
                                    text: name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 28),
                                  ),
                                  TextSpan(
                                    text: " 👋",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(
                                          fontSize: 24,
                                        ),
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        _getGreeting(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => const SettingsScreen()));
                //   },
                //   child: const CircleAvatar(
                //     radius: 25,
                //     backgroundColor: AppColors.primaryColor,
                //     child: Center(
                //       child: Icon(Icons.person),
                //     ),
                //   ),
                // )
              ],
            ),
          ),
          // )
          SizedBox(
            height: ScreenConfig.screenHeight * 0.03,
          ),
          // Text(
          //   "Coop Bank's Sharia-compliant financing",
          //   style: Theme.of(context)
          //       .textTheme
          //       .bodyMedium
          //       ?.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: ScreenConfig.screenHeight * 0.01),
          // Text(
          //   textAlign: TextAlign.center,
          //   "Coop Bank offers a Sharia-compliant, interest-free digital product that ensures transparency and aligns with Islamic values.",
          //   style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.6),
          // ),
          // SizedBox(height: ScreenConfig.screenHeight * 0.03),
          // LoanStatusCard(),
          // const SizedBox(
          //   height: 250,
          //   child: MultipleRangeGaugeWidget(
          //     value: 723,
          //   ),
          // ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is CreditScoreFetchedSuccess) {
                return SizedBox(
                  height: 250,
                  child: MultipleRangeGaugeWidget(
                    value: state.score.overallScore,
                  ),
                );
              } else if (state is CreditScoreFetchedFailure) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 250,
                      child: MultipleRangeGaugeWidget(
                        value: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Something went wrong".tr),
                      // child: Text(state.errorMessage),
                    ),
                  ],
                );
              } else if (state is CreditScoreFetchedLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return const SizedBox.shrink(); // Default empty state
            },
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              final score = state is CreditScoreFetchedSuccess
                  ? state.score.overallScore
                  : '0';
              final amountAllowed = state is CreditScoreFetchedSuccess
                  ? state.score.amountAllowed
                  : '0';

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildLegendItem(
                            context, 'Very Poor', Colors.red, '0-170'),
                        _buildLegendItem(
                            context, 'Poor', Colors.orange, '171-340'),
                        _buildLegendItem(
                            context, 'Average', Colors.yellow, '341-510'),
                        _buildLegendItem(
                            context, 'Good', Colors.lightGreen, '511-680'),
                        _buildLegendItem(
                            context, 'Excellent', Colors.green, '681-850'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Your Credit Score: '.tr,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          NumberFormat("#,##0")
                              .format(double.tryParse(score.toString()) ?? 0),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primaryColor.withOpacity(0.1),
                                  AppColors.primaryColor.withOpacity(0.05)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Purchase Limit".tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: AppColors.primaryColor
                                            .withOpacity(0.7),
                                      ),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_balance_wallet,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.7),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      amountAllowed.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.9),
                                          ),
                                    ),
                                    Text(
                                      " ETB".tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor
                                                .withOpacity(0.9),
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                        kycStatus == "null" ||
                                kycStatus == "Not Filled" ||
                                kycStatus == "IN_PROGRESS" ||
                                kycStatus == "REJECTED"
                            ? 'Complete your KYC to achieve a good credit score. A verified KYC helps improve your financial profile!'
                                .tr
                            : 'Your KYC is verified!'.tr,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey[600])),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                HomeIconWidget(
                  title: 'Verify'.tr,
                  icon: Icons.fingerprint,
                  iconColor: Colors.orange,
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const CompleteKYCDetail())).then((_) {
                      fetchUserStatus();
                    });
                  },
                ),
                HomeIconWidget(
                  title: 'Provider'.tr,
                  icon: Icons.person_add,
                  iconColor: Colors.deepOrange,
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BusinessPartnersScreen()));
                  },
                ),
                HomeIconWidget(
                  title: 'Apply'.tr,
                  icon: Icons.account_balance_wallet,
                  iconColor: Colors.blue,
                  onClicked: () {
                    if (kycStatus == "null" ||
                        kycStatus == "Not Filled" ||
                        kycStatus == "IN_PROGRESS" ||
                        kycStatus == "REJECTED") {
                      displaySnack(
                          context,
                          "Please fill KYC before going to loan applications."
                              .tr,
                          Colors.red);
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const LoanApplicationScreen()));
                    }
                  },
                ),
                HomeIconWidget(
                  title: 'Provider Form'.tr,
                  icon: Icons.list_alt_rounded,
                  iconColor: Colors.purple,
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ProviderLoanListScreen()));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableCard(
                    title: 'Bi-Weekly'.tr,
                    iconContainer: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.calendar_month, color: Colors.white),
                    ),
                    description:
                        'The Bi-Weekly Michu Mizan Murabaha Financing is designed for customers seeking short-term financial support. With a financing amount ranging from 5,000 to 25,000 ETB, this product provides quick access to funds with a 15-day repayment duration. It operates under a Murabaha model, ensuring transparency in profit margins, with a markup (profit margin) of 3. Additionally, a 2% processing fee applies to the financing amount. This option is ideal for individuals needing smaller financial assistance with a short repayment cycle'
                            .tr,
                    onGetStarted: () {
                      // print("Get Started clicked");
                    },
                    cardColor: const Color(0xFFFAC7A6), // Custom card color
                  ),
                  ExpandableCard(
                    title: 'Monthly'.tr,
                    iconContainer: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.calendar_view_day_rounded,
                          color: Colors.white),
                    ),
                    description:
                        'The Monthly Michu Mizan Murabaha Financing offers a more extensive financing solution, catering to customers who require larger amounts and a longer repayment period. Customers can access financing between 25,000 and 100,000 ETB, with a 30-day repayment duration. This financing follows the Murabaha principle with a markup (profit margin) of 6, ensuring ethical and transparent transactions. A 2% processing fee is applicable. This product is well-suited for individuals or businesses needing substantial financial support with a manageable repayment timeline.'
                            .tr,
                    onGetStarted: () {
                      // print("Get Started clicked");
                    },
                    cardColor: const Color(0xFFA6D9FA), // Custom card color
                  ),
                  // ExpandableCard(
                  //   title: 'Mudarabah'.tr,
                  //   iconContainer: Container(
                  //     padding: const EdgeInsets.all(8),
                  //     decoration: const BoxDecoration(
                  //       color: Colors.green,
                  //       shape: BoxShape.circle,
                  //     ),
                  //     child: const Icon(Icons.account_balance,
                  //         color: Colors.white),
                  //   ),
                  //   description:
                  //       'Mudaraba is a profit-sharing agreement where one party (the bank) provides the capital, and the other party (the entrepreneur) manages the business, with profits shared as per a pre-agreed ratio, and losses borne solely by the capital provider in line with Islamic financing norms.'
                  //           .tr,
                  //   onGetStarted: () {
                  //     // print("Get Started clicked");
                  //   },
                  //   cardColor: const Color.fromARGB(
                  //       255, 155, 249, 163), // Custom card color
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
