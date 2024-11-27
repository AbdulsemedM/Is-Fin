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
