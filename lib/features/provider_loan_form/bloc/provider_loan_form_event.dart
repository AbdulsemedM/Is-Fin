part of 'provider_loan_form_bloc.dart';

@immutable
sealed class ProviderLoanFormEvent {}

final class FetchProviderLoanFormList extends ProviderLoanFormEvent {
  FetchProviderLoanFormList();
}
