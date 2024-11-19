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
  final String financeSource;
  final String startingCapital;
  final String currentCapital;
  final String startingEmployee;
  final String currentEmployee;
  final String monthlySales;
  final String monthlyRevenue;
  final BusinessAddressModel businessAddressDto;
  BusinessInfoModel({
    required this.businessName,
    this.websiteUrl,
    required this.tinNumber,
    required this.yearOfEstablishment,
    required this.ownership,
    required this.businessType,
    required this.financeSource,
    required this.startingCapital,
    required this.currentCapital,
    required this.startingEmployee,
    required this.currentEmployee,
    required this.monthlySales,
    required this.monthlyRevenue,
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
      financeSource: map['financeSource'] as String,
      startingCapital: map['startingCapital'] as String,
      currentCapital: map['currentCapital'] as String,
      startingEmployee: map['startingEmployee'] as String,
      currentEmployee: map['currentEmployee'] as String,
      monthlySales: map['monthlySales'] as String,
      monthlyRevenue: map['monthlyRevenue'] as String,
      businessAddressDto: BusinessAddressModel.fromMap(
          map['businessAddressDto'] as Map<String, dynamic>),
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
