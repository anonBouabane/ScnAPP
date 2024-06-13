import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/contact_us/contact_us_service.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_controller.dart';
import 'package:scn_easy/app/modules/lottery_history/lottery_history_controller.dart';
import 'package:scn_easy/app/modules/lottery_history/result/lottery_result_history_controller.dart';
import 'package:scn_easy/app/modules/lottery_history/reward/lottery_reward_controller.dart';
import 'package:scn_easy/app/modules/notification/notification_controller.dart';
import 'package:scn_easy/app/modules/profile/profile_controller.dart';
import 'package:scn_easy/app/modules/profile/profile_service.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/controller/localization_controller.dart';
import 'package:scn_easy/controller/lottery_controller.dart';
import 'package:scn_easy/controller/splash_controller.dart';
import 'package:scn_easy/controller/theme_controller.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/data/api/api_client_lottery.dart';
import 'package:scn_easy/data/model/response/language_model.dart';
import 'package:scn_easy/data/repository/auth_repo.dart';
import 'package:scn_easy/data/repository/language_repo.dart';
import 'package:scn_easy/data/repository/lottery_repo.dart';
import 'package:scn_easy/data/repository/splash_repo.dart';
import 'package:scn_easy/data/repository/user_repo.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClientLottery(
      appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(
      () => SplashRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => LanguageRepo());

  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => LotteryRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));
  Get.lazyPut(() => LocalizationController(
      sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LotteryController(lotteryRepo: Get.find()));

  // added by thin
  Get.lazyPut(() => LotteryRewardController());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => LotteryHistoryController());
  Get.lazyPut(() => LotteryInvoiceHistoryController());
  Get.lazyPut(() => LotteryResultHistoryController());
  Get.lazyPut(() => ContactUsService());
  Get.lazyPut(() => ProfileController());
  Get.lazyPut(() => ProfileService());

  // Retrieving localized data
  Map<String, Map<String, String>> _languages = Map();
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> _mappedJson = json.decode(jsonStringValues);
    Map<String, String> _json = Map();
    _mappedJson.forEach((key, value) {
      _json[key] = value.toString();
    });
    _languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        _json;
  }
  return _languages;
}
