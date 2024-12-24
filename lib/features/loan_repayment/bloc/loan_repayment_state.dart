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

final class LoanRepaymentPaymentLoading extends LoanRepaymentState {}

final class LoanRepaymentPaymentSuccess extends LoanRepaymentState {
  final String transactionId;
  final String customerName;
  final String amount;
  LoanRepaymentPaymentSuccess(
      {required this.transactionId,
      required this.customerName,
      required this.amount});
}

final class LoanRepaymentPaymentFailure extends LoanRepaymentState {
  final String errorMessage;
  LoanRepaymentPaymentFailure(this.errorMessage);
}
