import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
part 'loan_app_event.dart';
part 'loan_app_state.dart';

class LoanAppBloc extends Bloc<LoanAppEvent, LoanAppState> {
  LoanAppBloc() : super(LoanAppInitial()) {
    on<LoanAppEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
