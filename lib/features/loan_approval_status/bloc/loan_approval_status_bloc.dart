import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:ifb_loan/features/loan_approval_status/data/repository/loan_approval_status_repository.dart';
import 'package:ifb_loan/features/loan_approval_status/model/murabah_aggrement_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/offered_products_price_model.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';

part 'loan_approval_status_event.dart';
part 'loan_approval_status_state.dart';

class LoanApprovalStatusBloc
    extends Bloc<LoanApprovalStatusEvent, LoanApprovalStatusState> {
  final LoanApprovalStatusRepository loanApprovalStatusRepository;
  LoanApprovalStatusBloc(this.loanApprovalStatusRepository)
      : super(LoanApprovalStatusInitial()) {
    on<FetchLoanApprovalStatusList>(_onFetchLoanApprovalStatusList);
    on<OfferedProductsPriceFetch>(_onOfferedProductsPriceFetch);
    on<AcceptOffer>(_onAcceptOffer);
    on<FetchMurabahaAgreement>(_onFetchMurabahaAgreement);
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

  Future<void> _onOfferedProductsPriceFetch(OfferedProductsPriceFetch event,
      Emitter<LoanApprovalStatusState> emit) async {
    emit(OfferedProductsPriceFetchedLoading());
    try {
      final productList = await loanApprovalStatusRepository
          .fetchLoanApprovalStatusDetails(event.id);
      emit(OfferedProductsPriceFetchedSuccess(productList: productList));
    } catch (e) {
      emit(OfferedProductsPriceFetchedFailure(e.toString()));
    }
  }

  Future<void> _onAcceptOffer(
      AcceptOffer event, Emitter<LoanApprovalStatusState> emit) async {
    emit(AcceptOfferLoading());
    try {
      final message = await loanApprovalStatusRepository.acceptOffer(
        event.id,
        event.status,
        event.productList ?? [], // Provide empty list as default if null
      );
      emit(AcceptOfferSuccess(message));
    } catch (e) {
      emit(AcceptOfferFailure(e.toString()));
    }
  }

  Future<void> _onFetchMurabahaAgreement(FetchMurabahaAgreement event,
      Emitter<LoanApprovalStatusState> emit) async {
    emit(FetchMurabahaAgreementLoading());
    try {
      final murabahaAgreement =
          await loanApprovalStatusRepository.fetchMurabahaAgreement(event.id);
      emit(FetchMurabahaAgreementSuccess(murabahaAgreement));
    } catch (e) {
      emit(FetchMurabahaAgreementFailure(e.toString()));
    }
  }
}
