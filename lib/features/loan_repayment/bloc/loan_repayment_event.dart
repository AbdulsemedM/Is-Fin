part of 'loan_repayment_bloc.dart';

@immutable
sealed class LoanRepaymentEvent {}

class GetRepaymentHistoryEvent extends LoanRepaymentEvent {}
