part of 'providers_bloc.dart';

@immutable
sealed class ProvidersEvent {}

class ProviderSend extends ProvidersEvent {
  final String phoneNumber;

  ProviderSend({required this.phoneNumber});
}
