import 'package:shared_preferences/shared_preferences.dart';

class PrefMiddleware {
  static SharedPreferences? pref;

  static Future initial() async => pref = await SharedPreferences.getInstance();

  static Future<bool?> getBoolValue({required String key}) async =>
      pref?.getBool(key);

  static Future<void> setBoolValue({
    required String key,
    required bool val,
  }) async =>
      await pref?.setBool(key, val);

  static Future<String?> getStringValue({required String key}) async =>
      pref?.getString(key);

  static Future<void> setStringValue({
    required String key,
    required String val,
  }) async =>
      await pref?.setString(key, val);

  static Future<int?> getIntValue({required String key}) async =>
      pref?.getInt(key);

  static Future<void> setIntValue({
    required String key,
    required int val,
  }) async =>
      await pref?.setInt(key, val);

  static Future<List<String>?> getStringListValue(
          {required String key}) async =>
      pref?.getStringList(key);

  static Future<void> setStringListValue({
    required String key,
    required List<String> val,
  }) async =>
      await pref?.setStringList(key, val);

  static Future<bool> containsKey({required String key}) async {
    bool result = pref?.containsKey(key) ?? false;
    return result;
  }

  static Future<void> deleteAll() async => await pref?.clear();
}
