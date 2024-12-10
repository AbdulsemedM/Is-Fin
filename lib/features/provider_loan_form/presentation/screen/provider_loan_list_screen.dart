import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/bloc/provider_loan_form_bloc.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/all_applications.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/approved_applicatins.dart';
import 'package:ifb_loan/features/provider_loan_form/presentation/widgets/new_applications.dart';
// import 'package:ifb_loan/features/provider_loan_form/domain/entities/loan_application.dart';
// import 'package:ifb_loan/features/provider_loan_form/presentation/bloc/provider_loan_bloc.dart';

class ProviderLoanListScreen extends StatefulWidget {
  const ProviderLoanListScreen({super.key});

  @override
  State<ProviderLoanListScreen> createState() => _ProviderLoanListScreenState();
}

class _ProviderLoanListScreenState extends State<ProviderLoanListScreen> {
  final _selectedSegment = ValueNotifier('new');
  List<StatusProductListModel> loanApplications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<ProviderLoanFormBloc>().add(FetchProviderLoanFormList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProviderLoanFormBloc, ProviderLoanFormState>(
      listener: (context, state) {
        if (state is ProviderLoanFormListFetchedLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state is ProviderLoanFormListFetchedSuccess) {
          setState(() {
            loanApplications = state.productList;
            // print("loanApplications.length");
            // print(loanApplications.length);
            isLoading = false;
          });
        } else if (state is ProviderLoanFormListFetchedFailure) {
          setState(() {
            isLoading = false;
          });
          displaySnack(context, state.errorMessage, Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Provider Loan Lists",
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                  child: Column(
                    children: [
                      Text(
                        "Fill a Form",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AdvancedSegment(
                            activeStyle: const TextStyle(
                                color: AppColors.bgColor,
                                fontWeight: FontWeight.w700),
                            inactiveStyle: const TextStyle(
                                color: AppColors.bgColor,
                                fontWeight: FontWeight.w500),
                            itemPadding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            backgroundColor: AppColors.iconColor,
                            sliderColor: AppColors.primaryDarkColor,
                            controller: _selectedSegment,
                            segments: const {
                              'new': 'New',
                              'all': 'All',
                              'approved': 'Approved',
                            },
                          ),
                          const SizedBox(height: 20),
                          ValueListenableBuilder<String>(
                            valueListenable: _selectedSegment,
                            builder: (_, selectedSegment, __) {
                              List<StatusProductListModel> filteredList = [];
                              if (selectedSegment == 'new') {
                                filteredList = loanApplications
                                    .where((app) => app.status == 'PENDING')
                                    .toList();
                                print(filteredList.length);
                              } else if (selectedSegment == 'all') {
                                filteredList = loanApplications;
                              } else if (selectedSegment == 'approved') {
                                filteredList = loanApplications
                                    .where((app) => app.status == 'PENDING')
                                    .toList();
                              }

                              // if (filteredList.isEmpty) {
                              //   return Center(
                              //     child: Text(
                              //       "No applications found",
                              //       style:
                              //           Theme.of(context).textTheme.bodyLarge,
                              //     ),
                              //   );
                              // }

                              if (selectedSegment == 'new') {
                                return NewApplications(
                                    loanformList: loanApplications);
                              } else if (selectedSegment == 'all') {
                                return AllApplications(
                                    loanformList: loanApplications);
                              } else if (selectedSegment == 'approved') {
                                return ApprovedApplicatins(
                                    loanformList: loanApplications);
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
