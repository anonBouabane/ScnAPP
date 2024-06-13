import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../apis/api_client.dart';
import '../models/user_model.dart';

class UserService {
  final ApiClient apiClient = ApiClient();

  Future<Response> getUserInfo() async {
    try {
      final Response response =
          await apiClient.get(AppConstants.CUSTOMER_INFO_URI);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> updateProfile(UserProfile userInfoModel) async {
    try {
      final Response response = await apiClient.post(
        AppConstants.CUSTOMER_INFO_URI,
        data: userInfoModel.toJson(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> registerProfile(UserProfile userInfoModel) async {
    try {
      final Response response = await apiClient.put(
        AppConstants.CUSTOMER_INFO_URI,
        data: userInfoModel.toJson(),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getBankList() async {
    return await apiClient.get("${AppConstants.BANK_LIST}");
  }
}
