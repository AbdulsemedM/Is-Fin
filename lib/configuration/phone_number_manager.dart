import 'package:shared_preferences/shared_preferences.dart';

class PhoneNumberManager {
  static const String _phoneNumberKey = 'phoneNumber';

  // Setter method to store the phone number in SharedPreferences
  Future<void> setPhoneNumber(String phoneNumber) async {
    print(phoneNumber);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_phoneNumberKey, phoneNumber);
  }

  // Getter method to retrieve the phone number from SharedPreferences
  Future<String?> getPhoneNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString(_phoneNumberKey));
    return prefs.getString(_phoneNumberKey);
  }
}
