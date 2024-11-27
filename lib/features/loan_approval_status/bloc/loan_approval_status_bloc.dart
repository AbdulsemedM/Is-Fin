import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/loan_approval_status/data/repository/loan_approval_status_repository.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';

part 'loan_approval_status_event.dart';
part 'loan_approval_status_state.dart';

class LoanApprovalStatusBloc
    extends Bloc<LoanApprovalStatusEvent, LoanApprovalStatusState> {
  final LoanApprovalStatusRepository loanApprovalStatusRepository;
  LoanApprovalStatusBloc(this.loanApprovalStatusRepository)
      : super(LoanApprovalStatusInitial()) {
    on<FetchLoanApprovalStatusList>(_onFetchLoanApprovalStatusList);
  }

  Future<void> _onFetchLoanApprovalStatusList(FetchLoanApprovalStatusList event,
      Emitter<LoanApprovalStatusState> emit) async {
    emit(LoanApprovalListFetchedLoading());
    try {
      final productList =
          await loanApprovalStatusRepository.fetchLoanApprovalStatusList();
      emit(LoanApprovalListFetchedSuccess(productList: productList));
    } catch (e) {
      emit(LoanApprovalListFetchedFailure(e.toString()));
    }
  }
}
