import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class ContactUsService {
  final ApiClient dioClient = ApiClient();

  Future<Response> loadContactUs() async {
    try {
      final Response response = await dioClient.get(AppConstants.CONTACT_US);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
