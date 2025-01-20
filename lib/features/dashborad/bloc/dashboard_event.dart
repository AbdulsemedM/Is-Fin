part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

final class SendFcmTokenEvent extends DashboardEvent {
  final String fcmToken;

  SendFcmTokenEvent(this.fcmToken);
}
