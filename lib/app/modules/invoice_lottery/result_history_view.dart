import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

import '../../languages/translates.dart';
import '../../models/lottery_history_model.dart';
import '../../widgets/no_item_found_widget.dart';
import 'invoice_result_controller.dart';

class ResultHistoryView extends GetView<InvoiceResultController> {
  const ResultHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.offsetResult.value = 0;
          controller.limitResult.value = controller.pageSizeResult.value;
          controller.pagingResultController.itemList!.clear();
          await controller.loadResults(0);
        },
        child: OverlayLoaderWithAppIcon(
          isLoading: controller.invoiceLoading.value,
          appIcon: Image.asset(Images.loadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: CustomScrollView(
            slivers: [
              PagedSliverList<int, DrawItem>.separated(
                pagingController: controller.pagingResultController,
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
                                item.winNumber == ''
                                    ? Container(
                                        padding: EdgeInsets.only(
                                          top: 4,
                                          bottom: 8.0,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'ເລກຍັງບໍ່ທັນອອກ',
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
                            child: buildLotteryResultAnimals(item),
                          ),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) => NoItemFoundWidget(),
                ),
                separatorBuilder: (_, __) => SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLotteryResultDate(DrawItem item) {
    return Row(
      children: [
        Text(
          '${Translates.LOTTERY_RESULT.tr}: ${item.roundDate != '' ? DateConverter.isoStringToLocalString(item.roundDate.toString()) : 0}',
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
                  item.winNumber != '' ? item.winNumber![i].toString() : '',
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

  Widget buildLotteryResultAnimals(DrawItem item) {
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
