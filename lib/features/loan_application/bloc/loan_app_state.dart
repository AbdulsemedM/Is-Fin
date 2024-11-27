part of 'loan_app_bloc.dart';

@immutable
sealed class LoanAppState {}

final class LoanAppInitial extends LoanAppState {}

final class SectorFetchLoading extends LoanAppState {}

final class SectorFetchSuccess extends LoanAppState {
  final List<Map<String, String>> sectors;

  SectorFetchSuccess({required this.sectors});
}

final class SectorFetchFailure extends LoanAppState {
  final String errorMessage;

  SectorFetchFailure(this.errorMessage);
}

///////////////////////////////////////////////////////////////////
final class ProductsSentLoading extends LoanAppState {}

final class ProductsSentSuccess extends LoanAppState {
  ProductsSentSuccess();
}

final class ProductsSentFailure extends LoanAppState {
  final String errorMessage;

  ProductsSentFailure(this.errorMessage);
}

////////////////////////////////////////////////////////////////////////////////////////
final class RepaymentFetchLoading extends LoanAppState {}

final class RepaymentFetchSuccess extends LoanAppState {
  final List<Map<String, String>> repayments;

  RepaymentFetchSuccess({required this.repayments});
}

final class RepaymentFetchFailure extends LoanAppState {
  final String errorMessage;

  RepaymentFetchFailure(this.errorMessage);
}

/////////////////////////////////////////////////////////////////////////////////////////
final class UnitofMeasurementsFetchLoading extends LoanAppState {}

final class UnitofMeasurementsFetchSuccess extends LoanAppState {
  final List<Map<String, String>> unitofMeasurement;

  UnitofMeasurementsFetchSuccess({required this.unitofMeasurement});
}

final class UnitofMeasurementsFetchFailure extends LoanAppState {
  final String errorMessage;

  UnitofMeasurementsFetchFailure(this.errorMessage);
}

class ProvidersUpdatedState extends LoanAppState {
  final List<Map<String, String>> providers;
  ProvidersUpdatedState({required this.providers});
}
