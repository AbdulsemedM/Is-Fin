part of 'rate_provider_bloc.dart';

@immutable
sealed class RateProviderEvent {}

class RateProviderFetch extends RateProviderEvent {}

class RateProviderRate extends RateProviderEvent {
  final String supplierId;
  final double rating;
  final String comment;

  RateProviderRate({required this.supplierId, required this.rating, required this.comment});
}