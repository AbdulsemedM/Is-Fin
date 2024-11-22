part of 'kyc_bloc.dart';

@immutable
sealed class KycState {}

final class KycInitial extends KycState {}

final class KycPersonalSentLoading extends KycState {}

final class KycPersonalSentSuccess extends KycState {}

final class KycPersonalSentFailure extends KycState {
  final String errorMessage;

  KycPersonalSentFailure(this.errorMessage);
}

final class KycPersonalFetchedLoading extends KycState {}

final class KycPersonalFetchedSuccess extends KycState {
  final PersonalInfoModel personalInfo;

  KycPersonalFetchedSuccess({required this.personalInfo});
}

final class KycPersonalFetchedFailure extends KycState {
  final String errorMessage;

  KycPersonalFetchedFailure(this.errorMessage);
}

////////////////////////////////////////////////////////////////////////////
final class KycBusinessSentLoading extends KycState {}

final class KycBusinessSentSuccess extends KycState {}

final class KycBusinessSentFailure extends KycState {
  final String errorMessage;

  KycBusinessSentFailure(this.errorMessage);
}

final class KycBusinessFetchedLoading extends KycState {}

final class KycBusinessFetchedSuccess extends KycState {
  final BusinessInfoModel businessInfo;

  KycBusinessFetchedSuccess({required this.businessInfo});
}

final class KycBusinessFetchedFailure extends KycState {
  final String errorMessage;

  KycBusinessFetchedFailure(this.errorMessage);
}

//////////////////////////////////////////////////////////////////////////////
final class KycImagesSentLoading extends KycState {}

final class KycImagesSentSuccess extends KycState {}

final class KycImagesSentFailure extends KycState {
  final String errorMessage;

  KycImagesSentFailure(this.errorMessage);
}

final class KycIMagesFetchedLoading extends KycState {}

final class KycIMagesFetchedSuccess extends KycState {
  final ImagesModel imagesInfo;

  KycIMagesFetchedSuccess({required this.imagesInfo});
}

final class KycIMagesFetchedFailure extends KycState {
  final String errorMessage;

  KycIMagesFetchedFailure(this.errorMessage);
}

//////////////////////////////////////////////////////////////////////////////
final class KycRegionsFetchedLoading extends KycState {}

final class KycRegionsFetchedSuccess extends KycState {
  final List<RegionModel> regionInfo;

  KycRegionsFetchedSuccess({required this.regionInfo});
}

final class KycRegionsFetchedFailure extends KycState {
  final String errorMessage;

  KycRegionsFetchedFailure(this.errorMessage);
}

final class KycZonesFetchedLoading extends KycState {}

final class KycZonesFetchedSuccess extends KycState {
  final List<ZoneModel> zoneInfo;

  KycZonesFetchedSuccess({required this.zoneInfo});
}

final class KycZonesFetchedFailure extends KycState {
  final String errorMessage;

  KycZonesFetchedFailure(this.errorMessage);
}

//////////////////////////////////////////////////////////////////////////////
final class KycAccountSentLoading extends KycState {}

final class KycAccountSentSuccess extends KycState {}

final class KycAccountSentFailure extends KycState {
  final String errorMessage;

  KycAccountSentFailure(this.errorMessage);
}

final class KycOTPSentLoading extends KycState {}

final class KycOTPSentSuccess extends KycState {}

final class KycOTPSentFailure extends KycState {
  final String errorMessage;

  KycOTPSentFailure(this.errorMessage);
}

// final class KycAccountFetchedLoading extends KycState {}

// final class KycAccountFetchedSuccess extends KycState {
//   final PersonalInfoModel personalInfo;

//   KycAccountFetchedSuccess({required this.personalInfo});
// }

// final class KycAccountFetchedFailure extends KycState {
//   final String errorMessage;

//   KycAccountFetchedFailure(this.errorMessage);
// }
