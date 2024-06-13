import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scn_easy/data/model/response/language_model.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../data/api/api_client_lottery.dart';

class LocalizationController extends GetxController implements GetxService {
  final SharedPreferences sharedPreferences;
  final ApiClientLottery apiClient;

  LocalizationController({required this.sharedPreferences, required this.apiClient}) {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!, AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;

  bool get isLtr => _isLtr;

  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) async {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'lo') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    apiClient.updateHeader(sharedPreferences.getString(AppConstants.TOKEN)!);
    saveLanguage(_locale);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? AppConstants.languages[0].languageCode!,
        sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? AppConstants.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'lo';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.countryCode!);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }
}
