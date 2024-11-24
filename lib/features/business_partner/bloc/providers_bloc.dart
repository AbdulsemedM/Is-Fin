import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/business_partner/data/repository/provider_repository.dart';
part 'providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  final ProviderRepository providerRepository;
  ProvidersBloc(this.providerRepository) : super(ProviderSendInitial()) {
    on<ProviderSend>(_sendProvider);
  }
  void _sendProvider(ProviderSend event, Emitter<ProvidersState> emit) async {
    emit(ProviderSendLoading());
    // print("loading...");
    try {
      // final login =
      await providerRepository.sendProvider(event.phoneNumber);
      emit(ProviderSendSuccess());
      // print(signup);
    } catch (e) {
      emit(ProviderSendFailure(e.toString()));
      // print("failure...");
      // print(e.toString());
    }
  }
}
