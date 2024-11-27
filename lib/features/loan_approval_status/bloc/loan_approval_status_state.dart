part of 'loan_approval_status_bloc.dart';

@immutable
sealed class LoanApprovalStatusState {}

final class LoanApprovalStatusInitial extends LoanApprovalStatusState {}

final class LoanApprovalListFetchedLoading extends LoanApprovalStatusState {}

final class LoanApprovalListFetchedSuccess extends LoanApprovalStatusState {
  final List<StatusProductListModel> productList;

  LoanApprovalListFetchedSuccess({required this.productList});
}

final class LoanApprovalListFetchedFailure extends LoanApprovalStatusState {
  final String errorMessage;

  LoanApprovalListFetchedFailure(this.errorMessage);
}
