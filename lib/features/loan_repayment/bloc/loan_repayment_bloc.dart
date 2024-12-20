import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/loan_repayment/data/repository/loan_repayment_repository.dart';
import 'package:ifb_loan/features/loan_repayment/models/repayment_history_model.dart';
part 'loan_repayment_event.dart';
part 'loan_repayment_state.dart';

class LoanRepaymentBloc extends Bloc<LoanRepaymentEvent, LoanRepaymentState> {
  final LoanRepaymentRepository loanRepaymentRepository;
  LoanRepaymentBloc(this.loanRepaymentRepository)
      : super(LoanRepaymentInitial()) {
    on<GetRepaymentHistoryEvent>(_onGetRepaymentHistory);
  }

  Future<void> _onGetRepaymentHistory(
      GetRepaymentHistoryEvent event, Emitter<LoanRepaymentState> emit) async {
    emit(LoanRepaymentLoading());
    try {
      final response = await loanRepaymentRepository.getRepaymentHistory();
      emit(LoanRepaymentSuccess(response));
    } catch (e) {
      emit(LoanRepaymentFailure(e.toString()));
    }
  }
}
