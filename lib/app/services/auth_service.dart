import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_client.dart';
import 'package:scn_easy/util/app_constants.dart';

class AuthService {
  final ApiClient apiClient = ApiClient();

  Future<Response> requestOTP({required String phoneNumber}) async {
    try {
      final data = {'phone': phoneNumber};

      final Response response = await apiClient.post(
        AppConstants.SEND_OTP,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> verifyOTP({
    required String phoneNumber,
    required String otpCode,
  }) async {
    try {
      final data = {
        'phone': phoneNumber,
        'otp': otpCode,
        'app_name': 'SCN',
      };

      final Response response = await apiClient.post(
        AppConstants.LOGIN_URI,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
