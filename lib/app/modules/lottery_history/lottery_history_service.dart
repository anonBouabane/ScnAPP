import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class LotteryHistoryService {
  final ApiClient dioClient = ApiClient();

  Future<Response> loadLotteryInvoiceHistoryForPagination({
    required String phone,
    required int limit,
    required int offset,
  }) async {
    try {
      final params = <String, dynamic>{
        'custPhone': phone,
        'limit': limit,
        'offset': offset,
      };

      final Response response = await dioClient.get(
        AppConstants.LOTTERY_INVOICE_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadLotteryResultHistoryForPagination({
    required int limit,
    required int offset,
  }) async {
    try {
      final params = <String, dynamic>{
        'limit': limit,
        'offset': offset,
      };

      final Response response = await dioClient.post(
        AppConstants.LOTTERY_HISTORY_BY_THIN,
        queryParameters: params,
        data: {},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
