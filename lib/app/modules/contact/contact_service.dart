import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class ContactService {
  final ApiClient apiClient = ApiClient();

  Future<Response> loadContact() async {
    try {
      final Response response = await apiClient.get(AppConstants.CONTACT_US);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
