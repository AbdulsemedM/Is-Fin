part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class CreditScoreFetchedLoading extends HomeState {}

final class CreditScoreFetchedSuccess extends HomeState {
  final String score;

  CreditScoreFetchedSuccess({required this.score});
}

final class CreditScoreFetchedFailure extends HomeState {
  final String errorMessage;

  CreditScoreFetchedFailure({required this.errorMessage});
}
