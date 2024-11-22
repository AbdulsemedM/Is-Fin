// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class RegionModel {
  num id;
  String regionName;
  RegionModel({
    required this.id,
    required this.regionName,
  });

  RegionModel copyWith({
    num? id,
    String? regionName,
  }) {
    return RegionModel(
      id: id ?? this.id,
      regionName: regionName ?? this.regionName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'regionName': regionName,
    };
  }

  factory RegionModel.fromMap(Map<String, dynamic> map) {
    return RegionModel(
      id: map['id'] as num,
      regionName: map['regionName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory RegionModel.fromJson(String source) =>
      RegionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'RegionModel(id: $id, regionName: $regionName)';

  @override
  bool operator ==(covariant RegionModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.regionName == regionName;
  }

  @override
  int get hashCode => id.hashCode ^ regionName.hashCode;
}
