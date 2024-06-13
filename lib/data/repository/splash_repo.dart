import 'package:shared_preferences/shared_preferences.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../api/api_client_lottery.dart';

class SplashRepo {
  ApiClientLottery apiClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.sharedPreferences, required this.apiClient});

  Future<void> initSharedData() async {
    if (!sharedPreferences.containsKey(AppConstants.THEME)) {
      sharedPreferences.setBool(AppConstants.THEME, false);
    }
    if (!sharedPreferences.containsKey(AppConstants.COUNTRY_CODE)) {
      sharedPreferences.setString(AppConstants.COUNTRY_CODE, AppConstants.languages[0].countryCode!);
    }
    if (!sharedPreferences.containsKey(AppConstants.LANGUAGE_CODE)) {
      sharedPreferences.setString(AppConstants.LANGUAGE_CODE, AppConstants.languages[0].languageCode!);
    }
  }
}
