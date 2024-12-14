import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:ifb_loan/features/provider_KYC/data/repository/provider_KYC_repository.dart';

part 'provider_kyc_event.dart';
part 'provider_kyc_state.dart';

class ProviderKycBloc extends Bloc<ProviderKycEvent, ProviderKycState> {
  final ProviderKYCRepository providerKYCRepository;
  ProviderKycBloc(this.providerKYCRepository) : super(ProviderKycInitial()) {
    on<ProviderPersonalInfoKYCSent>(_onPersonalInfoKYCSent);
    on<ProviderBusinessInfoKYCSent>(_onBusinessInfoKYCSent);
    on<ProviderOTPKYCSent>(_onOTPKYCSent);
    on<ProviderImagesKYCSent>(_onImagesKYCSent);
    on<ProviderRegionsKYCFetched>(_onRegionsKYCFetched);
    on<ProviderZonesKYCFetched>(_onZonesKYCFetched);
  }

  Future<void> _onPersonalInfoKYCSent(
      ProviderPersonalInfoKYCSent event, Emitter<ProviderKycState> emit) async {
    emit(ProviderPersonalInfoKYCSentLoading());
    try {
      await providerKYCRepository.sendPersonalKYC(
          event.personalInfo, event.phoneNumber);
      emit(ProviderPersonalInfoKYCSentSuccess());
    } catch (e) {
      emit(ProviderPersonalInfoKYCSentError(errorMessage: e.toString()));
    }
  }

  Future<void> _onBusinessInfoKYCSent(
      ProviderBusinessInfoKYCSent event, Emitter<ProviderKycState> emit) async {
    emit(ProviderBusinessInfoKYCSentLoading());
    try {
      await providerKYCRepository.sendBusinessKYC(
          event.businessInfo, event.phoneNumber);
      emit(ProviderBusinessInfoKYCSentSuccess());
    } catch (e) {
      emit(ProviderBusinessInfoKYCSentError(errorMessage: e.toString()));
    }
  }

  Future<void> _onOTPKYCSent(
      ProviderOTPKYCSent event, Emitter<ProviderKycState> emit) async {
    emit(ProviderOTPKYCSentLoading());
    try {
      await providerKYCRepository.sendOTPKYC(event.otp, event.phoneNumber);
      emit(ProviderOTPKYCSentSuccess());
    } catch (e) {
      emit(ProviderOTPKYCSentError(errorMessage: e.toString()));
    }
  }

  Future<void> _onImagesKYCSent(
      ProviderImagesKYCSent event, Emitter<ProviderKycState> emit) async {
    emit(ProviderImagesKYCSentLoading());
    try {
      await providerKYCRepository.sendImagesKYC(
          event.imagesInfo, event.phoneNumber);
      emit(ProviderImagesKYCSentSuccess());
    } catch (e) {
      emit(ProviderImagesKYCSentError(errorMessage: e.toString()));
    }
  }

  Future<void> _onRegionsKYCFetched(
      ProviderRegionsKYCFetched event, Emitter<ProviderKycState> emit) async {
    emit(ProviderRegionsKYCFetchedLoading());
    try {
      final regions = await providerKYCRepository.fetchRegionsKYC();
      emit(ProviderRegionsKYCFetchedSuccess(regions: regions));
    } catch (e) {
      emit(ProviderRegionsKYCFetchedError(errorMessage: e.toString()));
    }
  }

  Future<void> _onZonesKYCFetched(
      ProviderZonesKYCFetched event, Emitter<ProviderKycState> emit) async {
    emit(ProviderZonesKYCFetchedLoading());
    try {
      final zones = await providerKYCRepository.fetchZoneKYC(event.regionId);
      emit(ProviderZonesKYCFetchedSuccess(zones: zones));
    } catch (e) {
      emit(ProviderZonesKYCFetchedError(errorMessage: e.toString()));
    }
  }
}
