import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../apis/api_client.dart';

class RewardPointService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadReward({
    required String customerPhone,
  }) async {
    try {
      final params = <String, dynamic>{
        'custPhone': customerPhone,
        'limit': 30,
        'offset': 0
      };
      final Response response = await apiClient.get(
        AppConstants.LOTTERY_REWARD_BY_THIN,
        queryParameters: params,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadPoint({
    required String customerPhone,
  }) async {
    try {
      final params = <String, dynamic>{
        'custPhone': customerPhone,
        'limit': 30,
        'offset': 0,
      };
      final Response response = await apiClient.get(
        AppConstants.LOTTERY_POINT_BY_THIN,
        queryParameters: params,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadRewardDetail({
    required int drawId,
    required String phone,
  }) async {
    try {
      final params = <String, dynamic>{
        'drawId': drawId,
        'custPhone': phone,
        'limit': 20,
        'offset': 0,
      };

      final Response response = await apiClient.get(
        AppConstants.LOTTERY_REWARD_DETAIL_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
