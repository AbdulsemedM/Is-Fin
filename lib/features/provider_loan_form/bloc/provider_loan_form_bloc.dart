import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/loan_approval_status/model/product_list_model.dart';
import 'package:ifb_loan/features/provider_loan_form/data/repository/provider_loan_form_repository.dart';
import 'package:ifb_loan/features/provider_loan_form/models/requested_products_model.dart';

part 'provider_loan_form_event.dart';
part 'provider_loan_form_state.dart';

class ProviderLoanFormBloc
    extends Bloc<ProviderLoanFormEvent, ProviderLoanFormState> {
  final ProviderLoanFormRepository providerLoanFormRepository;
  ProviderLoanFormBloc(this.providerLoanFormRepository)
      : super(ProviderLoanFormInitial()) {
    on<FetchProviderLoanFormList>(_onFetchProviderLoanFormList);
    on<FetchRequestedProductsById>(_onFetchRequestedProductsById);
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

  Future<void> _onFetchRequestedProductsById(FetchRequestedProductsById event,
      Emitter<ProviderLoanFormState> emit) async {
    emit(RequestedProductsFetchedLoading());
    try {
      final requestedProducts =
          await providerLoanFormRepository.fetchRequestedProductsById(event.id);
      emit(RequestedProductsFetchedSuccess(
          requestedProducts: requestedProducts));
      print('Requested Products: ${requestedProducts.length}');
    } catch (e) {
      emit(RequestedProductsFetchedFailure(e.toString()));
    }
  }

  Future<void> _onSendRequestedProductsPrice(SendRequestedProductsPrice event,
      Emitter<ProviderLoanFormState> emit) async {
    emit(RequestedProductsPriceSentLoading());
    try {
      final requestedProductsPrice =
          await providerLoanFormRepository.sendRequestedProductsPrice(
              event.products, event.id, event.expirationDate, event.status);
      emit(RequestedProductsPriceSentSuccess(requestedProductsPrice));
    } catch (e) {
      emit(RequestedProductsPriceSentFailure(e.toString()));
    }
  }
}
