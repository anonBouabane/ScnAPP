import 'package:dio/dio.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../apis/api_client.dart';

class InvoiceResultService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadInvoices({
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

      final Response response = await apiClient.get(
        AppConstants.LOTTERY_INVOICE_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadResults({
    required String customerPhone,
    required int limit,
    required int offset,
  }) async {
    try {
      final params = <String, dynamic>{
        'custPhone': customerPhone,
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
}
