// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ifb_loan/features/loan_application/models/products_model.dart';

class ProductsRequestModel {
  final List<ProductsModel> products;
  final String sector;
  final String provider;
  final String repymentPlan;
  ProductsRequestModel({
    required this.products,
    required this.sector,
    required this.provider,
    required this.repymentPlan,
  });

  ProductsRequestModel copyWith({
    List<ProductsModel>? products,
    String? sector,
    String? provider,
    String? repymentPlan,
  }) {
    return ProductsRequestModel(
      products: products ?? this.products,
      sector: sector ?? this.sector,
      provider: provider ?? this.provider,
      repymentPlan: repymentPlan ?? this.repymentPlan,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
      'sector': sector,
      'provider': provider,
      'repymentPlan': repymentPlan,
    };
  }

  factory ProductsRequestModel.fromMap(Map<String, dynamic> map) {
    return ProductsRequestModel(
      products: List<ProductsModel>.from(
        (map['products'] as List<int>).map<ProductsModel>(
          (x) => ProductsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      sector: map['sector'] as String,
      provider: map['provider'] as String,
      repymentPlan: map['repymentPlan'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductsRequestModel.fromJson(String source) =>
      ProductsRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductsRequestModel(products: $products, sector: $sector, provider: $provider, repymentPlan: $repymentPlan)';
  }

  @override
  bool operator ==(covariant ProductsRequestModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.products, products) &&
        other.sector == sector &&
        other.provider == provider &&
        other.repymentPlan == repymentPlan;
  }

  @override
  int get hashCode {
    return products.hashCode ^
        sector.hashCode ^
        provider.hashCode ^
        repymentPlan.hashCode;
  }
}
