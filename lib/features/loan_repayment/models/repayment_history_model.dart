// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RepaymentHistoryModel {
  final String id;
  final String amount;
  final String paymentDate;
  final String transactionId;
  RepaymentHistoryModel({
    required this.id,
    required this.amount,
    required this.paymentDate,
    required this.transactionId,
  });

  RepaymentHistoryModel copyWith({
    String? id,
    String? amount,
    String? paymentDate,
    String? transactionId,
  }) {
    return RepaymentHistoryModel(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      paymentDate: paymentDate ?? this.paymentDate,
      transactionId: transactionId ?? this.transactionId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'paymentDate': paymentDate,
      'transactionId': transactionId,
    };
  }

  factory RepaymentHistoryModel.fromMap(Map<String, dynamic> map) {
    return RepaymentHistoryModel(
      id: _stringFromValue(map['id']),
      amount: _stringFromValue(map['amount']),
      paymentDate: _stringFromValue(map['paymentDate']),
      transactionId: _stringFromValue(map['transactionId']),
    );
  }

  static String _stringFromValue(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String toJson() => json.encode(toMap());

  factory RepaymentHistoryModel.fromJson(String source) => RepaymentHistoryModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RepaymentHistoryModel(id: $id, amount: $amount, paymentDate: $paymentDate, transactionId: $transactionId)';
  }

  @override
  bool operator ==(covariant RepaymentHistoryModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.amount == amount &&
      other.paymentDate == paymentDate &&
      other.transactionId == transactionId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      amount.hashCode ^
      paymentDate.hashCode ^
      transactionId.hashCode;
  }
}
