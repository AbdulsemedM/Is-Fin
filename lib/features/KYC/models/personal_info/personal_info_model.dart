// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/features/KYC/models/personal_info/address_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/alternative_info_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/spouse_info_model.dart';

class PersonalInfoModel {
  final String firstName;
  final String lastName;
  final String gender;
  final String idNo;
  final String idType;
  final String doB;
  final String educationLevel;
  final String meritalStatus;
  final SpouseInfoModel? spouseInformationDto;
  final ContactPersonInfoModel alternativeContactPerson;
  final AddressInfoModel residentialInfoDto;
  PersonalInfoModel({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.idNo,
    required this.idType,
    required this.doB,
    required this.educationLevel,
    required this.meritalStatus,
    this.spouseInformationDto,
    required this.alternativeContactPerson,
    required this.residentialInfoDto,
  });

  PersonalInfoModel copyWith({
    String? firstName,
    String? lastName,
    String? gender,
    String? idNo,
    String? idType,
    String? doB,
    String? educationLevel,
    String? meritalStatus,
    SpouseInfoModel? spouseInformationDto,
    ContactPersonInfoModel? alternativeContactPerson,
    AddressInfoModel? residentialInfoDto,
  }) {
    return PersonalInfoModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      idNo: idNo ?? this.idNo,
      idType: idType ?? this.idType,
      doB: doB ?? this.doB,
      educationLevel: educationLevel ?? this.educationLevel,
      meritalStatus: meritalStatus ?? this.meritalStatus,
      spouseInformationDto: spouseInformationDto ?? this.spouseInformationDto,
      alternativeContactPerson:
          alternativeContactPerson ?? this.alternativeContactPerson,
      residentialInfoDto: residentialInfoDto ?? this.residentialInfoDto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'idNo': idNo,
      'idType': idType,
      'doB': doB,
      'educationLevel': educationLevel,
      'meritalStatus': meritalStatus,
      'spouseInformationDto': spouseInformationDto?.toMap(),
      'alternativeContactPerson': alternativeContactPerson.toMap(),
      'residentialInfoDto': residentialInfoDto.toMap(),
    };
  }

  factory PersonalInfoModel.fromMap(Map<String, dynamic> map) {
    return PersonalInfoModel(
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      gender: map['gender'] as String,
      idNo: map['idNo'] as String,
      idType: map['idType'] as String,
      doB: map['doB'] as String,
      educationLevel: map['educationLevel'] as String,
      meritalStatus: map['meritalStatus'] as String,
      spouseInformationDto: map['spouseInformationDto'] != null
          ? SpouseInfoModel.fromMap(
              map['spouseInformationDto'] as Map<String, dynamic>)
          : null,
      alternativeContactPerson: ContactPersonInfoModel.fromMap(
          map['alternativeContactPerson'] as Map<String, dynamic>),
      residentialInfoDto: AddressInfoModel.fromMap(
          map['residentialInfoDto'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PersonalInfoModel.fromJson(String source) =>
      PersonalInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PersonalInfoModel(firstName: $firstName, lastName: $lastName, gender: $gender, idNo: $idNo, idType: $idType, doB: $doB, educationLevel: $educationLevel, meritalStatus: $meritalStatus, spouseInformationDto: $spouseInformationDto, alternativeContactPerson: $alternativeContactPerson, residentialInfoDto: $residentialInfoDto)';
  }

  @override
  bool operator ==(covariant PersonalInfoModel other) {
    if (identical(this, other)) return true;

    return other.firstName == firstName &&
        other.lastName == lastName &&
        other.gender == gender &&
        other.idNo == idNo &&
        other.idType == idType &&
        other.doB == doB &&
        other.educationLevel == educationLevel &&
        other.meritalStatus == meritalStatus &&
        other.spouseInformationDto == spouseInformationDto &&
        other.alternativeContactPerson == alternativeContactPerson &&
        other.residentialInfoDto == residentialInfoDto;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        gender.hashCode ^
        idNo.hashCode ^
        idType.hashCode ^
        doB.hashCode ^
        educationLevel.hashCode ^
        meritalStatus.hashCode ^
        spouseInformationDto.hashCode ^
        alternativeContactPerson.hashCode ^
        residentialInfoDto.hashCode;
  }
}
