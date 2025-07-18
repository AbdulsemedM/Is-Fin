import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ifb_loan/app/app_button.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/bloc/kyc_bloc.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
//import 'package:ifb_loan/features/KYC/presentation/screen/kyc_screen.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/business_partners_screen.dart';
import 'package:ifb_loan/features/profile/bloc/bloc/profile_bloc.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/custome_list_button.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/kyc_card_widget.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/loan_status_card.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/public_mode_card.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/profile_image_widget.dart';
import 'package:ifb_loan/features/profile/presentation/widgets/upper_circular_design.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/screen/provider_loan_list_screen.dart';
//import 'package:ifb_loan/features/rate_provider/presentation/screens/rate_provider_screen.dart';
import 'package:ifb_loan/features/switch_account/presentation/screens/switch_account_screen.dart';

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
    // Fetch initial public mode status
    context.read<ProfileBloc>().add(ProfileFetch());
  }

  fetchUserStatus() async {
    try {
      String myName = (await userManager.getFullName())!;

      setState(() {
        name = myName;
      });
    } catch (e) {
      // print('Error fetching user status: $e');
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
              // print("KycPersonalFetchedSuccess");
              kycStatus += 25;
              steps.add("Perssonal Info.");
              isPersonalFetched = true;
            }
          });
        } else if (state is KycBusinessFetchedSuccess && progressLoading) {
          setState(() {
            if (!isBusinessFetched) {
              // print("KycBusinessFetchedSuccess");
              kycStatus += 25;
              steps.add("Business Info.");
              isBusinessFetched = true;
            }
          });
        } else if (state is KycAccountFetchedSuccess && progressLoading) {
          setState(() {
            if (!isAccountFetched) {
              // print("KycAccountFetchedSuccess");
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
                // print("renewedId");
                kycStatus += 8;
                addStep("Images Info.");
              }

              String? tinNumber =
                  (images.tinNumber?.isNotEmpty ?? false) ? "Done" : null;
              if (tinNumber != null) {
                // print("tinNumber");
                // kycStatus += 6.25;
                addStep("Images Info.");
              }

              String? regCertificate =
                  (images.commercialRegistrationCertificate?.isNotEmpty ??
                          false)
                      ? "Done"
                      : null;
              if (regCertificate != null) {
                // print("regCertificate");
                kycStatus += 9;
                addStep("Images Info.");
              }

              String? tradeLicense =
                  (images.renewedTradeLicense?.isNotEmpty ?? false)
                      ? "Done"
                      : null;
              if (tradeLicense != null) {
                // print("tradeLicense");
                kycStatus += 8;
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity,
                      MediaQuery.of(context).size.height * 0.25),
                  painter: CurvedPainter(),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.08,
                  left: 0,
                  right: 0,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfileImageWidget(),
                      // SizedBox(height: 10),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Hi, $name.",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: KycProgressCard(
                title: 'KYC Completed'.tr,
                percent: kycStatus / 100,
                step1: step1.tr,
                step2: step2.tr,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  CustomListButton(
                    icon: Icons.account_balance,
                    title: 'Switch Account'.tr,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SwitchAccountScreen()));
                    },
                  ),
                  CustomListButton(
                    icon: Icons.star,
                    title: 'Rate Provider'.tr,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BusinessPartnersScreen(
                                    isRateProvider: true,
                                    isViewRatings: false,
                                  )));
                    },
                  ),
                  CustomListButton(
                    icon: Icons.switch_account,
                    title: 'See Provider Ratings'.tr,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const BusinessPartnersScreen(
                                    isRateProvider: false,
                                    isViewRatings: true,
                                  )));
                    },
                  ),
                  BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      bool isPublic = false;
                      bool isLoading = state is FetchProfileLoading ||
                          state is UpdateProfileLoading;

                      if (state is FetchProfileSuccess ||
                          state is UpdateProfileSuccess) {
                        isPublic = state is FetchProfileSuccess
                            ? state.isPublic
                            : (state as UpdateProfileSuccess).isPublic;
                      }

                      if (isLoading) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(16),
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
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Container(
                                  width: 40,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return PublicModeCard(
                        initialValue: isPublic,
                        onChanged: (value) {
                          if (!isLoading) {
                            context
                                .read<ProfileBloc>()
                                .add(ProfileUpdate(isPublic: value));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  const LoanStatusCard(
                    completedLoans: 0,
                    pendingLoans: 0,
                    failedLoans: 0,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Text(
                      "If you are here as a product seller and wanted to fill a form or check status please click the button bellow"
                          .tr,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: MyButton(
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
                            : Text(
                                "Click Here".tr,
                                style: const TextStyle(color: Colors.white),
                              )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
