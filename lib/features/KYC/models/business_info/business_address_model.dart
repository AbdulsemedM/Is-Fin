// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BusinessAddressModel {
  final String businessAddressregion;
  final String businessAdressZone;
  final String businessAdressWoreda;
  final String businessAdressKebele;
  BusinessAddressModel({
    required this.businessAddressregion,
    required this.businessAdressZone,
    required this.businessAdressWoreda,
    required this.businessAdressKebele,
  });

  BusinessAddressModel copyWith({
    String? businessAddressregion,
    String? businessAdressZone,
    String? businessAdressWoreda,
    String? businessAdressKebele,
  }) {
    return BusinessAddressModel(
      businessAddressregion:
          businessAddressregion ?? this.businessAddressregion,
      businessAdressZone: businessAdressZone ?? this.businessAdressZone,
      businessAdressWoreda: businessAdressWoreda ?? this.businessAdressWoreda,
      businessAdressKebele: businessAdressKebele ?? this.businessAdressKebele,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessAddressregion': businessAddressregion,
      'businessAdressZone': businessAdressZone,
      'businessAdressWoreda': businessAdressWoreda,
      'businessAdressKebele': businessAdressKebele,
    };
  }

  factory BusinessAddressModel.fromMap(Map<String, dynamic> map) {
    return BusinessAddressModel(
      businessAddressregion: map['businessAddressregion'] as String,
      businessAdressZone: map['businessAdressZone'] as String,
      businessAdressWoreda: map['businessAdressWoreda'] as String,
      businessAdressKebele: map['businessAdressKebele'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessAddressModel.fromJson(String source) =>
      BusinessAddressModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessAddressModel(businessAddressregion: $businessAddressregion, businessAdressZone: $businessAdressZone, businessAdressWoreda: $businessAdressWoreda, businessAdressKebele: $businessAdressKebele)';
  }

  @override
  bool operator ==(covariant BusinessAddressModel other) {
    if (identical(this, other)) return true;

    return other.businessAddressregion == businessAddressregion &&
        other.businessAdressZone == businessAdressZone &&
        other.businessAdressWoreda == businessAdressWoreda &&
        other.businessAdressKebele == businessAdressKebele;
  }

  @override
  int get hashCode {
    return businessAddressregion.hashCode ^
        businessAdressZone.hashCode ^
        businessAdressWoreda.hashCode ^
        businessAdressKebele.hashCode;
  }
}
