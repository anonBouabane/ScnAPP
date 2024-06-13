import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../apis/api_exception.dart';
import '../../controllers/bonus_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/reward_model.dart';
import 'reward_point_service.dart';

class RewardPointController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final BonusController bonusController = Get.find<BonusController>();
  final RewardPointService rewardPointService = Get.find<RewardPointService>();
  RxInt currentTabIndex = 0.obs;
  RxBool isRewardLoading = true.obs;
  RxBool isPointLoading = true.obs;
  RxBool isDataLoading = true.obs;
  Rx<RewardItem> rewardItem = RewardItem().obs;
  RxList<DrawModel> drawList = <DrawModel>[].obs;
  Rx<PointItem> pointItem = PointItem().obs;
  RxList<Statement> pointList = <Statement>[].obs;

  @override
  void onInit() {
    super.onInit();
    currentTabIndex.value = Get.arguments;
    loadReward();
    bonusController.loadBonus(
        customerPhone: userController.userInfoModel.phone!);
    loadPoint();
  }

  @override
  void onClose() {
    super.onClose();
  }

  loadReward() async {
    try {
      isRewardLoading.value = true;
      final response = await rewardPointService.loadReward(
        customerPhone: userController.userInfoModel.phone!,
      );
      if (response.statusCode == 200) {
        rewardItem.value = RewardItem.fromJson(response.data);
        drawList.clear();
        drawList.addAll(RewardItem.fromJson(response.data).draws!);
        // for (DrawModel item in rewardItem.value.draws!) {
        //   drawList.add(item);
        // }
      }
      isRewardLoading.value = false;
    } on DioException catch (error) {
      isRewardLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
    }
  }

  loadPoint() async {
    try {
      isPointLoading.value = true;
      final response = await rewardPointService.loadPoint(
        customerPhone: userController.userInfoModel.phone!,
      );
      if (response.statusCode == 200) {
        pointItem.value = PointItem.fromJson(response.data);
        pointList.clear();
        pointList.addAll(PointItem.fromJson(response.data).statements!);
      }
      isPointLoading.value = false;
    } on DioException catch (error) {
      isPointLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
    }
  }
}
