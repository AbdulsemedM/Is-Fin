// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContactPersonInfoModel {
  final String contactPersonfirstName;
  final String contactPersonlastName;
  final String contactPersonphoneNumber;
  final String idNo;
  ContactPersonInfoModel({
    required this.contactPersonfirstName,
    required this.contactPersonlastName,
    required this.contactPersonphoneNumber,
    required this.idNo,
  });

  ContactPersonInfoModel copyWith({
    String? contactPersonfirstName,
    String? contactPersonlastName,
    String? contactPersonphoneNumber,
    String? idNo,
  }) {
    return ContactPersonInfoModel(
      contactPersonfirstName:
          contactPersonfirstName ?? this.contactPersonfirstName,
      contactPersonlastName:
          contactPersonlastName ?? this.contactPersonlastName,
      contactPersonphoneNumber:
          contactPersonphoneNumber ?? this.contactPersonphoneNumber,
      idNo: idNo ?? this.idNo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'contactPersonfirstName': contactPersonfirstName,
      'contactPersonlastName': contactPersonlastName,
      'contactPersonphoneNumber': contactPersonphoneNumber,
      'idNo': idNo,
    };
  }

  factory ContactPersonInfoModel.fromMap(Map<String, dynamic> map) {
    return ContactPersonInfoModel(
      contactPersonfirstName: map['contactPersonfirstName'] as String,
      contactPersonlastName: map['contactPersonlastName'] as String,
      contactPersonphoneNumber: map['contactPersonphoneNumber'] as String,
      idNo: map['idNo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContactPersonInfoModel.fromJson(String source) =>
      ContactPersonInfoModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ContactPersonInfoModel(contactPersonfirstName: $contactPersonfirstName, contactPersonlastName: $contactPersonlastName, contactPersonphoneNumber: $contactPersonphoneNumber, idNo: $idNo)';
  }

  @override
  bool operator ==(covariant ContactPersonInfoModel other) {
    if (identical(this, other)) return true;

    return other.contactPersonfirstName == contactPersonfirstName &&
        other.contactPersonlastName == contactPersonlastName &&
        other.contactPersonphoneNumber == contactPersonphoneNumber &&
        other.idNo == idNo;
  }

  @override
  int get hashCode {
    return contactPersonfirstName.hashCode ^
        contactPersonlastName.hashCode ^
        contactPersonphoneNumber.hashCode ^
        idNo.hashCode;
  }
}
