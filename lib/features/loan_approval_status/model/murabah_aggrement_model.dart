// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MurabahaAgreementModel {
  final String originalPrice;
  final String markUp;
  final String repaymentPlan;
  final String supplierName;
  MurabahaAgreementModel({
    required this.originalPrice,
    required this.markUp,
    required this.repaymentPlan,
    required this.supplierName,
  });

  MurabahaAgreementModel copyWith({
    String? originalPrice,
    String? markUp,
    String? repaymentPlan,
    String? supplierName,
  }) {
    return MurabahaAgreementModel(
      originalPrice: originalPrice ?? this.originalPrice,
      markUp: markUp ?? this.markUp,
      repaymentPlan: repaymentPlan ?? this.repaymentPlan,
      supplierName: supplierName ?? this.supplierName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'originalPrice': originalPrice,
      'markUp': markUp,
      'repaymentPlan': repaymentPlan,
      'supplierName': supplierName,
    };
  }

  factory MurabahaAgreementModel.fromMap(Map<String, dynamic> map) {
    return MurabahaAgreementModel(
      originalPrice: map['originalPrice'] as String,
      markUp: map['markUp'] as String,
      repaymentPlan: map['repaymentPlan'] as String,
      supplierName: map['supplierName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MurabahaAgreementModel.fromJson(String source) =>
      MurabahaAgreementModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MurabahaAgreementModel(originalPrice: $originalPrice, markUp: $markUp, repaymentPlan: $repaymentPlan, supplierName: $supplierName)';

  @override
  bool operator ==(covariant MurabahaAgreementModel other) {
    if (identical(this, other)) return true;

    return other.originalPrice == originalPrice &&
        other.markUp == markUp &&
        other.repaymentPlan == repaymentPlan &&
        other.supplierName == supplierName;
  }

  @override
  int get hashCode =>
      originalPrice.hashCode ^
      markUp.hashCode ^
      repaymentPlan.hashCode ^
      supplierName.hashCode;
}
