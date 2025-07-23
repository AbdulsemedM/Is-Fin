part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class FetchProfileLoading extends ProfileState {}

class FetchProfileSuccess extends ProfileState {
  final bool isPublic;
  FetchProfileSuccess({required this.isPublic});
}

class FetchProfileError extends ProfileState {
  final String errorMessage;
  FetchProfileError({required this.errorMessage});
}

class UpdateProfileLoading extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final String message;
  UpdateProfileSuccess({required this.message});
}

class UpdateProfileError extends ProfileState {
  final String errorMessage;
  UpdateProfileError({required this.errorMessage});
}
