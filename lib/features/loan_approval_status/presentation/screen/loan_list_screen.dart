import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_advanced_segment/flutter_advanced_segment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ifb_loan/app/utils/app_colors.dart';
import 'package:ifb_loan/app/utils/dialog_utils.dart';
import 'package:ifb_loan/features/loan_approval_status/bloc/loan_approval_status_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/all_applications.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/approved_applicatins.dart';
import 'package:ifb_loan/features/loan_approval_status/presentation/widgets/new_applications.dart';
import 'package:swipe_refresh/swipe_refresh.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({super.key});

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  final _selectedSegment = ValueNotifier('new');
  final _controller = StreamController<SwipeRefreshState>.broadcast();
  List<StatusProductListModel> _loanList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchLoanList();
  }

  void _fetchLoanList() async {
    context.read<LoanApprovalStatusBloc>().add(FetchLoanApprovalStatusList());
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.sink.add(SwipeRefreshState.hidden);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Loan Requests".tr,
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocListener<LoanApprovalStatusBloc, LoanApprovalStatusState>(
        listener: (context, state) {
          if (state is LoanApprovalListFetchedLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state is LoanApprovalListFetchedSuccess) {
            setState(() {
              _loanList = state.productList;
              _loanList.sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
              isLoading = false;
            });
          } else if (state is LoanApprovalListFetchedFailure) {
            // Show error message
            setState(() {
              isLoading = false;
            });
            displaySnack(context, state.errorMessage, Colors.red);
          }
        },
        child: SwipeRefresh.material(
          stateStream: _controller.stream,
          onRefresh: _fetchLoanList,
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          children: [
            Column(
              children: [
                Text(
                  "Fill a Form".tr,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // _buildLabel('Multiple Items'),
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
                      segments: {
                        'new': 'New'.tr,
                        'all': 'All'.tr,
                        'approved': 'Approved'.tr,
                      },
                    ),
                    const SizedBox(height: 20),
                    if (isLoading)
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    else
                      ValueListenableBuilder<String>(
                        valueListenable: _selectedSegment,
                        builder: (_, selectedSegment, __) {
                          if (selectedSegment == 'new') {
                            return NewLoanApplications(
                              loanformList: _loanList.where((element) {
                                final requestDate =
                                    DateTime.parse(element.requestedAt);
                                final fourDaysAgo = DateTime.now()
                                    .subtract(const Duration(days: 7));
                                return requestDate.isAfter(fourDaysAgo);
                              }).toList(),
                            );
                          } else if (selectedSegment == 'all') {
                            return AllLoanApplications(
                              loanformList: _loanList,
                            );
                          } else if (selectedSegment == 'approved') {
                            return ApprovedLoanApplicatins(
                              loanformList: _loanList
                                  .where((element) =>
                                      element.status == 'ACCEPTED' ||
                                      element.status == 'APPROVED' ||
                                      element.status == 'LOAN_ACCEPTED' ||
                                      element.status == 'CLOSED' ||
                                      element.status == 'AGREEMENT_ACCEPTED')
                                  .toList(),
                            );
                          }
                          return const SizedBox
                              .shrink(); // Empty widget if no match
                        },
                      ),
                    // SizedBox(
                    //   height: 100,
                    //   child: ListView(
                    //     children: loanformList.map((transaction) {
                    //       return LoanListScreenWidget(
                    //         name: transaction["name"],
                    //         amount: transaction["amount"],
                    //         description: transaction["description"],
                    //         date: transaction["date"],
                    //         icon: transaction["icon"],
                    //         iconColor: transaction["iconColor"],
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
