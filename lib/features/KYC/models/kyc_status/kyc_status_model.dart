// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class KycStatusModel {
  final String approvalStatus;
  final String? rejectReason;
  KycStatusModel({
    required this.approvalStatus,
    this.rejectReason,
  });

  KycStatusModel copyWith({
    String? approvalStatus,
    String? rejectReason,
  }) {
    return KycStatusModel(
      approvalStatus: approvalStatus ?? this.approvalStatus,
      rejectReason: rejectReason ?? this.rejectReason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'approvalStatus': approvalStatus,
      'rejectReason': rejectReason,
    };
  }

  factory KycStatusModel.fromMap(Map<String, dynamic> map) {
    return KycStatusModel(
      approvalStatus: map['approvalStatus']?.toString() ?? '',
      rejectReason: map['rejectReason']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory KycStatusModel.fromJson(String source) =>
      KycStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'KycStatusModel(approvalStatus: $approvalStatus, rejectReason: $rejectReason)';

  @override
  bool operator ==(covariant KycStatusModel other) {
    if (identical(this, other)) return true;

    return other.approvalStatus == approvalStatus &&
        other.rejectReason == rejectReason;
  }

  @override
  int get hashCode => approvalStatus.hashCode ^ rejectReason.hashCode;
}
