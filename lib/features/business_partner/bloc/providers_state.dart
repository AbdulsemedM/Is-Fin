part of 'providers_bloc.dart';

@immutable
sealed class ProvidersState {}

final class ProviderSendInitial extends ProvidersState {}

final class ProviderSendLoading extends ProvidersState {}

final class ProviderSendSuccess extends ProvidersState {
  final Map<String, String> provider;

  ProviderSendSuccess({required this.provider});
}

final class ProviderSendFailure extends ProvidersState {
  final String errorMessage;

  ProviderSendFailure(this.errorMessage);
}

final class ProviderVerifyLoading extends ProvidersState {}

final class ProviderVerifySuccess extends ProvidersState {
  final String message;

  ProviderVerifySuccess({required this.message});
}

final class ProviderVerifyFailure extends ProvidersState {
  final String errorMessage;

  ProviderVerifyFailure(this.errorMessage);
}

final class ProviderFetchLoading extends ProvidersState {}

final class ProviderFetchSuccess extends ProvidersState {
  final List<Map<String, String>> providers;

  ProviderFetchSuccess({required this.providers});
}

final class ProviderFetchFailure extends ProvidersState {
  final String errorMessage;

  ProviderFetchFailure(this.errorMessage);
}
