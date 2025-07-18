part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class ProfileFetch extends ProfileEvent {}

class ProfileUpdate extends ProfileEvent {
  final bool isPublic;
  ProfileUpdate({required this.isPublic});
}
