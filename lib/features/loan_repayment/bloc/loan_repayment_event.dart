part of 'loan_repayment_bloc.dart';

@immutable
sealed class LoanRepaymentEvent {}

class GetRepaymentHistoryEvent extends LoanRepaymentEvent {
  final String loanId;
  GetRepaymentHistoryEvent({required this.loanId});
}

class MakePaymentEvent extends LoanRepaymentEvent {
  final String loanId;
  final String amount;
  MakePaymentEvent({required this.loanId, required this.amount});
}
