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

final class KycBusinessSentLoading extends KycState {}

final class KycBusinessSentSuccess extends KycState {}

final class KycBusinessSentFailure extends KycState {
  final String errorMessage;

  KycBusinessSentFailure(this.errorMessage);
}

final class KycImagesSentLoading extends KycState {}

final class KycImagesSentSuccess extends KycState {}

final class KycImagesSentFailure extends KycState {
  final String errorMessage;

  KycImagesSentFailure(this.errorMessage);
}
