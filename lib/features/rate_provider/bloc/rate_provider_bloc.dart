import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'rate_provider_event.dart';
part 'rate_provider_state.dart';

class RateProviderBloc extends Bloc<RateProviderEvent, RateProviderState> {
  RateProviderBloc() : super(RateProviderInitial()) {
    on<RateProviderEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
