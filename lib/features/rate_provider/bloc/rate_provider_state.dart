part of 'rate_provider_bloc.dart';

@immutable
sealed class RateProviderState {}

class RateProviderInitial extends RateProviderState {}

class RateProviderLoading extends RateProviderState {}

class RateProviderSuccess extends RateProviderState {
  final String message;
  RateProviderSuccess(this.message);
}

class RateProviderError extends RateProviderState {
  final String message;

  RateProviderError(this.message);
}
