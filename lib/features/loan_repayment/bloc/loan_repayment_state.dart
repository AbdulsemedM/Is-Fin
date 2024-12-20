part of 'loan_repayment_bloc.dart';

@immutable
sealed class LoanRepaymentState {}

final class LoanRepaymentInitial extends LoanRepaymentState {}

final class LoanRepaymentLoading extends LoanRepaymentState {}

final class LoanRepaymentSuccess extends LoanRepaymentState {
  final List<RepaymentHistoryModel> repaymentHistory;
  LoanRepaymentSuccess(this.repaymentHistory);
}

final class LoanRepaymentFailure extends LoanRepaymentState {
  final String errorMessage;
  LoanRepaymentFailure(this.errorMessage);
}
