import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';

import '../../services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService authService = Get.find<AuthService>();

  late TextEditingController phoneNumberCtrl;

  RxBool isDataLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    phoneNumberCtrl = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    phoneNumberCtrl.dispose();
  }

  Future<bool> requestOTP() async {
    try {
      isDataLoading.value = true;
      final json = await authService.requestOTP(
        phoneNumber: phoneNumberCtrl.text,
      );
      if (json.statusCode == 200) {
        if (kDebugMode) {
          Logger().d('response: ${json.data}');
        }
        return true;
      }
      isDataLoading.value = false;
      return false;
    } on DioException catch (dioException) {
      isDataLoading.value = false;
      if (kDebugMode) {
        final apiException = ApiException.fromDioError(dioException);
        Logger().d('apiException: ${apiException.message}');
      }
      return false;
    }
  }
}
