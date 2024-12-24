// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActiveLoanModel {
  final String id;
  final String name;
  final String sector;
  final String productQuantity;
  final String totalPayableAmount;
  final String penaltyAmount;
  final String outstandingAmount;
  final String loanStatus;
  ActiveLoanModel({
    required this.id,
    required this.name,
    required this.sector,
    required this.productQuantity,
    required this.totalPayableAmount,
    required this.penaltyAmount,
    required this.outstandingAmount,
    required this.loanStatus,
  });

  ActiveLoanModel copyWith({
    String? id,
    String? name,
    String? sector,
    String? productQuantity,
    String? totalPayableAmount,
    String? penaltyAmount,
    String? outstandingAmount,
    String? loanStatus,
  }) {
    return ActiveLoanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sector: sector ?? this.sector,
      productQuantity: productQuantity ?? this.productQuantity,
      totalPayableAmount: totalPayableAmount ?? this.totalPayableAmount,
      penaltyAmount: penaltyAmount ?? this.penaltyAmount,
      outstandingAmount: outstandingAmount ?? this.outstandingAmount,
      loanStatus: loanStatus ?? this.loanStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sector': sector,
      'productQuantity': productQuantity,
      'totalPayableAmount': totalPayableAmount,
      'penaltyAmount': penaltyAmount,
      'outstandingAmount': outstandingAmount,
      'loanStatus': loanStatus,
    };
  }

  factory ActiveLoanModel.fromMap(Map<String, dynamic> map) {
    return ActiveLoanModel(
      id: map['id'] as String,
      name: map['name'] as String,
      sector: map['sector'] as String,
      productQuantity: map['productQuantity'] as String,
      totalPayableAmount: map['totalPayableAmount'] as String,
      penaltyAmount: map['penaltyAmount'] as String,
      outstandingAmount: map['outstandingAmount'] as String,
      loanStatus: map['loanStatus'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveLoanModel.fromJson(String source) =>
      ActiveLoanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActiveLoanModel(id: $id, name: $name, sector: $sector, productQuantity: $productQuantity, totalPayableAmount: $totalPayableAmount, penaltyAmount: $penaltyAmount, outstandingAmount: $outstandingAmount, loanStatus: $loanStatus)';
  }

  @override
  bool operator ==(covariant ActiveLoanModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.sector == sector &&
        other.productQuantity == productQuantity &&
        other.totalPayableAmount == totalPayableAmount &&
        other.penaltyAmount == penaltyAmount &&
        other.outstandingAmount == outstandingAmount &&
        other.loanStatus == loanStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        sector.hashCode ^
        productQuantity.hashCode ^
        totalPayableAmount.hashCode ^
        penaltyAmount.hashCode ^
        outstandingAmount.hashCode ^
        loanStatus.hashCode;
  }
}
