import 'dart:convert';

import 'package:ifb_loan/features/switch_account/data/data_provider/switch_account_data_provider.dart';
import 'package:ifb_loan/features/switch_account/models/account_model.dart';

class SwitchAccountRepository{
  final SwitchAccountDataProvider switchAccountDataProvider;
  SwitchAccountRepository(this.switchAccountDataProvider);

  Future<List<AccountModel>> fetchAccounts() async {
    try {
      final response = await switchAccountDataProvider.fetchAccounts();
      final data = jsonDecode(response);
      if(data['httpStatus'] != 200){
        throw data['message'];
      }
      return (data['response'] as List)
          .map((e) => AccountModel.fromMap(e))
          .toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AccountModel> fetchActiveAccount() async {
    try {
      final response = await switchAccountDataProvider.fetchActiveAccount();
      final data = jsonDecode(response);
      if(data['httpStatus'] != 200){
        throw data['message'];
      }
      return AccountModel.fromMap(data['response']);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> switchAccount(String accountType) async {
    try {
      final response = await switchAccountDataProvider.switchAccount(accountType);
      final data = jsonDecode(response);
      if(data['httpStatus'] != 200){
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> linkAccount(String accountNumber, String accountType) async {
    try {
      final response = await switchAccountDataProvider.linkAccount(accountNumber, accountType);
      final data = jsonDecode(response);
      if(data['httpStatus'] != 200){
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}