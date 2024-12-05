import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/finances/data/repository/finances_repository.dart';
import 'package:ifb_loan/features/finances/models/active_loan_model.dart';
part 'finances_event.dart';
part 'finances_state.dart';

class FinancesBloc extends Bloc<FinancesEvent, FinancesState> {
  final FinancesRepository financesRepository;
  FinancesBloc(this.financesRepository) : super(FinancesInitial()) {
    on<FetchActiveLoans>(_onFetchActiveLoans);
  }
  Future<void> _onFetchActiveLoans(
      FetchActiveLoans event, Emitter<FinancesState> emit) async {
    emit(ActiveLoansFetchedLoading());
    try {
      final activeLoans = await financesRepository.fetchActiveLoans();
      emit(ActiveLoansFetchedSuccess(activeLoans: activeLoans));
    } catch (e) {
      emit(ActiveLoansFetchedFailure(errorMessage: e.toString()));
    }
  }
}
