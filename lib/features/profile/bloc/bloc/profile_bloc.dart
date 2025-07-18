
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/profile/data/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<ProfileFetch>((event, emit) async {
      emit(FetchProfileLoading());
      final response = await profileRepository.getProfile();
      emit(FetchProfileSuccess(isPublic: response));
    });
    on<ProfileUpdate>((event, emit) async {
      emit(UpdateProfileLoading());
      final response = await profileRepository.updateProfile(event.isPublic);
      emit(UpdateProfileSuccess(isPublic: response));
    });
    }
}
