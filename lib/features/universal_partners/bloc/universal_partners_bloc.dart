import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'universal_partners_event.dart';
part 'universal_partners_state.dart';

class UniversalPartnersBloc extends Bloc<UniversalPartnersEvent, UniversalPartnersState> {
  UniversalPartnersBloc() : super(UniversalPartnersInitial()) {
    on<UniversalPartnersEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
