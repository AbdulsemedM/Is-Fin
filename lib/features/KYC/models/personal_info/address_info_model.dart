// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AddressInfoModel {
  final String region;
  final String zone;
  final String woreda;
  final String kebele;
  AddressInfoModel({
    required this.region,
    required this.zone,
    required this.woreda,
    required this.kebele,
  });

  AddressInfoModel copyWith({
    String? region,
    String? zone,
    String? woreda,
    String? kebele,
  }) {
    return AddressInfoModel(
      region: region ?? this.region,
      zone: zone ?? this.zone,
      woreda: woreda ?? this.woreda,
      kebele: kebele ?? this.kebele,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'region': region,
      'zone': zone,
      'woreda': woreda,
      'kebele': kebele,
    };
  }

  factory AddressInfoModel.fromMap(Map<String, dynamic> map) {
    return AddressInfoModel(
      region: map['region'] as String,
      zone: map['zone'] as String,
      woreda: map['woreda'] as String,
      kebele: map['kebele'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressInfoModel.fromJson(String source) =>
      AddressInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AddressInfoModel(region: $region, zone: $zone, woreda: $woreda, kebele: $kebele)';
  }

  @override
  bool operator ==(covariant AddressInfoModel other) {
    if (identical(this, other)) return true;

    return other.region == region &&
        other.zone == zone &&
        other.woreda == woreda &&
        other.kebele == kebele;
  }

  @override
  int get hashCode {
    return region.hashCode ^ zone.hashCode ^ woreda.hashCode ^ kebele.hashCode;
  }
}
