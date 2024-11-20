import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/KYC/data/repository/KYC_repository.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final KycRepository kycRepository;
  KycBloc(this.kycRepository) : super(KycInitial()) {
    on<PersonalKYCSent>(_personalKYCSent);
    on<PersonalKYCFetched>(_personalKYCFetched);
    on<BusinessKYCSent>(_businessKYCSent);
    on<ImagesKYCSent>(_imagesKYCSent);
  }
  void _personalKYCSent(PersonalKYCSent event, Emitter<KycState> emit) async {
    emit(KycPersonalSentLoading());
    // print("loading...");
    try {
      await kycRepository.sendPersonalKYC(event.personalinfo);
      emit(KycPersonalSentSuccess());
      // print(signup);
    } catch (e) {
      emit(KycPersonalSentFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _personalKYCFetched(
      PersonalKYCFetched event, Emitter<KycState> emit) async {
    emit(KycPersonalFetchedLoading());
    // print("loading...");
    try {
      final personalInfo = await kycRepository.fetchPersonalKYC();
      emit(KycPersonalFetchedSuccess(personalInfo: personalInfo));
      // print(signup);
    } catch (e) {
      emit(KycPersonalSentFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _businessKYCSent(BusinessKYCSent event, Emitter<KycState> emit) async {
    emit(KycBusinessSentLoading());
    // print("loading...");
    try {
      print(event.businessInfo.businessName);
      await kycRepository.sendBusinessKYC(event.businessInfo);
      emit(KycBusinessSentSuccess());
      // print(signup);
    } catch (e) {
      emit(KycBusinessSentFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _imagesKYCSent(ImagesKYCSent event, Emitter<KycState> emit) async {
    emit(KycImagesSentLoading());
    // print("loading...");
    try {
      print(event.imagesInfo.renewedIdFileName);
      await kycRepository.sendImagesKYC(event.imagesInfo);
      emit(KycImagesSentSuccess());
      // print(signup);
    } catch (e) {
      emit(KycImagesSentFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }
}
