import 'dart:convert';

import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:ifb_loan/features/provider_KYC/data/data_provider/provider_KYC_data_provider.dart';

class ProviderKYCRepository {
  final ProviderKycDataProvider providerKycDataProvider;
  ProviderKYCRepository(this.providerKycDataProvider);
  PhoneNumberManager phoneManager = PhoneNumberManager();
  Future<String> sendPersonalKYC(
      PersonalInfoModel personalInfo, String phoneNumber) async {
    try {
      // print("here we gooooo");
      final kycData = await providerKycDataProvider.sendPersonalKYC(
          personalInfo, phoneNumber);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendBusinessKYC(
      BusinessInfoModel businessInfo, String phoneNumber) async {
    try {
      // print("here we gooooo");
      final kycData = await providerKycDataProvider.sendBusinessKYC(
          businessInfo, phoneNumber);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendAccountKYC(
      String accountNumber, String phoneNumber) async {
    try {
      // print("here we gooooo");
      final accountData = await providerKycDataProvider.sendAccountKYC(
          accountNumber, phoneNumber);

      final data = jsonDecode(accountData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      // print(data['message']);
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendOTPKYC(String otp, String phoneNumber) async {
    try {
      // print("here we gooooo");
      final response =
          await providerKycDataProvider.sendOTPKYC(otp, phoneNumber);

      final data = jsonDecode(response);
      if (data['httpStatus'] != 201) {
        // Log the message if needed

        // Throw only the message part
        throw data['message'];
      }
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendImagesKYC(
      ImagesModel imagesInfo, String phoneNumber) async {
    try {
      final kycData =
          await providerKycDataProvider.sendImagesKYC(imagesInfo, phoneNumber);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }

      return data['message'];
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<List<RegionModel>> fetchRegionsKYC() async {
    try {
      // print("here we gooooo");
      final kycData = await providerKycDataProvider.fetchRegions();

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      final regions = (data['response'] as List)
          .map((regionMap) => RegionModel.fromMap(regionMap))
          .toList();
      return regions;
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<List<ZoneModel>> fetchZoneKYC(String regionId) async {
    try {
      // print("here we gooooo");
      final kycData = await providerKycDataProvider.fetchZones(regionId);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        throw data['message'];
      }
      final zones = (data['response'] as List)
          .map((zoneMap) => ZoneModel.fromMap(zoneMap))
          .toList();
      // print("herearethezones");
      // print(zones.length);
      return zones;
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }
}
