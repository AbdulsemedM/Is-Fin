import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/business_partner/data/repository/provider_repository.dart';
part 'providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  final ProviderRepository providerRepository;
  ProvidersBloc(this.providerRepository) : super(ProviderSendInitial()) {
    on<ProviderSend>(_sendProvider);
    on<ProviderVerify>(_verifyProvider);
    on<ProviderFetch>(_fetchProvider);
  }
  void _sendProvider(ProviderSend event, Emitter<ProvidersState> emit) async {
    emit(ProviderSendLoading());
    // print("loading...");
    try {
      // final login =
      final provider = await providerRepository.sendProvider(event.phoneNumber);
      emit(ProviderSendSuccess(provider: provider));
      // print(signup);
    } catch (e) {
      emit(ProviderSendFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _verifyProvider(
      ProviderVerify event, Emitter<ProvidersState> emit) async {
    emit(ProviderVerifyLoading());
    // print("loading...");
    try {
      // final login =
      final message = await providerRepository.verifyProvider(
          event.phoneNumber, event.name);
      emit(ProviderVerifySuccess(message: message));
      // print(signup);
    } catch (e) {
      emit(ProviderVerifyFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }

  void _fetchProvider(ProviderFetch event, Emitter<ProvidersState> emit) async {
    emit(ProviderFetchLoading());
    try {
      // final login =
      final providers =
          await providerRepository.getProvider(event.isRateProvider);
      emit(ProviderFetchSuccess(providers: providers));
      // print("sent from the business page");
      // print(signup);
    } catch (e) {
      emit(ProviderFetchFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }
}
