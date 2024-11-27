import 'package:flutter/material.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/business_partners_screen.dart';
// import 'package:ifb_loan/configuration/auth_service.dart';
import 'package:ifb_loan/features/home/presentation/widgets/home_icon_widget.dart';
import 'package:ifb_loan/features/home/presentation/widgets/slider_widget.dart';
import 'package:ifb_loan/features/home/presentation/widgets/balance.dart';
import 'package:ifb_loan/features/loan_application/presentation/screen/loan_application_screen.dart';

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
    fetchUserStatus();
  }

  fetchUserStatus() async {
    try {
      String myName = (await userManager.getFullName())!;
      String kyc = (await userManager.getKYCStatus()).toString();

      setState(() {
        name = myName;
        kycStatus = kyc;
      });
    } catch (e) {
      print('Error fetching user status: $e');
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning!";
    } else if (hour < 17) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
    }
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
                      Text(
                        "Hello $name!",
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall
                            ?.copyWith(
                                fontWeight: FontWeight.w700, fontSize: 28),
                        overflow: TextOverflow.ellipsis,
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
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.primaryColor,
                  child: Center(
                    child: Icon(Icons.person),
                  ),
                )
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
          LoanStatusCard(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpandableCard(
                    title: 'Murabaha',
                    iconContainer: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.account_balance,
                          color: Colors.white),
                    ),
                    description:
                        'Murabaha at Coop Bank is a Sharia-compliant financing product where the bank buys goods for customers and resells them at a disclosed profit, allowing interest-free financing in line with Islamic principles.',
                    onGetStarted: () {
                      // print("Get Started clicked");
                    },
                    cardColor: const Color(0xFFFAC7A6), // Custom card color
                  ),
                  ExpandableCard(
                    title: 'Musharaka',
                    iconContainer: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.handshake_rounded,
                          color: Colors.white),
                    ),
                    description:
                        'Murabaha at Coop Bank is a Sharia-compliant financing product where the bank buys goods for customers and resells them at a disclosed profit, allowing interest-free financing in line with Islamic principles.',
                    onGetStarted: () {
                      // print("Get Started clicked");
                    },
                    cardColor: const Color(0xFFA6D9FA), // Custom card color
                  ),
                  ExpandableCard(
                    title: 'Mudarabah',
                    iconContainer: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.account_balance,
                          color: Colors.white),
                    ),
                    description:
                        'Murabaha at Coop Bank is a Sharia-compliant financing product where the bank buys goods for customers and resells them at a disclosed profit, allowing interest-free financing in line with Islamic principles.',
                    onGetStarted: () {
                      // print("Get Started clicked");
                    },
                    cardColor: const Color.fromARGB(
                        255, 155, 249, 163), // Custom card color
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeIconWidget(
                  title: 'Loan App',
                  icon: Icons.account_balance_wallet,
                  iconColor: Colors.blue,
                  onClicked: () {
                    if (kycStatus == "null" || kycStatus == "IN_PROGRESS") {
                      displaySnack(
                          context,
                          "Please fill KYC before going to loan applications.",
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
                  title: 'KYC',
                  icon: Icons.store,
                  iconColor: Colors.orange,
                  onClicked: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteKYCDetail()));
                  },
                ),
                HomeIconWidget(
                  title: 'Provider',
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
                  title: 'Repayment',
                  icon: Icons.calendar_today,
                  iconColor: Colors.purple,
                  onClicked: () {
                    // print("Repayment clicked");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
