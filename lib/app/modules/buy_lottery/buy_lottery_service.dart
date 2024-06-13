import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../apis/api_client.dart';

class BuyLotteryService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadResults({
    required int limit,
    required int offset,
  }) async {
    try {
      final params = <String, dynamic>{
        'limit': limit,
        'offset': offset,
      };

      final Response response = await apiClient.post(
        AppConstants.LOTTERY_HISTORY_BY_THIN,
        queryParameters: params,
        data: null,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkLotteryOpen() async {
    try {
      final Response response = await apiClient.post(
        AppConstants.CHECK_LOT_OPEN_CLOSE,
        data: null,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
