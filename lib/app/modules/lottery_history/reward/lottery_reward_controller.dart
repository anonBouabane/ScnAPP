import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:scn_easy/controller/auth_controller.dart';

import 'lottery_reward_model.dart';
import 'lottery_reward_service.dart';

class LotteryRewardController extends GetxController {
  final lotteryRewardService = Get.put(LotteryRewardService());

  final PagingController<int, LotteryRewardItem> pagingController =
      PagingController(firstPageKey: 0);

  int drawId = 0;
  String _drawDate = '';
  String get drawDate => _drawDate;
  int _limit = 20;
  void setLimit(value) {
    _limit = value;
    update();
  }

  int _offset = 0;
  void setOffset(value) {
    _offset = value;
    update();
  }

  int _pageSize = 20;
  int get pageSize => _pageSize;
  String phone = '';
  bool _isDataLoading = false;
  bool get isDataLoading => _isDataLoading;
  int _totalUser = 0;
  int get totalUser => _totalUser;
  int _totalReward = 0;
  int get totalReward => _totalReward;

  @override
  void onInit() async {
    super.onInit();
    phone = Get.find<AuthController>().getUserNumber();
    Logger().i(Get.arguments['drawId']);
    drawId = Get.arguments['drawId'];
    _drawDate = Get.arguments['drawDate'];
    Logger().i(
      'phone: $phone\n'
      'drawId: $drawId\n'
      'drawDate: $_drawDate',
    );
    paginate();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    pagingController.dispose();
  }

  loadLotteryRewards(int pageKey) async {
    try {
      _isDataLoading = true;
      final response = await lotteryRewardService.loadRewardDetail(
        drawId: drawId,
        phone: phone,
      );
      if (response.statusCode == 200) {
        LotteryRewardModel rewards = LotteryRewardModel.fromJson(response.data);
        List<LotteryRewardItem> newItems = [];

        _totalUser = rewards.totalUser ?? 0;
        _totalReward = rewards.totalReward ?? 0;

        if (rewards.items!.length > 0) {
          for (LotteryRewardItem item in rewards.items!) {
            newItems.add(item);
          }
        }

        final isLastPage = newItems.length < _pageSize;
        if (kDebugMode) {
          Logger().i(
            'isLastPage: $isLastPage\n'
            'Length: ${newItems.length}\n'
            'PageSize: $_pageSize',
          );
        }
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _offset = _offset + _limit;
          _limit = _limit + _limit;
          pagingController.appendPage(newItems, nextPageKey);
        }
      }
      _isDataLoading = false;
    } on DioException catch (error) {
      _isDataLoading = false;
      pagingController.error = error;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
    update();
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
