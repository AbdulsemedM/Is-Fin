// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MurabahaCardModel {
  final String purchaseCost;
  final String markUp;
  final String totalMurabahaPrice;
  final String durationofFinancing;
  final String processingFee;
  MurabahaCardModel({
    required this.purchaseCost,
    required this.markUp,
    required this.totalMurabahaPrice,
    required this.durationofFinancing,
    required this.processingFee,
  });

  MurabahaCardModel copyWith({
    String? purchaseCost,
    String? markUp,
    String? totalMurabahaPrice,
    String? durationofFinancing,
    String? processingFee,
  }) {
    return MurabahaCardModel(
      purchaseCost: purchaseCost ?? this.purchaseCost,
      markUp: markUp ?? this.markUp,
      totalMurabahaPrice: totalMurabahaPrice ?? this.totalMurabahaPrice,
      durationofFinancing: durationofFinancing ?? this.durationofFinancing,
      processingFee: processingFee ?? this.processingFee,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'purchaseCost': purchaseCost,
      'markUp': markUp,
      'totalMurabahaPrice': totalMurabahaPrice,
      'durationofFinancing': durationofFinancing,
      'processingFee': processingFee,
    };
  }

  factory MurabahaCardModel.fromMap(Map<String, dynamic> map) {
    return MurabahaCardModel(
      purchaseCost: map['purchaseCost'] as String,
      markUp: map['markUp'] as String,
      totalMurabahaPrice: map['totalMurabahaPrice'] as String,
      durationofFinancing: map['durationofFinancing'] as String,
      processingFee: map['processingFee'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MurabahaCardModel.fromJson(String source) => MurabahaCardModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MurabahaCardModel(purchaseCost: $purchaseCost, markUp: $markUp, totalMurabahaPrice: $totalMurabahaPrice, durationofFinancing: $durationofFinancing, processingFee: $processingFee)';
  }

  @override
  bool operator ==(covariant MurabahaCardModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.purchaseCost == purchaseCost &&
      other.markUp == markUp &&
      other.totalMurabahaPrice == totalMurabahaPrice &&
      other.durationofFinancing == durationofFinancing &&
      other.processingFee == processingFee;
  }

  @override
  int get hashCode {
    return purchaseCost.hashCode ^
      markUp.hashCode ^
      totalMurabahaPrice.hashCode ^
      durationofFinancing.hashCode ^
      processingFee.hashCode;
  }
}
