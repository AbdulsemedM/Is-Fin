// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SpouseInfoModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String idNumber;
  SpouseInfoModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.idNumber,
  });

  SpouseInfoModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? idNumber,
  }) {
    return SpouseInfoModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      idNumber: idNumber ?? this.idNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'idNumber': idNumber,
    };
  }

  factory SpouseInfoModel.fromMap(Map<String, dynamic> map) {
    return SpouseInfoModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      phoneNumber: map['phoneNumber'] as String,
      idNumber: map['idNumber'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SpouseInfoModel.fromJson(String source) =>
      SpouseInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SpouseInfoModel(firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, idNumber: $idNumber)';
  }

  @override
  bool operator ==(covariant SpouseInfoModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.idNumber == idNumber;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        idNumber.hashCode;
  }
}
