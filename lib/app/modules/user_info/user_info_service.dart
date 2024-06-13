import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../models/user_model.dart';

class UserInfoService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadUserInfo() async {
    try {
      final Response response =
          await apiClient.get(AppConstants.CUSTOMER_INFO_URI);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateUserInfo({required UserModel userModel}) async {
    try {
      final Response response = await apiClient.put(
        AppConstants.CUSTOMER_INFO_URI,
        data: jsonEncode(userModel.toJson()),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
