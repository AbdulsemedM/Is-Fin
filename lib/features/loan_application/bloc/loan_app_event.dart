part of 'loan_app_bloc.dart';

@immutable
sealed class LoanAppEvent {}

class SectorsFetch extends LoanAppEvent {
  SectorsFetch();
}

class RepaymentsFetch extends LoanAppEvent {
  RepaymentsFetch();
}

class UnitofMeasurementsFetch extends LoanAppEvent {
  UnitofMeasurementsFetch();
}
