part of 'provider_kyc_bloc.dart';

@immutable
sealed class ProviderKycEvent {}

class ProviderPersonalInfoKYCSent extends ProviderKycEvent {
  final PersonalInfoModel personalInfo;
  final String phoneNumber;

  ProviderPersonalInfoKYCSent(
      {required this.personalInfo, required this.phoneNumber});
}

class ProviderBusinessInfoKYCSent extends ProviderKycEvent {
  final BusinessInfoModel businessInfo;
  final String phoneNumber;
  ProviderBusinessInfoKYCSent(
      {required this.businessInfo, required this.phoneNumber});
}

class ProviderAccountKYCSent extends ProviderKycEvent {
  final String accountNumber;
  final String phoneNumber;
  ProviderAccountKYCSent(
      {required this.accountNumber, required this.phoneNumber});
}

class ProviderOTPKYCSent extends ProviderKycEvent {
  final String otp;
  final String phoneNumber;
  ProviderOTPKYCSent({required this.otp, required this.phoneNumber});
}

class ProviderImagesKYCSent extends ProviderKycEvent {
  final ImagesModel imagesInfo;
  final String phoneNumber;
  ProviderImagesKYCSent({required this.imagesInfo, required this.phoneNumber});
}

class ProviderRegionsKYCFetched extends ProviderKycEvent {}

class ProviderZonesKYCFetched extends ProviderKycEvent {
  final String regionId;
  ProviderZonesKYCFetched({required this.regionId});
}
  