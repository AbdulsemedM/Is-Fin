import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'provider_kyc_event.dart';
part 'provider_kyc_state.dart';

class ProviderKycBloc extends Bloc<ProviderKycEvent, ProviderKycState> {
  ProviderKycBloc() : super(ProviderKycInitial()) {
    on<ProviderKycEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
