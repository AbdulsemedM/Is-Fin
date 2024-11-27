import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/data/repository/provider_loan_form_repository.dart';

part 'provider_loan_form_event.dart';
part 'provider_loan_form_state.dart';

class ProviderLoanFormBloc
    extends Bloc<ProviderLoanFormEvent, ProviderLoanFormState> {
  final ProviderLoanFormRepository providerLoanFormRepository;
  ProviderLoanFormBloc(this.providerLoanFormRepository)
      : super(ProviderLoanFormInitial()) {
    on<FetchProviderLoanFormList>(_onFetchProviderLoanFormList);
  }

  Future<void> _onFetchProviderLoanFormList(FetchProviderLoanFormList event,
      Emitter<ProviderLoanFormState> emit) async {
    emit(ProviderLoanFormListFetchedLoading());
    try {
      final productList =
          await providerLoanFormRepository.fetchProviderLoanFormList();
      emit(ProviderLoanFormListFetchedSuccess(productList: productList));
    } catch (e) {
      emit(ProviderLoanFormListFetchedFailure(e.toString()));
    }
  }
}
