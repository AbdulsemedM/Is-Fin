part of 'providers_bloc.dart';

@immutable
sealed class ProvidersEvent {}

class ProviderSend extends ProvidersEvent {
  final String phoneNumber;

  ProviderSend({required this.phoneNumber});
}

class ProviderVerify extends ProvidersEvent {
  final String phoneNumber;
  final String name;

  ProviderVerify({required this.name, required this.phoneNumber});
}

class ProviderFetch extends ProvidersEvent {
  ProviderFetch();
}
