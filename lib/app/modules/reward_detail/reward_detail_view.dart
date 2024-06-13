import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

import '../../models/reward_model.dart';
import 'reward_detail_controller.dart';

class RewardDetailView extends GetView<RewardDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade600,
      appBar: AppBar(
        title: Obx(
          () => Text(
            '${controller.drawDate}',
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge1,
            ),
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: OverlayLoaderWithAppIcon(
        isLoading: controller.isDataLoading.value,
        appIcon: Image.asset(Images.loadingLogo),
        circularProgressColor: Colors.green.shade800,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                height: 120,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade700,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'ທ່ານແນະນຳທັງໝົດ',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge,
                                color: Colors.white),
                          ),
                          Text(
                            '${controller.totalUser}',
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeHugeLarge1,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'ເງິນແນະນຳໃນງວດ',
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${controller.totalReward}',
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeHugeLarge1,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PagedSliverList<int, LotteryRewardItem>.separated(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<LotteryRewardItem>(
                animateTransitions: true,
                itemBuilder: (context, item, index) {
                  return Container(
                    height: 90,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 4,
                      bottom: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ຄົນທີ່ທ່ານແນະນຳ',
                                  style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge),
                                ),
                                Text(
                                  '${item.lottoUser}',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ເງິນແນະນຳ',
                                  style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                  ),
                                ),
                                Text(
                                  '${PriceConverter.convertPriceNoCurrency(double.parse(item.totalReward.toString()))}',
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge,
                                    color: Colors.redAccent.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              separatorBuilder: (_, __) => SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
