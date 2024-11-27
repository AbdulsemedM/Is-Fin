// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ifb_loan/configuration/phone_number_manager.dart';
import 'package:ifb_loan/features/KYC/data/data_provider/KYC_data_provider.dart';
import 'package:ifb_loan/features/KYC/models/address_model/region_model.dart';
import 'package:ifb_loan/features/KYC/models/address_model/zone_model.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/kyc_status/kyc_status_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KycRepository {
  final KycDataProvider kycDataProvider;
  KycRepository(this.kycDataProvider);
  PhoneNumberManager phoneManager = PhoneNumberManager();
  Future<String> sendPersonalKYC(PersonalInfoModel personalInfo) async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.sendPersonalKYC(personalInfo);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      savePersonalInfo(personalInfo);
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<PersonalInfoModel> fetchPersonalKYC() async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.fetchPersonalKYC();
      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      print(data['response']);
      return PersonalInfoModel.fromMap(data['response']);
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendBusinessKYC(BusinessInfoModel businessInfo) async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.sendBusinessKYC(businessInfo);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      saveBusinessInfo(businessInfo);
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<BusinessInfoModel> fetchBusinessKYC() async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.fetchBusinessKYC();

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      print(data['response']);
      return BusinessInfoModel.fromMap(data['response']);
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendAccountKYC(String accountNumber) async {
    try {
      // print("here we gooooo");
      final accountData = await kycDataProvider.sendAccountKYC(accountNumber);

      final data = jsonDecode(accountData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      saveAccountInfo(accountNumber);
      print(data['message']);
      return data['message'];
    } catch (e) {
      // Print and re-throw the exception for the message only
      // print('Caught Exception: $e');
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<String> sendOTPKYC(String otp) async {
    try {
      // print("here we gooooo");
      await kycDataProvider.sendOTPKYC(otp);

      final data = jsonDecode(otp);
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

  Future<String> sendImagesKYC(ImagesModel imagesInfo) async {
    try {
      final kycData = await kycDataProvider.sendImagesKYC(imagesInfo);

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 201) {
        // Log the message if needed
        // print('Error Message: ${data['message']}');

        // Throw only the message part
        throw data['message'];
      }
      if (imagesInfo.renewedIdFileName != null) {
        saveImageInfo("renewedId");
      }
      if (imagesInfo.commercialRegistrationCertificateFileName != null) {
        saveImageInfo("commercialRegistrationCertificate");
      }
      if (imagesInfo.tinNumberFileName != null) {
        saveImageInfo("tinNumber");
      }
      if (imagesInfo.renewedTradeLicenseFileName != null) {
        saveImageInfo("renewedTradeLicense");
      }
      return data['message'];
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<ImagesModel> fetchImagesKYC() async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.fetchImagesKYC();

      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return ImagesModel.fromMap(data['response']);
    } catch (e) {
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<List<RegionModel>> fetchRegionsKYC() async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.fetchRegions();

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
      final kycData = await kycDataProvider.fetchZones(regionId);

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

  Future<KycStatusModel> fetchKYCStatus() async {
    try {
      // print("here we gooooo");
      final kycData = await kycDataProvider.fetchKYCStatus();
      final data = jsonDecode(kycData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      return KycStatusModel.fromMap(data['response']);
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<Map<String, String>> fetchAccountInfo() async {
    try {
      // print("here we gooooo");
      final accountData = await kycDataProvider.fetchAccountInfo();
      final data = jsonDecode(accountData);
      if (data['httpStatus'] != 200) {
        throw data['message'];
      }
      Map<String, String> accountInfo = {
        "accountNumber": data['response']['accountNumber'],
        "accountName": data['response']['accountHolderName']
      };
      return accountInfo;
    } catch (e) {
      // print(e.toString());
      rethrow; // This will throw only the `message` part if thrown from above
    }
  }

  Future<void> savePersonalInfo(PersonalInfoModel personalInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert to JSON and save
    String? phone = await phoneManager.getPhoneNumber();
    await prefs.setString('personal_info_$phone', personalInfo.toJson());
    print("Personal info saved successfully.");
  }

  Future<void> saveBusinessInfo(BusinessInfoModel businessInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert to JSON and save
    String? phone = await phoneManager.getPhoneNumber();
    await prefs.setString('business_info_$phone', businessInfo.toJson());
    print("Business info saved successfully.");
  }

  Future<void> saveAccountInfo(String accountNumber) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert to JSON and save
    String? phone = await phoneManager.getPhoneNumber();
    await prefs.setString('account_info_$phone', accountNumber);
    print("Account info saved successfully.");
  }

  Future<void> saveImageInfo(String imageInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Convert to JSON and save
    String? phone = await phoneManager.getPhoneNumber();
    await prefs.setString('images_info_${imageInfo}_$phone', "Done");
    print("image info saved successfully.");
  }
}
