import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../apis/api_client.dart';

class ReferralService {
  final ApiClient apiClient = ApiClient();

  Future<Response> saveRewardId(
      {required String customerPhone, required String referralId}) async {
    try {
      final Response response = await apiClient.post(
        AppConstants.LOTTERY_CHECK_REWARD_ID_BY_THIN,
        queryParameters: {'custPhone': customerPhone, 'rewardID': referralId},
        data: {},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
