part of 'finances_bloc.dart';

@immutable
sealed class FinancesEvent {}

final class FetchActiveLoans extends FinancesEvent {
  FetchActiveLoans();
}
