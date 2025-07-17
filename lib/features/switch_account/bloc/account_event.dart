part of 'account_bloc.dart';

@immutable
sealed class AccountEvent {}

class FetchAccountsEvent extends AccountEvent {}

class FetchActiveAccountEvent extends AccountEvent {}

class SwitchAccountEvent extends AccountEvent {
  final String accountType;
  SwitchAccountEvent(this.accountType);
} 

class LinkAccountEvent extends AccountEvent {
  final String accountNumber;
  final String accountType;
  LinkAccountEvent(this.accountNumber, this.accountType);
}