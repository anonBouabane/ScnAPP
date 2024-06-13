import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_client_lottery.dart';

class AuthRepo {
  final ApiClientLottery apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  Future<Response> signup({String? phone}) async {
    return await apiClient
        .lottoPost(AppConstants.REGISTER_URI, {"phone": phone});
  }

  Future<Response> login({String? phone, String? password}) async {
    return await apiClient.lottoPost(AppConstants.LOGIN_URI,
        {"phone": phone, "otp": password, "app_name": "SCN"});
  }

  Future<Response> sendSms({String? phone}) async {
    return await apiClient.lottoPost(AppConstants.SEND_OTP, {"phone": phone});
  }

  Future<Response> updateToken() async {
    String? _deviceToken;
    if (GetPlatform.isIOS && !GetPlatform.isWeb) {
      FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        _deviceToken = await _saveDeviceToken();
      }
    } else {
      _deviceToken = await _saveDeviceToken();
    }

    if (kDebugMode) {
      Logger().i("fcm device token: $_deviceToken");
    }

    if (!GetPlatform.isWeb) {
      final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
      if (apnsToken != null) {
        Logger().i('apnsToken: $apnsToken');
      }
    }

    if (!GetPlatform.isWeb) {
      FirebaseMessaging.instance.subscribeToTopic(AppConstants.TOPIC);
    }
    return await apiClient
        .lottoPost(AppConstants.TOKEN_URI, {"token": _deviceToken});
  }

  Future<String> _saveDeviceToken() async {
    String? _deviceToken = '0';
    if (!GetPlatform.isWeb) {
      try {
        _deviceToken = await FirebaseMessaging.instance.getToken();
      } catch (e) {}
    }
    return _deviceToken.toString();
  }

  // for  user token
  Future<bool> saveUserToken(String token) async {
    apiClient.token = token;
    apiClient.updateHeader(token);
    return await sharedPreferences.setString(AppConstants.TOKEN, token);
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  bool clearSharedData() {
    sharedPreferences.remove(AppConstants.TOKEN);
    sharedPreferences.remove(AppConstants.USER_NUMBER);
    sharedPreferences.remove(AppConstants.NUMBER_LIST);
    apiClient.token = "";
    apiClient.updateHeader("");
    return true;
  }

  String getUserNumber() {
    return sharedPreferences.getString(AppConstants.USER_NUMBER) ?? "";
  }

  void setUserPhone(String phone) {
    sharedPreferences.setString("phone", phone);
  }

  // String getAccessToken() {
  //   return sharedPreferences.getString(AppConstants.TOKEN) ?? '';
  // }
}
