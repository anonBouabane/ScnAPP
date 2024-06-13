import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../apis/api_exception.dart';
import '../../controllers/storage_controller.dart';
import '../../controllers/user_controller.dart';
import '../../languages/translates.dart';
import '../../models/user_model.dart';
import '../../widgets/error_alert_widget.dart';
import 'user_info_service.dart';

class UserInfoController extends GetxController {
  final storageController = Get.find<StorageController>();
  final userService = Get.find<UserInfoService>();
  final UserController userController = Get.find<UserController>();
  late TextEditingController txtUsername,
      txtMobile,
      txtFirstName,
      txtLastName,
      txtBankName,
      txtBankAccountName,
      txtBankAccountNumber;
  RxString gender = RxString('');
  RxInt bankAccountStatus = RxInt(0);
  RxBool isEditProfile = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxInt bankId = RxInt(0);
  RxString bankName = ''.obs;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    txtUsername = TextEditingController();
    txtMobile = TextEditingController();
    txtFirstName = TextEditingController();
    txtLastName = TextEditingController();
    txtBankName = TextEditingController();
    txtBankAccountName = TextEditingController();
    txtBankAccountNumber = TextEditingController();
    loadProfile();
  }

  @override
  void onClose() {
    super.onClose();
    txtUsername.dispose();
    txtMobile.dispose();
    txtFirstName.dispose();
    txtLastName.dispose();
    txtBankName.dispose();
    txtBankAccountName.dispose();
    txtBankAccountNumber.dispose();
  }

  loadProfile() async {
    try {
      isLoading.value = true;
      final response = await userService.loadUserInfo();

      if (response.statusCode == 200) {
        final item = UserModel.fromJson(response.data);
        txtUsername.text = '${item.firstName} ${item.lastName}';
        txtMobile.text = '${item.phone}';
        txtFirstName.text = '${item.firstName}';
        txtLastName.text = '${item.lastName}';
        txtBankName.text = '${item.bankName.toString().replaceAll('null', '')}';
        txtBankAccountName.text =
            '${item.accountName.toString().replaceAll('null', '')}';
        txtBankAccountNumber.text =
            '${item.accountNumber.toString().replaceAll('null', '')}';
        gender.value = '${item.gender.toString().replaceAll('null', 'm')}';
        bankId.value = item.bankId ?? 0;
        bankAccountStatus.value = item.accountStatus!;
        isLoading.value = false;
      }
    } on DioException catch (error) {
      isLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }

  updateUserInfo(UserModel userModel) async {
    try {
      isLoading.value = true;

      if (kDebugMode) {
        Logger().w('userInfoUpdate: ${userModel.toJson()}');
      }

      final response = await userService.updateUserInfo(userModel: userModel);

      if (response.statusCode == 200) {
        Get.snackbar(
          Translates.SNACK_BAR_TITLE_SUCCESS.tr,
          response.data['msg']!,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red.shade900,
        );
        isLoading.value = false;
      }
    } on DioException catch (error) {
      isLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }
}
