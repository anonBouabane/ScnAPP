import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class LotteryRewardService {
  final ApiClient dioClient = ApiClient();

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

      final Response response = await dioClient.get(
        AppConstants.LOTTERY_REWARD_DETAIL_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
