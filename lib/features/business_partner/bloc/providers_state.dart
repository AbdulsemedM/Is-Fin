part of 'providers_bloc.dart';

@immutable
sealed class ProvidersState {}

final class ProviderSendInitial extends ProvidersState {}

final class ProviderSendLoading extends ProvidersState {}

final class ProviderSendSuccess extends ProvidersState {}

final class ProviderSendFailure extends ProvidersState {
  final String errorMessage;

  ProviderSendFailure(this.errorMessage);
}
