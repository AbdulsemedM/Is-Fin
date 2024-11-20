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

class ImagesKYCSent extends KycEvent {
  final ImagesModel imagesInfo;

  ImagesKYCSent({required this.imagesInfo});
}
