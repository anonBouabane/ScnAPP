import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../apis/api_client.dart';

class BonusService {
  final ApiClient apiClient = ApiClient();

  Future<Response> getBonusReferral({required String customerPhone}) async {
    try {
      final Response response = await apiClient.get(
        AppConstants.LOTTERY_BONUS_POINT_REFERRAL_BY_THIN,
        queryParameters: {'custPhone': customerPhone},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkRewardId({required String customerPhone}) async {
    try {
      final Response response = await apiClient.get(
        AppConstants.LOTTERY_CHECK_REWARD_ID_BY_THIN,
        queryParameters: {'custPhone': customerPhone},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
