// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RequestedProductsModel {
  final String id;
  final String productName;
  final String description;
  final String? productPrice;
  final double quantity;
  final String unitOfMeasurement;
  RequestedProductsModel({
    required this.id,
    required this.productName,
    required this.description,
    this.productPrice,
    required this.quantity,
    required this.unitOfMeasurement,
  });

  RequestedProductsModel copyWith({
    String? id,
    String? productName,
    String? description,
    String? productPrice,
    double? quantity,
    String? unitOfMeasurement,
  }) {
    return RequestedProductsModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      description: description ?? this.description,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      unitOfMeasurement: unitOfMeasurement ?? this.unitOfMeasurement,
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
    };
  }

  factory RequestedProductsModel.fromMap(Map<String, dynamic> map) {
    return RequestedProductsModel(
      id: map['id'].toString(),
      productName: map['productName'] as String,
      description: map['description'] as String,
      productPrice: map['productPrice']?.toString(),
      quantity: map['quantity'] as double,
      unitOfMeasurement: map['unitOfMeasurement'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestedProductsModel.fromJson(String source) =>
      RequestedProductsModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequestedProductsModel(id: $id, productName: $productName, description: $description, productPrice: $productPrice, quantity: $quantity, unitOfMeasurement: $unitOfMeasurement)';
  }

  @override
  bool operator ==(covariant RequestedProductsModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.description == description &&
        other.productPrice == productPrice &&
        other.quantity == quantity &&
        other.unitOfMeasurement == unitOfMeasurement;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        description.hashCode ^
        productPrice.hashCode ^
        quantity.hashCode ^
        unitOfMeasurement.hashCode;
  }
}
