// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductsModel {
  final String productName;
  final String productDescription;
  final double productQuantity;
  final String productUnitofMeasurement;
  ProductsModel({
    required this.productName,
    required this.productDescription,
    required this.productQuantity,
    required this.productUnitofMeasurement,
  });


  ProductsModel copyWith({
    String? productName,
    String? productDescription,
    double? productQuantity,
    String? productUnitofMeasurement,
  }) {
    return ProductsModel(
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productQuantity: productQuantity ?? this.productQuantity,
      productUnitofMeasurement: productUnitofMeasurement ?? this.productUnitofMeasurement,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productDescription': productDescription,
      'productQuantity': productQuantity,
      'productUnitofMeasurement': productUnitofMeasurement,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map) {
    return ProductsModel(
      productName: map['productName'] as String,
      productDescription: map['productDescription'] as String,
      productQuantity: map['productQuantity'] as double,
      productUnitofMeasurement: map['productUnitofMeasurement'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsModel.fromJson(String source) => ProductsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductsModel(productName: $productName, productDescription: $productDescription, productQuantity: $productQuantity, productUnitofMeasurement: $productUnitofMeasurement)';
  }

  @override
  bool operator ==(covariant ProductsModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.productName == productName &&
      other.productDescription == productDescription &&
      other.productQuantity == productQuantity &&
      other.productUnitofMeasurement == productUnitofMeasurement;
  }

  @override
  int get hashCode {
    return productName.hashCode ^
      productDescription.hashCode ^
      productQuantity.hashCode ^
      productUnitofMeasurement.hashCode;
  }
}
