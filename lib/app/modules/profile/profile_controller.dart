import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:scn_easy/app/modules/profile/profile_service.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/data/model/response/update_profile.dart';
import 'package:scn_easy/data/model/response/userinfo_model.dart';

class ProfileController extends GetxController {
  final profileService = Get.put(ProfileService());
  late TextEditingController txtUsername;
  late TextEditingController txtMobile;
  late TextEditingController txtFirstName;
  late TextEditingController txtLastName;
  late TextEditingController txtBankName;
  late TextEditingController txtBankAccountName;
  late TextEditingController txtBankAccountNumber;
  RxBool isLoggedIn = RxBool(false);
  RxString gender = RxString('');
  RxInt bankAccountStatus = RxInt(0);
  RxBool isEditProfile = RxBool(false);
  RxBool isLoading = RxBool(false);
  RxInt bankId = RxInt(0);
  // UserInfoModel userInfoModel = UserInfoModel();

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
    isLoggedIn.value = Get.find<AuthController>().isLoggedIn();
    txtUsername = TextEditingController();
    txtMobile = TextEditingController();
    txtFirstName = TextEditingController();
    txtLastName = TextEditingController();
    txtBankName = TextEditingController();
    txtBankAccountName = TextEditingController();
    txtBankAccountNumber = TextEditingController();
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

  @override
  void onReady() {
    super.onReady();
  }

  loadProfile() async {
    try {
      isLoading.value = true;
      update();

      final response = await profileService.loadUserInfo();

      if (response.statusCode == 200) {
        final item = UserInfoModel.fromJson(response.data);
        txtUsername.text = '${item.firstname} ${item.lastname}';
        txtMobile.text = '${item.phone}';
        txtFirstName.text = '${item.firstname}';
        txtLastName.text = '${item.lastname}';
        txtBankName.text = '${item.bankName.toString().replaceAll('null', '')}';
        txtBankAccountName.text =
            '${item.accountName.toString().replaceAll('null', '')}';
        txtBankAccountNumber.text =
            '${item.accountNo.toString().replaceAll('null', '')}';
        gender.value = '${item.gender.toString().replaceAll('null', 'm')}';
        bankId.value = item.bankId ?? 0;
        bankAccountStatus.value = item.accStatus!;
        isLoading.value = false;
        update();
      }
    } on DioException catch (error) {
      isLoading.value = false;
      update();
      Logger().w('Error: $error');
      final apiException = ApiException.fromDioError(error);
      Get.snackbar(
        'error'.tr,
        apiException.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  updateUserInfo(UserProfile userProfile) async {
    try {
      isLoading.value = true;
      update();
      final response =
          await profileService.updateUserInfo(userProfile: userProfile);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success'.tr,
          response.data['msg']!,
          snackPosition: SnackPosition.BOTTOM,
        );
        isLoading.value = false;
        update();
      }
    } on DioException catch (error) {
      isLoading.value = false;
      update();
      final apiException = ApiException.fromDioError(error);
      Get.snackbar(
        'error'.tr,
        apiException.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
