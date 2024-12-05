// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OfferedProductsPriceModel {
  final int id;
  final String productName;
  final String description;
  final double productPrice;
  final double quantity;
  final String unitOfMeasurement;
  final String priceExpirationDate;
  OfferedProductsPriceModel({
    required this.id,
    required this.productName,
    required this.description,
    required this.productPrice,
    required this.quantity,
    required this.unitOfMeasurement,
    required this.priceExpirationDate,
  });

  OfferedProductsPriceModel copyWith({
    int? id,
    String? productName,
    String? description,
    double? productPrice,
    double? quantity,
    String? unitOfMeasurement,
    String? priceExpirationDate,
  }) {
    return OfferedProductsPriceModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      unitOfMeasurement: unitOfMeasurement ?? this.unitOfMeasurement,
      priceExpirationDate: priceExpirationDate ?? this.priceExpirationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'description': description,
      'productPrice': productPrice,
      'quantity': quantity,
      'unitOfMeasurement': unitOfMeasurement,
      'priceExpirationDate': priceExpirationDate,
    };
  }

  factory OfferedProductsPriceModel.fromMap(Map<String, dynamic> map) {
    return OfferedProductsPriceModel(
      id: map['id'] as int,
      productName: map['productName'] as String,
      description: map['description'] as String,
      productPrice: map['productPrice'] as double,
      quantity: map['quantity'] as double,
      unitOfMeasurement: map['unitOfMeasurement'] as String,
      priceExpirationDate: map['priceExpirationDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferedProductsPriceModel.fromJson(String source) =>
      OfferedProductsPriceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OfferedProductsPriceModel(id: $id, productName: $productName, description: $description, productPrice: $productPrice, quantity: $quantity, unitOfMeasurement: $unitOfMeasurement, priceExpirationDate: $priceExpirationDate)';
  }

  @override
  bool operator ==(covariant OfferedProductsPriceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.description == description &&
        other.productPrice == productPrice &&
        other.quantity == quantity &&
        other.unitOfMeasurement == unitOfMeasurement &&
        other.priceExpirationDate == priceExpirationDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        description.hashCode ^
        productPrice.hashCode ^
        quantity.hashCode ^
        unitOfMeasurement.hashCode ^
        priceExpirationDate.hashCode;
  }
}
