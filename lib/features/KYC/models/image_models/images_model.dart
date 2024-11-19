// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ImagesModel {
  final String? renewedId;
  final String? renewedIdFileName;
  final String? renewedTradeLicense;
  final String? renewedTradeLicenseFileName;
  final String? commercialRegistrationCertificate;
  final String? commercialRegistrationCertificateFileName;
  final String? tinNumber;
  final String? tinNumberFileName;
  ImagesModel({
    this.renewedId,
    this.renewedIdFileName,
    this.renewedTradeLicense,
    this.renewedTradeLicenseFileName,
    this.commercialRegistrationCertificate,
    this.commercialRegistrationCertificateFileName,
    this.tinNumber,
    this.tinNumberFileName,
  });

  ImagesModel copyWith({
    String? renewedId,
    String? renewedIdFileName,
    String? renewedTradeLicense,
    String? renewedTradeLicenseFileName,
    String? commercialRegistrationCertificate,
    String? commercialRegistrationCertificateFileName,
    String? tinNumber,
    String? tinNumberFileName,
  }) {
    return ImagesModel(
      renewedId: renewedId ?? this.renewedId,
      renewedIdFileName: renewedIdFileName ?? this.renewedIdFileName,
      renewedTradeLicense: renewedTradeLicense ?? this.renewedTradeLicense,
      renewedTradeLicenseFileName:
          renewedTradeLicenseFileName ?? this.renewedTradeLicenseFileName,
      commercialRegistrationCertificate: commercialRegistrationCertificate ??
          this.commercialRegistrationCertificate,
      commercialRegistrationCertificateFileName:
          commercialRegistrationCertificateFileName ??
              this.commercialRegistrationCertificateFileName,
      tinNumber: tinNumber ?? this.tinNumber,
      tinNumberFileName: tinNumberFileName ?? this.tinNumberFileName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'renewedId': renewedId,
      'renewedIdFileName': renewedIdFileName,
      'renewedTradeLicense': renewedTradeLicense,
      'renewedTradeLicenseFileName': renewedTradeLicenseFileName,
      'commercialRegistrationCertificate': commercialRegistrationCertificate,
      'commercialRegistrationCertificateFileName':
          commercialRegistrationCertificateFileName,
      'tinNumber': tinNumber,
      'tinNumberFileName': tinNumberFileName,
    };
  }

  factory ImagesModel.fromMap(Map<String, dynamic> map) {
    return ImagesModel(
      renewedId: map['renewedId'] != null ? map['renewedId'] as String : null,
      renewedIdFileName: map['renewedIdFileName'] != null
          ? map['renewedIdFileName'] as String
          : null,
      renewedTradeLicense: map['renewedTradeLicense'] != null
          ? map['renewedTradeLicense'] as String
          : null,
      renewedTradeLicenseFileName: map['renewedTradeLicenseFileName'] != null
          ? map['renewedTradeLicenseFileName'] as String
          : null,
      commercialRegistrationCertificate:
          map['commercialRegistrationCertificate'] != null
              ? map['commercialRegistrationCertificate'] as String
              : null,
      commercialRegistrationCertificateFileName:
          map['commercialRegistrationCertificateFileName'] != null
              ? map['commercialRegistrationCertificateFileName'] as String
              : null,
      tinNumber: map['tinNumber'] != null ? map['tinNumber'] as String : null,
      tinNumberFileName: map['tinNumberFileName'] != null
          ? map['tinNumberFileName'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesModel.fromJson(String source) =>
      ImagesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ImagesModel(renewedId: $renewedId, renewedIdFileName: $renewedIdFileName, renewedTradeLicense: $renewedTradeLicense, renewedTradeLicenseFileName: $renewedTradeLicenseFileName, commercialRegistrationCertificate: $commercialRegistrationCertificate, commercialRegistrationCertificateFileName: $commercialRegistrationCertificateFileName, tinNumber: $tinNumber, tinNumberFileName: $tinNumberFileName)';
  }

  @override
  bool operator ==(covariant ImagesModel other) {
    if (identical(this, other)) return true;

    return other.renewedId == renewedId &&
        other.renewedIdFileName == renewedIdFileName &&
        other.renewedTradeLicense == renewedTradeLicense &&
        other.renewedTradeLicenseFileName == renewedTradeLicenseFileName &&
        other.commercialRegistrationCertificate ==
            commercialRegistrationCertificate &&
        other.commercialRegistrationCertificateFileName ==
            commercialRegistrationCertificateFileName &&
        other.tinNumber == tinNumber &&
        other.tinNumberFileName == tinNumberFileName;
  }

  @override
  int get hashCode {
    return renewedId.hashCode ^
        renewedIdFileName.hashCode ^
        renewedTradeLicense.hashCode ^
        renewedTradeLicenseFileName.hashCode ^
        commercialRegistrationCertificate.hashCode ^
        commercialRegistrationCertificateFileName.hashCode ^
        tinNumber.hashCode ^
        tinNumberFileName.hashCode;
  }
}
