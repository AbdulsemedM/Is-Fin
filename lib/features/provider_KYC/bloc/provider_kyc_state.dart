part of 'provider_kyc_bloc.dart';

@immutable
sealed class ProviderKycState {}

final class ProviderKycInitial extends ProviderKycState {}

final class ProviderPersonalInfoKYCSentLoading extends ProviderKycState {}

final class ProviderPersonalInfoKYCSentSuccess extends ProviderKycState {}

final class ProviderPersonalInfoKYCSentError extends ProviderKycState {
  final String errorMessage;
  ProviderPersonalInfoKYCSentError({required this.errorMessage});
}

final class ProviderBusinessInfoKYCSentLoading extends ProviderKycState {}

final class ProviderBusinessInfoKYCSentSuccess extends ProviderKycState {}

final class ProviderBusinessInfoKYCSentError extends ProviderKycState {
  final String errorMessage;
  ProviderBusinessInfoKYCSentError({required this.errorMessage});
}

final class ProviderAccountKYCSentLoading extends ProviderKycState {}

final class ProviderAccountKYCSentSuccess extends ProviderKycState {}

final class ProviderAccountKYCSentError extends ProviderKycState {
  final String errorMessage;
  ProviderAccountKYCSentError({required this.errorMessage});
}

final class ProviderOTPKYCSentLoading extends ProviderKycState {}

final class ProviderOTPKYCSentSuccess extends ProviderKycState {}

final class ProviderOTPKYCSentError extends ProviderKycState {
  final String errorMessage;
  ProviderOTPKYCSentError({required this.errorMessage});
}

final class ProviderImagesKYCSentLoading extends ProviderKycState {}

final class ProviderImagesKYCSentSuccess extends ProviderKycState {}

final class ProviderImagesKYCSentError extends ProviderKycState {
  final String errorMessage;
  ProviderImagesKYCSentError({required this.errorMessage});
}

final class ProviderRegionsKYCFetchedLoading extends ProviderKycState {}

final class ProviderRegionsKYCFetchedSuccess extends ProviderKycState {
  final List<RegionModel> regions;
  ProviderRegionsKYCFetchedSuccess({required this.regions});
}

final class ProviderRegionsKYCFetchedError extends ProviderKycState {
  final String errorMessage;
  ProviderRegionsKYCFetchedError({required this.errorMessage});
}

final class ProviderZonesKYCFetchedLoading extends ProviderKycState {}

final class ProviderZonesKYCFetchedSuccess extends ProviderKycState {
  final List<ZoneModel> zones;
  ProviderZonesKYCFetchedSuccess({required this.zones});
}

final class ProviderZonesKYCFetchedError extends ProviderKycState {
  final String errorMessage;
  ProviderZonesKYCFetchedError({required this.errorMessage});
}
