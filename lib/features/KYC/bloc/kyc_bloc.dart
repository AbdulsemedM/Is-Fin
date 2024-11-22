import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/KYC/data/repository/KYC_repository.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/kyc_status/kyc_status_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
part 'kyc_event.dart';
part 'kyc_state.dart';

class KycBloc extends Bloc<KycEvent, KycState> {
  final KycRepository kycRepository;
  KycBloc(this.kycRepository) : super(KycInitial()) {
    on<PersonalKYCSent>(_personalKYCSent);
    on<PersonalKYCFetched>(_personalKYCFetched);
    on<BusinessKYCSent>(_businessKYCSent);
    on<BusinessKYCFetched>(_businessKYCFetched);
    on<AccountKYCSent>(_accountKYCSent);
    on<OTPKYCSent>(_otpKYCSent);
    on<ImagesKYCSent>(_imagesKYCSent);
    on<ImagesKYCFetched>(_imagesKYCFetched);
    on<RegionsKYCFetched>(_regionsKYCFetched);
    on<ZonesKYCFetched>(_zonesKYCFetched);
    on<KYCStatusFetched>(_kycStatusFetched);
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

  void _businessKYCFetched(
      BusinessKYCFetched event, Emitter<KycState> emit) async {
    emit(KycBusinessFetchedLoading());
    // print("loading...");
    try {
      final businessInfo = await kycRepository.fetchBusinessKYC();
      emit(KycBusinessFetchedSuccess(businessInfo: businessInfo));
      // print(signup);
    } catch (e) {
      emit(KycBusinessFetchedFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _accountKYCSent(AccountKYCSent event, Emitter<KycState> emit) async {
    emit(KycAccountSentLoading());
    // print("loading...");
    try {
      // print(event.accountNumber);
      await kycRepository.sendAccountKYC(event.accountNumber);
      emit(KycAccountSentSuccess());
      // print(signup);
    } catch (e) {
      emit(KycAccountSentFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _otpKYCSent(OTPKYCSent event, Emitter<KycState> emit) async {
    emit(KycOTPSentLoading());
    // print("loading...");
    try {
      // print(event.accountNumber);
      await kycRepository.sendOTPKYC(event.otpNumber);
      emit(KycOTPSentSuccess());
      // print(signup);
    } catch (e) {
      emit(KycOTPSentFailure(e.toString()));
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

  void _imagesKYCFetched(ImagesKYCFetched event, Emitter<KycState> emit) async {
    emit(KycIMagesFetchedLoading());
    // print("loading...");
    try {
      final imagesInfo = await kycRepository.fetchImagesKYC();
      emit(KycIMagesFetchedSuccess(imagesInfo: imagesInfo));
      // print(signup);
    } catch (e) {
      emit(KycIMagesFetchedFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _regionsKYCFetched(
      RegionsKYCFetched event, Emitter<KycState> emit) async {
    emit(KycRegionsFetchedLoading());
    // print("loading...");
    try {
      final regionsInfo = await kycRepository.fetchRegionsKYC();
      emit(KycRegionsFetchedSuccess(regionInfo: regionsInfo));
      // print(signup);
    } catch (e) {
      emit(KycRegionsFetchedFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _zonesKYCFetched(ZonesKYCFetched event, Emitter<KycState> emit) async {
    print("event.regionId");
    print(event.regionId);
    emit(KycZonesFetchedLoading());
    try {
      final zonesInfo = await kycRepository.fetchZoneKYC(event.regionId);

      emit(KycZonesFetchedSuccess(zoneInfo: zonesInfo));
    } catch (e) {
      emit(KycZonesFetchedFailure(e.toString()));
    }
  }

  void _kycStatusFetched(KYCStatusFetched event, Emitter<KycState> emit) async {
    emit(KycStatusFetchedLoading());
    // print("loading...");
    try {
      final kycInfo = await kycRepository.fetchKYCStatus();
      print("from bloc");
      print(kycInfo.approvalStatus);
      emit(KycStatusFetchedSuccess(kycStatusInfo: kycInfo));
      // print(signup);
    } catch (e) {
      emit(KycStatusFetchedFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }
  // void _zonesKYCFetched(ZonesKYCFetched event, Emitter<KycState> emit) async {
  //   print("event.regionId");
  //   print(event.regionId);
  //   emit(KycZonesFetchedLoading());
  //   try {
  //     final zonesInfo = await kycRepository.fetchZoneKYC(event.regionId);
  //     emit(KycZonesFetchedSuccess(zoneInfo: zonesInfo));
  //     // print(signup);
  //   } catch (e) {
  //     emit(KycZonesFetchedFailure(e.toString()));
  //     // print("failure...");
  //     // print(e.toString());
  //   }
  // }
}
