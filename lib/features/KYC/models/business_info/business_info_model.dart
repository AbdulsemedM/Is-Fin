// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/features/KYC/models/business_info/business_address_model.dart';

class BusinessInfoModel {
  final String businessName;
  final String? websiteUrl;
  final String tinNumber;
  final String yearOfEstablishment;
  final String ownership;
  final String businessType;
  final String? financeSource;
  final String? startingCapital;
  final String? currentCapital;
  final String? startingEmployee;
  final String? currentEmployee;
  final String? monthlySales;
  final String? monthlyRevenue;
  final String? applicationType;
  final String? managerTinNumber;
  final BusinessAddressModel businessAddressDto;
  BusinessInfoModel({
    required this.businessName,
    this.websiteUrl,
    required this.tinNumber,
    required this.yearOfEstablishment,
    required this.ownership,
    required this.businessType,
    this.financeSource,
    this.startingCapital,
    this.currentCapital,
    this.startingEmployee,
    this.currentEmployee,
    this.monthlySales,
    this.monthlyRevenue,
    this.applicationType,
    this.managerTinNumber,
    required this.businessAddressDto,
  });

  BusinessInfoModel copyWith({
    String? businessName,
    String? websiteUrl,
    String? tinNumber,
    String? yearOfEstablishment,
    String? ownership,
    String? businessType,
    String? financeSource,
    String? startingCapital,
    String? currentCapital,
    String? startingEmployee,
    String? currentEmployee,
    String? monthlySales,
    String? monthlyRevenue,
    BusinessAddressModel? businessAddressDto,
    String? applicationType,
    String? managerTinNumber,
  }) {
    return BusinessInfoModel(
      businessName: businessName ?? this.businessName,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      tinNumber: tinNumber ?? this.tinNumber,
      yearOfEstablishment: yearOfEstablishment ?? this.yearOfEstablishment,
      ownership: ownership ?? this.ownership,
      businessType: businessType ?? this.businessType,
      financeSource: financeSource ?? this.financeSource,
      startingCapital: startingCapital ?? this.startingCapital,
      currentCapital: currentCapital ?? this.currentCapital,
      startingEmployee: startingEmployee ?? this.startingEmployee,
      currentEmployee: currentEmployee ?? this.currentEmployee,
      monthlySales: monthlySales ?? this.monthlySales,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      businessAddressDto: businessAddressDto ?? this.businessAddressDto,
      applicationType: applicationType ?? this.applicationType,
      managerTinNumber: managerTinNumber ?? this.managerTinNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'businessName': businessName,
      'websiteUrl': websiteUrl,
      'tinNumber': tinNumber,
      'yearOfEstablishment': yearOfEstablishment,
      'ownership': ownership,
      'businessType': businessType,
      'financeSource': financeSource,
      'startingCapital': startingCapital,
      'currentCapital': currentCapital,
      'startingEmployee': startingEmployee,
      'currentEmployee': currentEmployee,
      'monthlySales': monthlySales,
      'monthlyRevenue': monthlyRevenue,
      'businessAddressDto': businessAddressDto.toMap(),
      'applicationType': applicationType,
      'managerTinNumber': managerTinNumber,
    };
  }

  factory BusinessInfoModel.fromMap(Map<String, dynamic> map) {
    return BusinessInfoModel(
      businessName: map['businessName'] as String,
      websiteUrl:
          map['websiteUrl'] != null ? map['websiteUrl'] as String : null,
      tinNumber: map['tinNumber'] as String,
      yearOfEstablishment: map['yearOfEstablishment'] as String,
      ownership: map['ownership'] as String,
      businessType: map['businessType'] as String,
      financeSource: map['financeSource'] != null
          ? map['financeSource'] as String
          : null,
      startingCapital: map['startingCapital'] != null
          ? map['startingCapital'] as String
          : null,
      currentCapital: map['currentCapital'] != null
          ? map['currentCapital'] as String
          : null,
      startingEmployee: map['startingEmployee'] != null
          ? map['startingEmployee'] as String
          : null,
      currentEmployee: map['currentEmployee'] != null
          ? map['currentEmployee'] as String
          : null,
      monthlySales: map['monthlySales'] != null
          ? map['monthlySales'] as String
          : null,
      monthlyRevenue: map['monthlyRevenue'] != null
          ? map['monthlyRevenue'] as String
          : null,
      businessAddressDto: BusinessAddressModel.fromMap(
          map['businessAddressDto'] as Map<String, dynamic>),
      applicationType: map['applicationType'] != null
          ? map['applicationType'] as String
          : null,
      managerTinNumber: map['managerTinNumber'] != null
          ? map['managerTinNumber'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BusinessInfoModel.fromJson(String source) =>
      BusinessInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BusinessInfoModel(businessName: $businessName, websiteUrl: $websiteUrl, tinNumber: $tinNumber, yearOfEstablishment: $yearOfEstablishment, ownership: $ownership, businessType: $businessType, financeSource: $financeSource, startingCapital: $startingCapital, currentCapital: $currentCapital, startingEmployee: $startingEmployee, currentEmployee: $currentEmployee, monthlySales: $monthlySales, monthlyRevenue: $monthlyRevenue, businessAddressDto: $businessAddressDto)';
  }

  @override
  bool operator ==(covariant BusinessInfoModel other) {
    if (identical(this, other)) return true;

    return other.businessName == businessName &&
        other.websiteUrl == websiteUrl &&
        other.tinNumber == tinNumber &&
        other.yearOfEstablishment == yearOfEstablishment &&
        other.ownership == ownership &&
        other.businessType == businessType &&
        other.financeSource == financeSource &&
        other.startingCapital == startingCapital &&
        other.currentCapital == currentCapital &&
        other.startingEmployee == startingEmployee &&
        other.currentEmployee == currentEmployee &&
        other.monthlySales == monthlySales &&
        other.monthlyRevenue == monthlyRevenue &&
        other.businessAddressDto == businessAddressDto;
  }

  @override
  int get hashCode {
    return businessName.hashCode ^
        websiteUrl.hashCode ^
        tinNumber.hashCode ^
        yearOfEstablishment.hashCode ^
        ownership.hashCode ^
        businessType.hashCode ^
        financeSource.hashCode ^
        startingCapital.hashCode ^
        currentCapital.hashCode ^
        startingEmployee.hashCode ^
        currentEmployee.hashCode ^
        monthlySales.hashCode ^
        monthlyRevenue.hashCode ^
        businessAddressDto.hashCode;
  }
}
