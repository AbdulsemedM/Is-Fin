import 'package:ifb_loan/configuration/api_constants.dart';
import 'package:ifb_loan/features/KYC/models/business_info/business_info_model.dart';
import 'package:ifb_loan/features/KYC/models/image_models/images_model.dart';
import 'package:ifb_loan/features/KYC/models/personal_info/personal_info_model.dart';
import 'package:ifb_loan/providers/provider_setup.dart';

class KycDataProvider {
  Future<String> sendPersonalKYC(PersonalInfoModel personalInfo) async {
    try {
      final body = {
        "firstName": personalInfo.firstName,
        "lastName": personalInfo.lastName,
        "middleName": personalInfo.middleName,
        "gender": personalInfo.gender,
        "idType": personalInfo.idType,
        "idNo": personalInfo.idNo,
        "educationLevel": personalInfo.educationLevel,
        "meritalStatus": personalInfo.meritalStatus,
        "dateOfBirth": personalInfo.dateOfBirth,
        if (personalInfo.meritalStatus == "Married")
          "spouseInformationDto": {
            "firstName": personalInfo.spouseInformationDto!.firstName,
            "lastName": personalInfo.spouseInformationDto!.lastName,
            "phoneNumber": personalInfo.spouseInformationDto!.phoneNumber,
            "idNo": personalInfo.spouseInformationDto!.idNo
          },
        "alternativeContactPerson": {
          "contactPersonfirstName":
              personalInfo.alternativeContactPerson.contactPersonfirstName,
          "contactPersonlastName":
              personalInfo.alternativeContactPerson.contactPersonlastName,
          "contactPersonphoneNumber":
              personalInfo.alternativeContactPerson.contactPersonphoneNumber,
          "idNo": personalInfo.alternativeContactPerson.idNo
        },
        "residentialInfoDto": {
          "region": personalInfo.residentialInfoDto.region,
          "zone": personalInfo.residentialInfoDto.zone,
          "woreda": personalInfo.residentialInfoDto.woreda,
          "kebele": personalInfo.residentialInfoDto.kebele
        }
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest("/api/kyc/personalInfo", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendBusinessKYC(BusinessInfoModel businessInfo) async {
    try {
      final body = {
        "businessName": businessInfo.businessName,
        if (businessInfo.websiteUrl != null)
          "websiteUrl": businessInfo.websiteUrl,
        "tinNumber": businessInfo.tinNumber,
        "yearOfEstablishment": businessInfo.yearOfEstablishment,
        "ownership": businessInfo.ownership,
        "businessType": businessInfo.businessType,
        "financeSource": businessInfo.financeSource,
        "startingCapital": businessInfo.startingCapital,
        "currentCapital": businessInfo.currentCapital,
        "startingEmployee": businessInfo.startingEmployee,
        "currentEmployee": businessInfo.currentEmployee,
        "monthlySales": businessInfo.monthlySales,
        "monthlyRevenue": businessInfo.monthlyRevenue,
        "businessAddressDto": {
          "businessAddressregion":
              businessInfo.businessAddressDto.businessAddressregion,
          "businessAdressZone":
              businessInfo.businessAddressDto.businessAdressZone,
          "businessAdressWoreda":
              businessInfo.businessAddressDto.businessAdressWoreda,
          "businessAdressKebele":
              businessInfo.businessAddressDto.businessAdressKebele
        }
      };
      print(body);
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.postRequest("/api/kyc/businessInfo", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendAccountKYC(String accountNumber) async {
    try {
      final body = {
        "accountNumber": accountNumber,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest(
          "/api/kyc/account/accountLinkReq", body);
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendOTPKYC(String otp) async {
    try {
      final body = {
        "otpNumber": otp,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest(
          "/api/kyc/account/accountLinkVerification", body);
      // print(response.body);
      return response.body;
      // return "body";
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> sendImagesKYC(ImagesModel imageInfo) async {
    try {
      final body = {
        'renewedId': imageInfo.renewedId,
        'renewedIdFileName': imageInfo.renewedIdFileName,
        'renewedTradeLicense': imageInfo.renewedTradeLicense,
        'renewedTradeLicenseFileName': imageInfo.renewedTradeLicenseFileName,
        'commercialRegistrationCertificate':
            imageInfo.commercialRegistrationCertificate,
        'commercialRegistrationCertificateFileName':
            imageInfo.commercialRegistrationCertificateFileName,
        'tinNumber': imageInfo.tinNumber,
        'tinNumberFileName': imageInfo.tinNumberFileName,
      };
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.postRequest("/api/kyc/file", body);
      // print(response.body);
      return response.body;
      // return "body";
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchPersonalKYC() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/kyc/personalInfo");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchBusinessKYC() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/kyc/businessInfo");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchImagesKYC() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/kyc/file");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchRegions() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/region");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchZones(String regionId) async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/region/$regionId");
      // print(response.body);
      return response.body;
    } catch (e) {
      // print("here is the response");
      // print(e.toString());
      throw e.toString();
    }
  }

  Future<String> fetchKYCStatus() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response = await apiProvider.getRequest("/api/kyc/status");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> fetchAccountInfo() async {
    try {
      final apiProvider = ProviderSetup.getApiProvider(ApiConstants.baseUrl);
      final response =
          await apiProvider.getRequest("/api/kyc/account/accountNumber");
      return response.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
