import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/modules/lottery_history/result/lottery_result_history_controller.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/screens/lottery/widgets/no_items_found_widget.dart';

import 'lottery_result_history_model.dart';

class LotteryResultHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryResultHistoryController>(
      init: LotteryResultHistoryController(),
      builder: (controller) {
        return OverlayLoaderWithAppIcon(
          isLoading: controller.invoiceLoading.value,
          appIcon: Image.asset(Images.loadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                controller.offset.value = 0;
                controller.limit.value = controller.pageSize.value;
                controller.pagingController.itemList!.clear();
                await controller.loadLotteryResultHistories(0);
              },
              child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, DrawItem>.separated(
                    pagingController: controller.pagingController,
                    builderDelegate: PagedChildBuilderDelegate<DrawItem>(
                      animateTransitions: true,
                      itemBuilder: (context, item, index) {
                        return Container(
                          height: 80,
                          margin: EdgeInsets.only(
                            top: 2,
                            left: 10,
                            right: 10,
                            bottom: 2,
                          ),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.historyLotResultBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Stack(
                            children: [
                              ListTile(
                                title: Column(
                                  children: [
                                    buildLotteryResultDate(item),
                                    item.winNumber == ""
                                        ? Container(
                                            padding: EdgeInsets.only(
                                              top: 4,
                                              bottom: 8.0,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "ເລກຍັງບໍ່ທັນອອກ",
                                                style: robotoBold,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : buildLotteryResultItems(item),
                                  ],
                                ),
                                trailing: SizedBox(width: 40, height: 40),
                              ),
                              Positioned(
                                top: 4,
                                right: 15,
                                child: buildLotteryResultAnimals(
                                  item,
                                  controller,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      noItemsFoundIndicatorBuilder: (_) => NoItemsFoundWidget(),
                    ),
                    separatorBuilder: (_, __) => SizedBox(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLotteryResultDate(DrawItem item) {
    return Row(
      children: [
        Text(
          '${"lotteryResult".tr}: ${item.roundDate != "" ? DateConverter.isoStringToLocalString(item.roundDate.toString()) : 0}',
          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
        ),
      ],
    );
  }

  Widget buildLotteryResultItems(DrawItem item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < item.winNumber.toString().length; i++)
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 8.0, bottom: 4),
              margin: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.redAccent.shade700,
              ),
              child: Center(
                child: Text(
                  item.winNumber != "" ? item.winNumber![i].toString() : '',
                  style: robotoBold.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget buildLotteryResultAnimals(
      DrawItem item, LotteryResultHistoryController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < controller.getChoiceList().length; i++)
          if (item.winNumber != "" &&
              controller.getChoiceList()[i].contains(item.winNumber
                  .toString()
                  .substring(item.winNumber.toString().length - 2))) ...[
            Text(
              '${controller.getNameList()[i].tr}',
              style: robotoBold,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Image.asset(
                controller.getChoiceListImg()[i],
                fit: BoxFit.fill,
                width: 40,
                height: 40,
              ),
            ),
          ],
      ],
    );
  }
}
