// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ZoneModel {
  num id;
  String zoneName;
  ZoneModel({
    required this.id,
    required this.zoneName,
  });

  ZoneModel copyWith({
    num? id,
    String? zoneName,
  }) {
    return ZoneModel(
      id: id ?? this.id,
      zoneName: zoneName ?? this.zoneName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'zoneName': zoneName,
    };
  }

  factory ZoneModel.fromMap(Map<String, dynamic> map) {
    return ZoneModel(
      id: map['id'] as num,
      zoneName: map['zoneName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ZoneModel.fromJson(String source) =>
      ZoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ZoneModel(id: $id, zoneName: $zoneName)';

  @override
  bool operator ==(covariant ZoneModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.zoneName == zoneName;
  }

  @override
  int get hashCode => id.hashCode ^ zoneName.hashCode;
}
