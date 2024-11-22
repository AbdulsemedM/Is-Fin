part of 'kyc_bloc.dart';

@immutable
sealed class KycEvent {}

class PersonalKYCSent extends KycEvent {
  final PersonalInfoModel personalinfo;

  PersonalKYCSent({required this.personalinfo});
}

class PersonalKYCFetched extends KycEvent {
  PersonalKYCFetched();
}

class BusinessKYCSent extends KycEvent {
  final BusinessInfoModel businessInfo;

  BusinessKYCSent({required this.businessInfo});
}

class BusinessKYCFetched extends KycEvent {
  BusinessKYCFetched();
}

class AccountKYCSent extends KycEvent {
  final String accountNumber;

  AccountKYCSent({required this.accountNumber});
}

class OTPKYCSent extends KycEvent {
  final String otpNumber;

  OTPKYCSent({required this.otpNumber});
}

class ImagesKYCSent extends KycEvent {
  final ImagesModel imagesInfo;

  ImagesKYCSent({required this.imagesInfo});
}

class ImagesKYCFetched extends KycEvent {
  ImagesKYCFetched();
}

class RegionsKYCFetched extends KycEvent {
  RegionsKYCFetched();
}

class ZonesKYCFetched extends KycEvent {
  final String regionId;
  ZonesKYCFetched({required this.regionId});
}

class KYCStatusFetched extends KycEvent {
  KYCStatusFetched();
}
