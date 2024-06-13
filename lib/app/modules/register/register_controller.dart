import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../apis/api_exception.dart';
import '../../languages/translates.dart';
import '../../models/user_model.dart';
import '../../routes/app_pages.dart';
import '../../services/user_service.dart';
import '../../widgets/error_alert_widget.dart';
import '../../widgets/success_alert_widget.dart';

class RegisterController extends GetxController {
  final UserService userService = Get.find<UserService>();
  late TextEditingController txtFirstName, txtLastName, txtPhone;
  RxBool isDataLoading = false.obs;
  RxBool acceptTerms = true.obs;
  RxString gender = 'm'.obs;
  RxString customerPhone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    txtFirstName = TextEditingController();
    txtLastName = TextEditingController();
    txtPhone = TextEditingController();
    txtPhone.text = Get.arguments;
  }

  @override
  void onClose() {
    super.onClose();
    txtFirstName.dispose();
    txtLastName.dispose();
    txtPhone.dispose();
  }

  register() async {
    try {
      UserProfile body = UserProfile(
        firstname: txtFirstName.text.trim(),
        lastname: txtLastName.text.trim(),
        phone: txtPhone.text.trim(),
        gender: gender.value,
      );

      final json = await userService.registerProfile(body);

      if (json.statusCode == 200) {
        Get.offAllNamed(Routes.DASHBOARD);
        txtFirstName.clear();
        txtLastName.clear();
        txtPhone.clear();
        Get.dialog(SuccessAlertWidget(message: Translates.REGISTER_SUCCESS.tr));
      }
    } on DioException catch (dioException) {
      final apiException = ApiException.fromDioError(dioException);

      Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }
}
