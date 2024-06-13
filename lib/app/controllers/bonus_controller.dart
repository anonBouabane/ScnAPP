import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../apis/api_exception.dart';
import '../models/bonus_referral_model.dart';
import '../services/bonus_service.dart';
import '../widgets/error_alert_widget.dart';
import 'user_controller.dart';

class BonusController extends GetxController {
  final UserController userController = UserController();
  final BonusService bonusService = BonusService();
  Rx<BonusReferralModel?> bonusReferralModel = BonusReferralModel().obs;
  RxBool isBonusLoading = true.obs;
  RxString customerPhone = ''.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadBonus({required String customerPhone}) async {
    try {
      isBonusLoading.value = true;
      final response = await bonusService.getBonusReferral(
        customerPhone: customerPhone,
      );

      if (response.statusCode == 200) {
        final item = BonusReferralModel.fromJson(response.data);
        bonusReferralModel.value = item;
        isBonusLoading.value = false;
      }
    } on DioException catch (error) {
      isBonusLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }
}
