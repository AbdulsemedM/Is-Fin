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

class ProductsRequestSent extends LoanAppEvent {
  final ProductsRequestModel products;
  ProductsRequestSent({required this.products});
}

class UpdateProvidersEvent extends LoanAppEvent {
  final List<Map<String, String>> providers; // Add providers list to the event
  UpdateProvidersEvent(this.providers);
}
