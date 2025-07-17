import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ifb_loan/features/switch_account/data/repository/switch_account_repository.dart';
import 'package:ifb_loan/features/switch_account/models/account_model.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final SwitchAccountRepository switchAccountRepository;
  AccountBloc(this.switchAccountRepository) : super(AccountInitial()) {
    on<FetchAccountsEvent>(_onFetchAccountsEvent);
    on<FetchActiveAccountEvent>(_onFetchActiveAccountEvent);
    on<SwitchAccountEvent>(_onSwitchAccountEvent);
    on<LinkAccountEvent>(_onLinkAccountEvent);
  }

  Future<void> _onFetchAccountsEvent(
      FetchAccountsEvent event, Emitter<AccountState> emit) async {
    emit(FetchAccountsLoading());
    try {
      final accounts = await switchAccountRepository.fetchAccounts();
      emit(FetchAccountsLoaded(accounts));
    } catch (e) {
      emit(FetchAccountsError(e.toString()));
    }
  }

  Future<void> _onFetchActiveAccountEvent(
      FetchActiveAccountEvent event, Emitter<AccountState> emit) async {
    emit(FetchActiveAccountLoading());
    try {
      final activeAccount = await switchAccountRepository.fetchActiveAccount();
      emit(FetchActiveAccountLoaded(activeAccount));
    } catch (e) {
      emit(FetchActiveAccountError(e.toString()));
    }
  }
  Future<void> _onSwitchAccountEvent(SwitchAccountEvent event, Emitter<AccountState> emit) async {
    emit(SwitchAccountLoading());
    try {
      final account = await switchAccountRepository.switchAccount(event.accountId);
      emit(SwitchAccountLoaded(account));
    } catch (e) {
      emit(SwitchAccountError(e.toString()));
    }
  }
  Future<void> _onLinkAccountEvent(LinkAccountEvent event, Emitter<AccountState> emit) async {
    emit(LinkAccountLoading());
    try {
      final account = await switchAccountRepository.linkAccount(event.accountId);
      emit(LinkAccountLoaded(account));
    } catch (e) {
      emit(LinkAccountError(e.toString()));
    }
  }
}
