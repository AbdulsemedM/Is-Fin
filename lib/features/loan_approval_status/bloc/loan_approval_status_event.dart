part of 'loan_approval_status_bloc.dart';

@immutable
sealed class LoanApprovalStatusEvent {}

final class FetchLoanApprovalStatusList extends LoanApprovalStatusEvent {
  FetchLoanApprovalStatusList();
}
