part of 'account_bloc.dart';

@immutable
sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class FetchAccountsLoading extends AccountState {}

final class FetchAccountsLoaded extends AccountState {
  final List<AccountModel> accounts;
  FetchAccountsLoaded(this.accounts);
}

final class FetchAccountsError extends AccountState {
  final String errorMessage;
  FetchAccountsError(this.errorMessage);
}

final class FetchActiveAccountLoading extends AccountState {}

final class FetchActiveAccountLoaded extends AccountState {
  final AccountModel activeAccount;
  FetchActiveAccountLoaded(this.activeAccount);
}

final class FetchActiveAccountError extends AccountState {
  final String errorMessage;
  FetchActiveAccountError(this.errorMessage);
}

final class SwitchAccountLoading extends AccountState {}

final class SwitchAccountLoaded extends AccountState {
  final String message;
  SwitchAccountLoaded(this.message);
}

final class SwitchAccountError extends AccountState {
  final String errorMessage;
  SwitchAccountError(this.errorMessage);
}

final class LinkAccountLoading extends AccountState {}

final class LinkAccountLoaded extends AccountState {
  final String message;
  LinkAccountLoaded(this.message);
}

final class LinkAccountError extends AccountState {
  final String errorMessage;
  LinkAccountError(this.errorMessage);
}