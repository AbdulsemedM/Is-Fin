import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberManager {
  static const String _phoneNumberKey = 'phoneNumber';

  // Setter method to store the phone number in SharedPreferences
  Future<void> setPhoneNumber(String phoneNumber) async {
    // print(phoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phoneNumber);
  }

  // Getter method to retrieve the phone number from SharedPreferences
  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString(_phoneNumberKey));
    return prefs.getString(_phoneNumberKey);
  }
}

class LanguageManager {
  static const String _languageKey = 'language';

  // Setter method to store the phone number in SharedPreferences
  Future<void> setLanguage(String lang) async {
    // print(lang);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageKey, lang);
  }

  // Getter method to retrieve the phone number from SharedPreferences
  Future<String?> getLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // print(prefs.getString(_languageKey));
    return prefs.getString(_languageKey);
  }
}

class UserManager {
  static const String _fullNameKey = 'fullName';
  static const String _kycStatusKey = 'kycStatus';

  // Setter method to store the full name in SharedPreferences
  Future<void> setFullName(String fullName) async {
    // print('Setting Full Name: $fullName');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fullNameKey, fullName);
  }

  // Getter method to retrieve the full name from SharedPreferences
  Future<String?> getFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? fullName = prefs.getString(_fullNameKey);
    // print('Retrieved Full Name: $fullName');
    return fullName;
  }

  // Setter method to store the KYC status in SharedPreferences
  Future<void> setKYCStatus(String kycStatus) async {
    // print('Setting KYC Status: $kycStatus');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kycStatusKey, kycStatus);
  }

  // Getter method to retrieve the KYC status from SharedPreferences
  Future<String?> getKYCStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? kycStatus = prefs.getString(_kycStatusKey);
    // print('Retrieved KYC Status: $kycStatus');
    return kycStatus;
  }
}
