// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountModel {
  final String accountNumber;
  final String accountHolderName;
  final String accountType;
  AccountModel({
    required this.accountNumber,
    required this.accountHolderName,
    required this.accountType,
  });

  AccountModel copyWith({
    String? accountNumber,
    String? accountHolderName,
    String? accountType,
  }) {
    return AccountModel(
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountType: accountType ?? this.accountType,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountNumber': accountNumber,
      'accountHolderName': accountHolderName,
      'accountType': accountType,
    };
  }

  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      accountNumber: map['accountNumber'] as String,
      accountHolderName: map['accountHolderName'] as String,
      accountType: map['accountType'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountModel.fromJson(String source) => AccountModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'AccountModel(accountNumber: $accountNumber, accountHolderName: $accountHolderName, accountType: $accountType)';

  @override
  bool operator ==(covariant AccountModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.accountNumber == accountNumber &&
      other.accountHolderName == accountHolderName &&
      other.accountType == accountType;
  }

  @override
  int get hashCode => accountNumber.hashCode ^ accountHolderName.hashCode ^ accountType.hashCode;
}
