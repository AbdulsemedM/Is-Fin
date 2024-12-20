import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/app/utils/app_theme.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/business_partner/presentation/screen/add_bisiness_partner_screen.dart';
import 'package:ifb_loan/features/finances/bloc/finances_bloc.dart';
import 'package:ifb_loan/features/finances/models/active_loan_model.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/finances_widget.dart';
import 'package:ifb_loan/features/finances/presentation/widgets/loan_display_card.dart';
import 'package:ifb_loan/features/loan_application/presentation/screen/loan_application_screen.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/screen/loan_list_screen.dart';
import 'package:ifb_loan/features/loan_repayment/presentation/screen/loan_repayment_screen.dart';

class FinancesScreen extends StatefulWidget {
  const FinancesScreen({super.key});

  @override
  State<FinancesScreen> createState() => _FinancesScreenState();
}

class _FinancesScreenState extends State<FinancesScreen> {
  String kycStatus = "null";
  UserManager userManager = UserManager();
  var loading = false;
  List<ActiveLoanModel> myActiveLoans = [];
  @override
  void initState() {
    super.initState();
    fetchLoans();
    fetchUserStatus();
  }

  fetchLoans() async {
    context.read<FinancesBloc>().add(FetchActiveLoans());
  }

  fetchUserStatus() async {
    try {
      String kyc = (await userManager.getKYCStatus()).toString();

      setState(() {
        kycStatus = kyc;
      });
    } catch (e) {
      // print('Error fetching user status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Text(
              "Finances",
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            height: ScreenConfig.screenHeight * 0.45,
            child: GridView.builder(
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                return FinancesCard(
                  icon: Icons.file_copy,
                  iconContainerColor: index == 0
                      ? Colors.blue.shade200
                      : index == 1
                          ? Colors.orange.shade200
                          : index == 2
                              ? Colors.green.shade200
                              : Colors.red.shade200,
                  title: index == 0
                      ? "Loan Request"
                      : index == 1
                          ? "Loan Repay"
                          : index == 2
                              ? "Loan Status"
                              : "Add Provider",
                  subtitle: 'Subtitle $index',
                  containerColor: index == 0
                      ? Colors.blue.shade100
                      : index == 1
                          ? Colors.orange.shade100
                          : index == 2
                              ? Colors.green.shade100
                              : Colors.red.shade100,
                  onTap: () {
                    if (index == 0) {
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
                    } else if (index == 3) {
                      if (kycStatus == "null" ||
                          kycStatus == "Not Filled" ||
                          kycStatus == "IN_PROGRESS") {
                        displaySnack(
                            context,
                            "Please fill KYC before going to add business partner.",
                            Colors.red);
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AddBisinessPartnerScreen()));
                      }
                    } else if (index == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoanListScreen()));
                    }
                  },
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Text(
                "Overall loan History",
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        BlocListener<FinancesBloc, FinancesState>(
          listener: (context, state) {
            if (state is ActiveLoansFetchedLoading) {
              setState(() {
                loading = true;
              });
            } else if (state is ActiveLoansFetchedSuccess) {
              setState(() {
                myActiveLoans = state.activeLoans;
                loading = false;
              });
            } else if (state is ActiveLoansFetchedFailure) {
              setState(() {
                loading = false;
              });
              displaySnack(context, state.errorMessage, Colors.red);
            }
          },
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : myActiveLoans.isEmpty
                  ? Center(
                      child: Text(
                        'No active loans available',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : SizedBox(
                      height: ScreenConfig.screenHeight * 0.35,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: myActiveLoans.length,
                        itemBuilder: (context, index) {
                          final loan = myActiveLoans[index];
                          return GestureDetector(
                            onTap: () {
                              loan.id;
                              loan.name;
                              loan.sector;
                              loan.totalPayableAmount;
                              loan.productQuantity;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoanRepaymentScreen(
                                          penalty: loan.penaltyAmount,
                                          outStandingAmount:
                                              loan.outstandingAmount,
                                          name: loan.name,
                                          id: loan.id,
                                          sector: loan.sector,
                                          totalPayableAmount:
                                              loan.totalPayableAmount,
                                          productQuantity:
                                              loan.productQuantity)));
                            },
                            child: LoanCard(
                              penalty: loan.penaltyAmount,
                              outStandingAmount: loan.outstandingAmount,
                              loanTitle: loan.name, // Dynamic title
                              loanDescription:
                                  loan.productQuantity, // Dynamic description
                              amount: loan.totalPayableAmount, // Dynamic amount
                              // lender: loan.lenderName, // Dynamic lender name
                              backgroundColor: _getBackgroundColor(index),
                              image: _getLoanImage(
                                  loan.sector), // Dynamic image based on type
                            ),
                          );
                        },
                      ),
                    ),
        )
      ],
    );
  }

  Color _getBackgroundColor(int index) {
    // Alternate colors for the loan cards
    return index % 2 == 0 ? Colors.blue.shade100 : Colors.orange.shade100;
  }

  Image _getLoanImage(String type) {
    // Return different images based on loan type
    switch (type.toLowerCase()) {
      case 'electronics':
        return Image.asset(
          'assets/images/elec.png',
          fit: BoxFit.contain,
        );
      case 'agriculture':
        return Image.asset(
          'assets/images/agri.png',
          fit: BoxFit.contain,
        );
      default:
        return Image.asset(
          'assets/images/default.png', // Default image
          fit: BoxFit.contain,
        );
    }
  }
}
