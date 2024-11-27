import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/business_partners_screen.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/custome_list_button.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/kyc_card_widget.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/loan_status_card.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/upper_circular_design.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_loan_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with RouteAware {
  var loading = false;
  var progressLoading = false;
  List<String> steps = [];
  String step1 = "";
  String step2 = "";
  double kycStatus = 0;
  bool isPersonalFetched = false;
  bool isBusinessFetched = false;
  bool isAccountFetched = false;
  bool areImagesFetched = false;
  String name = "";
  UserManager userManager = UserManager();

  @override
  void initState() {
    super.initState();
    getKYCStatus();
    fetchUserStatus();
  }

  fetchUserStatus() async {
    try {
      String myName = (await userManager.getFullName())!;

      setState(() {
        name = myName;
      });
    } catch (e) {
      print('Error fetching user status: $e');
    }
  }

  void addStep(String step) {
    if (!steps.contains(step)) {
      steps.add(step);
    }
  }

  void getKYCStatus() async {
    setState(() {
      kycStatus = 0;
    });
    context.read<KycBloc>().add(PersonalKYCFetched());
    context.read<KycBloc>().add(BusinessKYCFetched());
    context.read<KycBloc>().add(ImagesKYCFetched());
    context.read<KycBloc>().add(AccountKYCFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KycBloc, KycState>(
      listener: (context, state) {
        if (state is KycPersonalFetchedLoading ||
            state is KycBusinessFetchedLoading ||
            state is KycAccountFetchedLoading ||
            state is KycIMagesFetchedLoading) {
          setState(() {
            progressLoading = true;
          });
        }

        if (state is KycPersonalFetchedSuccess && progressLoading) {
          setState(() {
            if (!isPersonalFetched) {
              print("KycPersonalFetchedSuccess");
              kycStatus += 25;
              steps.add("Perssonal Info.");
              isPersonalFetched = true;
            }
          });
        } else if (state is KycBusinessFetchedSuccess && progressLoading) {
          setState(() {
            if (!isBusinessFetched) {
              print("KycBusinessFetchedSuccess");
              kycStatus += 25;
              steps.add("Business Info.");
              isBusinessFetched = true;
            }
          });
        } else if (state is KycAccountFetchedSuccess && progressLoading) {
          setState(() {
            if (!isAccountFetched) {
              print("KycAccountFetchedSuccess");
              kycStatus += 25;
              steps.add("Account Info.");
              isAccountFetched = true;
            }
          });
        } else if (state is KycIMagesFetchedSuccess && progressLoading) {
          setState(() {
            if (!areImagesFetched) {
              ImagesModel images = state.imagesInfo;

              String? renewedId =
                  (images.renewedId?.isNotEmpty ?? false) ? "Done" : null;
              if (renewedId != null) {
                print("renewedId");
                kycStatus += 6.25;
                addStep("Images Info.");
              }

              String? tinNumber =
                  (images.tinNumber?.isNotEmpty ?? false) ? "Done" : null;
              if (tinNumber != null) {
                print("tinNumber");
                kycStatus += 6.25;
                addStep("Images Info.");
              }

              String? regCertificate =
                  (images.commercialRegistrationCertificate?.isNotEmpty ??
                          false)
                      ? "Done"
                      : null;
              if (regCertificate != null) {
                print("regCertificate");
                kycStatus += 6.25;
                addStep("Images Info.");
              }

              String? tradeLicense =
                  (images.renewedTradeLicense?.isNotEmpty ?? false)
                      ? "Done"
                      : null;
              if (tradeLicense != null) {
                print("tradeLicense");
                kycStatus += 6.25;
                addStep("Images Info.");
              }

              areImagesFetched = true;
            }
          });
        }

        // Check if all success states are true
        if (isPersonalFetched &&
            isAccountFetched &&
            isBusinessFetched &&
            areImagesFetched) {
          setState(() {
            step2 = steps.firstWhere(
              (step) => step == "Images Info.",
              orElse: () => steps.isNotEmpty ? steps.first : "Default Step",
            );
            step1 = step2 == "Images Info."
                ? "Business Info."
                : step2 == "Business Info."
                    ? "Personal Info."
                    : "Default Step";
            progressLoading = false;
          });
        }

        if (state is KycPersonalFetchedFailure) {
          setState(() {
            progressLoading = false;
          });
        } else if (state is KycBusinessFetchedFailure) {
          setState(() {
            progressLoading = false;
          });
        } else if (state is KycIMagesFetchedFailure) {
          setState(() {
            progressLoading = false;
          });
        }
      },
      child: Column(
        children: [
          Stack(
            children: [
              // Background curves
              CustomPaint(
                size:
                    const Size(double.infinity, 200), // Adjust height as needed
                painter: CurvedPainter(),
              ),
              // Add content inside the stack if needed, e.g., profile picture, settings icon
              const Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          'assets/images/profile.png'), // Replace with actual image
                    ),
                    // SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          Text(
            "Hi, $name.",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: KycProgressCard(
              title: 'KYC Completed',
              percent: kycStatus / 100, step1: step1, step2: step2, // 74%
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomListButton(
                  icon: Icons.info,
                  title: 'Complete KYC',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CompleteKYCDetail()));
                  },
                ),
                CustomListButton(
                  icon: Icons.add,
                  title: 'Add Business Partner',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const BusinessPartnersScreen()));
                  },
                ),
                const SizedBox(height: 10),
                const LoanStatusCard(
                  completedLoans: 13,
                  pendingLoans: 2,
                  failedLoans: 0,
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                      textAlign: TextAlign.center,
                      "If you are here as a product seller and wanted to fill a form or check status please click the button bellow"),
                ),
                MyButton(
                    backgroundColor: loading
                        ? AppColors.iconColor
                        : AppColors.primaryDarkColor,
                    onPressed: loading
                        ? () {}
                        : () {
                            // setState(() {
                            //   loading = true;
                            // });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProviderLoanListScreen()));
                          },
                    buttonText: loading
                        ? SizedBox(
                            height: ScreenConfig.screenHeight * 0.02,
                            width: ScreenConfig.screenHeight * 0.02,
                            child: const CircularProgressIndicator(
                              strokeWidth: 3,
                              color: AppColors.primaryColor,
                            ),
                          )
                        : const Text(
                            "Click Here",
                            style: TextStyle(color: Colors.white),
                          )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
