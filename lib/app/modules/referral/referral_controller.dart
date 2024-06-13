import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../apis/api_exception.dart';
import '../../controllers/user_controller.dart';
import '../../widgets/error_alert_widget.dart';
import 'referral_service.dart';

class ReferralController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final ReferralService referralService = Get.find<ReferralService>();
  RxBool isDataLoading = true.obs;
  RxBool isSaveSuccess = false.obs;
  late TextEditingController txtReferralCode;

  @override
  void onInit() {
    super.onInit();
    txtReferralCode = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    txtReferralCode.dispose();
  }

  saveRewardId() async {
    try {
      isDataLoading.value = true;
      final response = await referralService.saveRewardId(
        customerPhone: userController.userInfoModel.phone!,
        referralId: txtReferralCode.text.trim(),
      );

      if (response.statusCode == 200) {
        isDataLoading.value = false;
        isSaveSuccess.value = true;
      }
    } on DioException catch (error) {
      isDataLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }
}
