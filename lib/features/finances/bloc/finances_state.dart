part of 'finances_bloc.dart';

@immutable
sealed class FinancesState {}

final class FinancesInitial extends FinancesState {}

final class ActiveLoansFetchedLoading extends FinancesState {}

final class ActiveLoansFetchedSuccess extends FinancesState {
  final List<ActiveLoanModel> activeLoans;

  ActiveLoansFetchedSuccess({required this.activeLoans});
}

final class ActiveLoansFetchedFailure extends FinancesState {
  final String errorMessage;

  ActiveLoansFetchedFailure({required this.errorMessage});
}
