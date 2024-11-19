part of 'kyc_bloc.dart';

@immutable
sealed class KycEvent {}

class PersonalKYCSent extends KycEvent {
  final PersonalInfoModel personalinfo;

  PersonalKYCSent({required this.personalinfo});
}

class BusinessKYCSent extends KycEvent {
  final BusinessInfoModel businessInfo;

  BusinessKYCSent({required this.businessInfo});
}

class ImagesKYCSent extends KycEvent {
  final ImagesModel imagesInfo;

  ImagesKYCSent({required this.imagesInfo});
}
