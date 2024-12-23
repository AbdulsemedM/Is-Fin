import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
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
import 'package:ifb_loan/features/settings/presentation/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  String kycStatus = "null";
  String score = '0';
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
      return "Good Morning!";
    } else if (hour < 17) {
      return "Good Afternoon!";
    } else {
      return "Good Evening!";
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
          label,
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsScreen()));
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: AppColors.primaryColor,
                    child: Center(
                      child: Icon(Icons.person),
                    ),
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
                // setState(() {
                score = state.score;
                // });
                return SizedBox(
                  height: 250,
                  child: MultipleRangeGaugeWidget(
                    value: double.parse(state.score),
                  ),
                );
              } else if (state is CreditScoreFetchedFailure) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Something went wrong"),
                  ),
                );
              } else if (state is CreditScoreFetchedLoading) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return SizedBox.shrink(); // Default empty state
            },
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    _buildLegendItem(context, 'Very Poor', Colors.red, '0-170'),
                    _buildLegendItem(context, 'Poor', Colors.orange, '171-340'),
                    _buildLegendItem(
                        context, 'Average', Colors.yellow, '341-510'),
                    _buildLegendItem(
                        context, 'Good', Colors.lightGreen, '511-680'),
                    _buildLegendItem(
                        context, 'Excellent', Colors.green, '681-850'),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'Your Credit Score:  $score',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                    kycStatus == "null" ||
                            kycStatus == "Not Filled" ||
                            kycStatus == "IN_PROGRESS"
                        ? 'Complete your KYC to achieve a good credit score. A verified KYC helps improve your financial profile!'
                        : 'Your KYC is verified. A verified KYC helps improve your financial profile!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey[600])),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                HomeIconWidget(
                  title: 'Loan App',
                  icon: Icons.account_balance_wallet,
                  iconColor: Colors.blue,
                  onClicked: () {
                    if (kycStatus == "null" ||
                        kycStatus == "Not Filled" ||
                        kycStatus == "IN_PROGRESS") {
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
                            builder: (context) =>
                                const CompleteKYCDetail())).then((_) {
                      fetchUserStatus();
                    });
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
                  title: 'Fill Form',
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
                        'Musharaka is a partnership-based financing method where both the bank and the customer contribute capital to a joint venture or project, sharing profits according to a pre-agreed ratio while losses are shared in proportion to their respective capital contributions, adhering to Sharia principles.',
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
                        'Mudaraba is a profit-sharing agreement where one party (the bank) provides the capital, and the other party (the entrepreneur) manages the business, with profits shared as per a pre-agreed ratio, and losses borne solely by the capital provider in line with Islamic financing norms.',
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
        ],
      ),
    );
  }
}
