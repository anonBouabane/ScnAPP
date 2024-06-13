import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/data/model/response/update_profile.dart';
import 'package:scn_easy/util/app_constants.dart';

class ProfileService {
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

  Future<Response> updateUserInfo({required UserProfile userProfile}) async {
    try {
      final Response response = await apiClient.put(
        AppConstants.CUSTOMER_INFO_URI,
        data: jsonEncode(userProfile.toJson()),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
