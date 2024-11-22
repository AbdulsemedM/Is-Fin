import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'providers_event.dart';
part 'providers_state.dart';

class ProvidersBloc extends Bloc<ProvidersEvent, ProvidersState> {
  ProvidersBloc() : super(ProvidersInitial()) {
    on<ProvidersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
