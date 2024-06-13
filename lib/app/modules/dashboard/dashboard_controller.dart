import 'package:app_version_update/app_version_update.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../apis/api_exception.dart';
import '../../controllers/storage_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/bonus_referral_model.dart';
import '../../models/reward_model.dart';
import '../../routes/app_pages.dart';
import '../../services/bonus_service.dart';
import '../../widgets/error_alert_widget.dart';
import '../../widgets/permission_dialog_widget.dart';

class DashboardController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final StorageController storageController = Get.find<StorageController>();
  final BonusService bonusService = Get.find<BonusService>();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString accessToken = ''.obs;
  RxBool isBonusLoading = true.obs;
  RxBool isRewardLoading = true.obs;
  Rx<BonusReferralModel?> bonusReferralModel = BonusReferralModel().obs;
  Rx<RewardModel?> rewardModel = RewardModel().obs;
  @override
  void onInit() async {
    super.onInit();
    getUpdate();
    checkNotificationPermission();
    accessToken.value = storageController.accessToken;
    await userController.getUserInfo();
    var _firstName = userController.userInfoModel.firstname == null ||
            userController.userInfoModel.firstname!.isEmpty
        ? true
        : false;
    var _lastName = userController.userInfoModel.lastname == null ||
            userController.userInfoModel.lastname!.isEmpty
        ? true
        : false;
    if (_firstName || _lastName) {
      Get.offAllNamed(Routes.REGISTER,
          arguments: userController.userInfoModel.phone!);
    }
    firstName.value = userController.userInfoModel.firstname!;
    lastName.value = userController.userInfoModel.lastname!;
    loadBonus();
    loadReward();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  getUpdate() async {
    final appleId = '1613030945';
    final playStoreId = 'com.sit.scng_app';
    final country = 'la';
    await AppVersionUpdate.checkForUpdates(
      appleId: appleId,
      playStoreId: playStoreId,
      country: country,
    ).then((data) async {
      if (kDebugMode) {
        Logger().i(
          'StoreUrl: ${data.storeUrl}\nStoreVersion: ${data.storeVersion}',
        );
      }

      if (data.canUpdate!) {
        AppVersionUpdate.showAlertUpdate(
          appVersionResult: data,
          context: Get.context!,
          mandatory: true,
          title: Translates.NEW_VERSION_AVAILABLE.tr,
          content: Translates.YOU_MUST_UPDATE_THE_APP_TO_USE_NEW_FEATURE.tr,
          contentTextStyle: robotoMedium,
          updateButtonText: Translates.BUTTON_UPDATE.tr,
          titleTextStyle: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        );
      }
    });
  }

  checkNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      Logger().i('=====> Permission status: ${settings.authorizationStatus}');
    }

    if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      showDialog(
        context: Get.context!,
        builder: (context) => PermissionDialogWidget(),
      );
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      showDialog(
        context: Get.context!,
        builder: (context) => PermissionDialogWidget(),
      );
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      showDialog(
        context: Get.context!,
        builder: (context) => PermissionDialogWidget(),
      );
    }
  }

  logout() async {
    await storageController.clearStorage();
    Get.offAllNamed(Routes.LOGIN);
  }

  loadBonus() async {
    try {
      isBonusLoading.value = true;
      final response = await bonusService.getBonusReferral(
          customerPhone: userController.userInfoModel.phone!);

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

  loadReward() async {
    try {
      isRewardLoading.value = true;
      final response = await bonusService.checkRewardId(
          customerPhone: userController.userInfoModel.phone!);

      if (response.statusCode == 200) {
        final item = RewardModel.fromJson(response.data);
        rewardModel.value = item;
      } else {
        rewardModel.value = RewardModel(custId: 0, rewardId: null, expAt: null);
      }
      isRewardLoading.value = false;
    } on DioException catch (error) {
      isRewardLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
      //   Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }
}
