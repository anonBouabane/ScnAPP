import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scn_easy/util/app_constants.dart';

class StorageController extends GetxController {
  final box = GetStorage();

  String get accessToken => box.read(AppConstants.TOKEN) ?? '';
  set accessToken(String newValue) => box.write(AppConstants.TOKEN, newValue);

  String get countryCode => box.read(AppConstants.COUNTRY_CODE) ?? 'LA';
  set countryCode(String newValue) =>
      box.write(AppConstants.COUNTRY_CODE, newValue);

  String get languageCode => box.read(AppConstants.LANGUAGE_CODE) ?? 'lo';
  set languageCode(String newValue) =>
      box.write(AppConstants.LANGUAGE_CODE, newValue);

  // Future<String> getAccessToken() async =>
  //     await box.read(AppConstants.TOKEN) ?? '';
  //
  // Future setAccessToken(value) async =>
  //     await box.write(AppConstants.TOKEN, value);

  // Future<String> getCustomerPhone() async =>
  //     await box.read(AppConstants.KEY_CUSTOMER_PHONE) ?? '';
  //
  // Future setCustomerPhone(value) async =>
  //     await box.write(AppConstants.KEY_CUSTOMER_PHONE, value ?? '');

  // Future<String> getLanguageCode() async =>
  //     await box.read(AppConstants.LANGUAGE_CODE) ?? 'lo';
  // Future setLanguageCode(value) async =>
  //     await box.write(AppConstants.LANGUAGE_CODE, value);

  // Future<String> getCountryCode() async =>
  //     await box.read(AppConstants.COUNTRY_CODE) ?? 'LA';
  // Future setCountryCode(value) async =>
  //     await box.write(AppConstants.COUNTRY_CODE, value);

  Future<void> clearStorage() async {
    await box.write(AppConstants.TOKEN, '');
  }
}
