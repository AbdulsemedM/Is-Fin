part of 'provider_loan_form_bloc.dart';

@immutable
sealed class ProviderLoanFormEvent {}

final class FetchProviderLoanFormList extends ProviderLoanFormEvent {
  FetchProviderLoanFormList();
}

final class FetchRequestedProductsById extends ProviderLoanFormEvent {
  final String id;

  FetchRequestedProductsById(this.id);
}

final class SendRequestedProductsPrice extends ProviderLoanFormEvent {
  final List<RequestedProductsModel> products;
  final String id;
  final String expirationDate;
  final String status;

  SendRequestedProductsPrice(
      this.products, this.id, this.expirationDate, this.status);
}
