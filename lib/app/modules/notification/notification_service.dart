import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class NotificationService {
  final ApiClient dioClient = ApiClient();

  Future<Response> loadNotifications() async {
    try {
      final Response response =
          await dioClient.get(AppConstants.NOTIFICATION_URI);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
