import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/rate_provider/data/repository/rate_provider_repository.dart';

part 'rate_provider_event.dart';
part 'rate_provider_state.dart';

class RateProviderBloc extends Bloc<RateProviderEvent, RateProviderState> {
  final RateProviderRepository rateProviderRepository;
  RateProviderBloc(this.rateProviderRepository) : super(RateProviderInitial()) {
    on<RateProviderRate>((event, emit) async {
      try {
        emit(RateProviderLoading());
        final response = await rateProviderRepository.rateProvider(
            event.supplierId, event.rating, event.comment);
        emit(RateProviderSuccess(response));
      } catch (e) {
        emit(RateProviderError(e.toString()));
      }
    });
  }
}
