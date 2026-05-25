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
  final String daysLeft;
  ActiveLoanModel({
    required this.id,
    required this.name,
    required this.sector,
    required this.productQuantity,
    required this.totalPayableAmount,
    required this.penaltyAmount,
    required this.outstandingAmount,
    required this.loanStatus,
    required this.daysLeft,
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
    String? daysLeft,
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
      daysLeft: daysLeft ?? this.daysLeft,
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
      'daysLeft': daysLeft,
    };
  }

  factory ActiveLoanModel.fromMap(Map<String, dynamic> map) {
    return ActiveLoanModel(
      id: _stringFromValue(map['id']),
      name: _stringFromValue(map['name']),
      sector: _stringFromValue(map['sector']),
      productQuantity: _stringFromValue(map['productQuantity']),
      totalPayableAmount: _stringFromValue(map['totalPayableAmount']),
      penaltyAmount: _stringFromValue(map['penaltyAmount']),
      outstandingAmount: _stringFromValue(map['outstandingAmount']),
      loanStatus: _stringFromValue(map['loanStatus']),
      daysLeft: _stringFromValue(map['daysLeft']),
    );
  }

  static String _stringFromValue(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  String toJson() => json.encode(toMap());

  factory ActiveLoanModel.fromJson(String source) =>
      ActiveLoanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActiveLoanModel(id: $id, name: $name, sector: $sector, productQuantity: $productQuantity, totalPayableAmount: $totalPayableAmount, penaltyAmount: $penaltyAmount, outstandingAmount: $outstandingAmount, loanStatus: $loanStatus, daysLeft: $daysLeft)';
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
        other.loanStatus == loanStatus &&
        other.daysLeft == daysLeft;
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
        loanStatus.hashCode ^
        daysLeft.hashCode;
  }
}
