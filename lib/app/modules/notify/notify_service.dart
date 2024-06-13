import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class NotifyService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadNotifications() async {
    try {
      final Response response =
          await apiClient.get(AppConstants.NOTIFICATION_URI);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
