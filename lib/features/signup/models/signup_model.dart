// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignupModel {
  final int id;
  final String? email;
  final String? kyc;
  final String? roleId;
  final String? fullName;
  final String? phoneNumber;
  SignupModel({
    required this.id,
    this.email,
    this.kyc,
    this.roleId,
    this.fullName,
    this.phoneNumber,
  });

  SignupModel copyWith({
    int? id,
    String? email,
    String? kyc,
    String? roleId,
    String? fullName,
    String? phoneNumber,
  }) {
    return SignupModel(
      id: id ?? this.id,
      email: email ?? this.email,
      kyc: kyc ?? this.kyc,
      roleId: roleId ?? this.roleId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'kyc': kyc,
      'roleId': roleId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
    };
  }

  factory SignupModel.fromMap(Map<String, dynamic> map) {
    return SignupModel(
      id: map['id'] as int,
      email: map['email'] != null ? map['email'] as String : null,
      kyc: map['kyc'] != null ? map['kyc'] as String : null,
      roleId: map['roleId'] != null ? map['roleId'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupModel.fromJson(String source) =>
      SignupModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SignupModel(id: $id, email: $email, kyc: $kyc, roleId: $roleId, fullName: $fullName, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(covariant SignupModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.email == email &&
        other.kyc == kyc &&
        other.roleId == roleId &&
        other.fullName == fullName &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        kyc.hashCode ^
        roleId.hashCode ^
        fullName.hashCode ^
        phoneNumber.hashCode;
  }
}
