import 'package:get/get.dart';
import 'package:scn_easy/app/middlewares/pref.middleware.dart';
import 'package:scn_easy/util/app_constants.dart';

class StorageController extends GetxController {
  RxString _accessToken = ''.obs;
  String get accessToken => _accessToken.value;
  set accessToken(String newValue) {
    _accessToken.value = newValue;
  }

  // RxString _countryCode = ''.obs;
  // RxString _languageCode = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    accessToken =
        await PrefMiddleware.getStringValue(key: AppConstants.TOKEN) ?? '';
  }
  // Future<String> getAccessToken() async => await PrefMiddleware.getStringValue(key: AppConstants.TOKEN) ?? '';

  Future setAccessToken(value) async {
    await PrefMiddleware.setStringValue(key: AppConstants.TOKEN, val: value);
    accessToken = value;
  }

  Future<String> getLanguageCode() async =>
      await PrefMiddleware.getStringValue(key: AppConstants.LANGUAGE_CODE) ??
      'lo';

  Future setLanguageCode(value) async => await PrefMiddleware.setStringValue(
      key: AppConstants.LANGUAGE_CODE, val: value);

  Future<String> getCountryCode() async =>
      await PrefMiddleware.getStringValue(key: AppConstants.COUNTRY_CODE) ??
      'LA';

  Future setCountryCode(value) async => await PrefMiddleware.setStringValue(
      key: AppConstants.COUNTRY_CODE, val: value);

  Future<void> clear() async {
    await PrefMiddleware.setStringValue(key: AppConstants.TOKEN, val: '');
  }

  @override
  void onClose() {
    super.onClose();
  }
}
