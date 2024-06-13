import 'package:get/get.dart';

import 'en_language.dart';
import 'la_language.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': EnLanguage().enLanguage,
        'lo_LA': LaLanguage().laLanguage,
      };
}
