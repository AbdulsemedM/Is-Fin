// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class StatusProductListModel {
  final String buyerFullName;
  final String supplierFullName;
  final String sectorName;
  final String requestedAt;
  final double? totalAmount;
  final String repaymentCycleDuration;
  final String status;
  StatusProductListModel({
    required this.buyerFullName,
    required this.supplierFullName,
    required this.sectorName,
    required this.requestedAt,
    this.totalAmount,
    required this.repaymentCycleDuration,
    required this.status,
  });

  StatusProductListModel copyWith({
    String? buyerFullName,
    String? supplierFullName,
    String? sectorName,
    String? requestedAt,
    double? totalAmount,
    String? repaymentCycleDuration,
    String? status,
  }) {
    return StatusProductListModel(
      buyerFullName: buyerFullName ?? this.buyerFullName,
      supplierFullName: supplierFullName ?? this.supplierFullName,
      sectorName: sectorName ?? this.sectorName,
      requestedAt: requestedAt ?? this.requestedAt,
      totalAmount: totalAmount ?? this.totalAmount,
      repaymentCycleDuration:
          repaymentCycleDuration ?? this.repaymentCycleDuration,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyerFullName': buyerFullName,
      'supplierFullName': supplierFullName,
      'sectorName': sectorName,
      'requestedAt': requestedAt,
      'totalAmount': totalAmount,
      'repaymentCycleDuration': repaymentCycleDuration,
      'status': status,
    };
  }

  factory StatusProductListModel.fromMap(Map<String, dynamic> map) {
    return StatusProductListModel(
      buyerFullName: map['buyerFullName'] as String,
      supplierFullName: map['supplierFullName'] as String,
      sectorName: map['sectorName'] as String,
      requestedAt: map['requestedAt'] as String,
      totalAmount:
          map['totalAmount'] != null ? map['totalAmount'] as double : null,
      repaymentCycleDuration: map['repaymentCycleDuration'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusProductListModel.fromJson(String source) =>
      StatusProductListModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatusProductListModel(buyerFullName: $buyerFullName, supplierFullName: $supplierFullName, sectorName: $sectorName, requestedAt: $requestedAt, totalAmount: $totalAmount, repaymentCycleDuration: $repaymentCycleDuration, status: $status)';
  }

  @override
  bool operator ==(covariant StatusProductListModel other) {
    if (identical(this, other)) return true;

    return other.buyerFullName == buyerFullName &&
        other.supplierFullName == supplierFullName &&
        other.sectorName == sectorName &&
        other.requestedAt == requestedAt &&
        other.totalAmount == totalAmount &&
        other.repaymentCycleDuration == repaymentCycleDuration &&
        other.status == status;
  }

  @override
  int get hashCode {
    return buyerFullName.hashCode ^
        supplierFullName.hashCode ^
        sectorName.hashCode ^
        requestedAt.hashCode ^
        totalAmount.hashCode ^
        repaymentCycleDuration.hashCode ^
        status.hashCode;
  }
}
