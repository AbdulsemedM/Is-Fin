import 'package:get/get.dart';

class LocalizationString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        // English language
        'en_US': {
          "English": "English",
        },
        'am_ET': {
          "English": "አማርኛ",
        },
        'or_ET': {
          "English": "Afaan Oromoo",
        }
      };
}
