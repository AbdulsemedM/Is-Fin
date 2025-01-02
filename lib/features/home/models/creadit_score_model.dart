// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CreditScoreModel {
  final double overallScore;
  final String remark;
  final double amountAllowed;
  CreditScoreModel({
    required this.overallScore,
    required this.remark,
    required this.amountAllowed,
  });

  CreditScoreModel copyWith({
    double? overallScore,
    String? remark,
    double? amountAllowed,
  }) {
    return CreditScoreModel(
      overallScore: overallScore ?? this.overallScore,
      remark: remark ?? this.remark,
      amountAllowed: amountAllowed ?? this.amountAllowed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'overallScore': overallScore,
      'remark': remark,
      'amountAllowed': amountAllowed,
    };
  }

  factory CreditScoreModel.fromMap(Map<String, dynamic> map) {
    return CreditScoreModel(
      overallScore: (map['overallScore'] is int)
          ? (map['overallScore'] as int).toDouble()
          : map['overallScore'] as double,
      remark: map['remark'] as String,
      amountAllowed: (map['amountAllowed'] is int)
          ? (map['amountAllowed'] as int).toDouble()
          : map['amountAllowed'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditScoreModel.fromJson(String source) =>
      CreditScoreModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CreditScoreModel(overallScore: $overallScore, remark: $remark, amountAllowed: $amountAllowed)';

  @override
  bool operator ==(covariant CreditScoreModel other) {
    if (identical(this, other)) return true;

    return other.overallScore == overallScore &&
        other.remark == remark &&
        other.amountAllowed == amountAllowed;
  }

  @override
  int get hashCode =>
      overallScore.hashCode ^ remark.hashCode ^ amountAllowed.hashCode;
}
