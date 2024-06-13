import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../apis/api_exception.dart';
import '../../controllers/user_controller.dart';
import '../../models/reward_model.dart';
import '../reward_point/reward_point_service.dart';

class RewardDetailController extends GetxController {
  final UserController userController = Get.find<UserController>();
  final RewardPointService rewardPointService = Get.find<RewardPointService>();
  final PagingController<int, LotteryRewardItem> pagingController =
      PagingController(firstPageKey: 0);
  RxBool isDataLoading = false.obs;
  RxInt drawId = 0.obs;
  RxString drawDate = ''.obs;
  RxInt limit = 20.obs;
  RxInt offset = 0.obs;
  RxInt pageSize = 20.obs;
  RxInt totalUser = 0.obs;
  RxInt totalReward = 0.obs;
  Map<String, dynamic> args = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    drawId.value = args['drawId'];
    drawDate.value = args['drawDate'];
    paginate();
  }

  loadLotteryRewards(int pageKey) async {
    try {
      isDataLoading.value = true;
      final response = await rewardPointService.loadRewardDetail(
        drawId: drawId.value,
        phone: userController.userInfoModel.phone!,
      );
      if (response.statusCode == 200) {
        LotteryRewardModel rewards = LotteryRewardModel.fromJson(response.data);
        List<LotteryRewardItem> newItems = [];

        totalUser.value = rewards.totalUser ?? 0;
        totalReward.value = rewards.totalReward ?? 0;

        if (rewards.items!.length > 0) {
          for (LotteryRewardItem item in rewards.items!) {
            newItems.add(item);
          }
        }

        final isLastPage = newItems.length < pageSize.value;
        if (kDebugMode) {
          Logger().i(
            'isLastPage: $isLastPage\n'
            'Length: ${newItems.length}\n'
            'PageSize: ${pageSize.value}',
          );
        }
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          offset.value = offset.value + limit.value;
          limit.value = limit.value + limit.value;
          pagingController.appendPage(newItems, nextPageKey);
        }
      }
      isDataLoading.value = false;
    } on DioException catch (error) {
      isDataLoading.value = false;
      pagingController.error = error;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }

  paginate() {
    pagingController.addPageRequestListener((pageKey) {
      loadLotteryRewards(pageKey);
    });

    pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });
  }
}
