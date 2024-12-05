part of 'provider_loan_form_bloc.dart';

@immutable
sealed class ProviderLoanFormState {}

final class ProviderLoanFormInitial extends ProviderLoanFormState {}

final class ProviderLoanFormListFetchedLoading extends ProviderLoanFormState {}

final class ProviderLoanFormListFetchedSuccess extends ProviderLoanFormState {
  final List<StatusProductListModel> productList;

  ProviderLoanFormListFetchedSuccess({required this.productList});
}

final class ProviderLoanFormListFetchedFailure extends ProviderLoanFormState {
  final String errorMessage;

  ProviderLoanFormListFetchedFailure(this.errorMessage);
}

final class RequestedProductsFetchedLoading extends ProviderLoanFormState {}

final class RequestedProductsFetchedSuccess extends ProviderLoanFormState {
  final List<RequestedProductsModel> requestedProducts;

  RequestedProductsFetchedSuccess({required this.requestedProducts});
}

final class RequestedProductsFetchedFailure extends ProviderLoanFormState {
  final String errorMessage;

  RequestedProductsFetchedFailure(this.errorMessage);
}

final class RequestedProductsPriceSentLoading extends ProviderLoanFormState {}

final class RequestedProductsPriceSentSuccess extends ProviderLoanFormState {
  final String message;

  RequestedProductsPriceSentSuccess(this.message);
}

final class RequestedProductsPriceSentFailure extends ProviderLoanFormState {
  final String errorMessage;

  RequestedProductsPriceSentFailure(this.errorMessage);
}

final class AcceptUnderTakingAndagentAgreementLoading
    extends ProviderLoanFormState {}

final class AcceptUnderTakingAndAgentAgreementSuccess
    extends ProviderLoanFormState {
  final String message;

  AcceptUnderTakingAndAgentAgreementSuccess(this.message);
}

final class AcceptUnderTakingAndAgentAgreementFailure
    extends ProviderLoanFormState {
  final String errorMessage;

  AcceptUnderTakingAndAgentAgreementFailure(this.errorMessage);
}
