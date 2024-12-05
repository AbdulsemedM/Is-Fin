// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ActiveLoanModel {
  final String id;
  final String name;
  final String sector;
  final String productQuantity;
  final String totalPayableAmount;
  ActiveLoanModel({
    required this.id,
    required this.name,
    required this.sector,
    required this.productQuantity,
    required this.totalPayableAmount,
  });

  ActiveLoanModel copyWith({
    String? id,
    String? name,
    String? sector,
    String? productQuantity,
    String? totalPayableAmount,
  }) {
    return ActiveLoanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      sector: sector ?? this.sector,
      productQuantity: productQuantity ?? this.productQuantity,
      totalPayableAmount: totalPayableAmount ?? this.totalPayableAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sector': sector,
      'productQuantity': productQuantity,
      'totalPayableAmount': totalPayableAmount,
    };
  }

  factory ActiveLoanModel.fromMap(Map<String, dynamic> map) {
    return ActiveLoanModel(
      id: map['id'] as String,
      name: map['name'] as String,
      sector: map['sector'] as String,
      productQuantity: map['productQuantity'] as String,
      totalPayableAmount: map['totalPayableAmount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActiveLoanModel.fromJson(String source) =>
      ActiveLoanModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ActiveLoanModel(id: $id, name: $name, sector: $sector, productQuantity: $productQuantity, totalPayableAmount: $totalPayableAmount)';
  }

  @override
  bool operator ==(covariant ActiveLoanModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.sector == sector &&
        other.productQuantity == productQuantity &&
        other.totalPayableAmount == totalPayableAmount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        sector.hashCode ^
        productQuantity.hashCode ^
        totalPayableAmount.hashCode;
  }
}
