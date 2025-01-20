part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {}

final class DashboardSuccess extends DashboardState {
  final String message;

  DashboardSuccess(this.message);
}

final class DashboardFailure extends DashboardState {
  final String message;

  DashboardFailure(this.message);
}
