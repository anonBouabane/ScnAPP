import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/lottery_history/lottery_history_controller.dart';
import 'package:scn_easy/app/modules/lottery_history/result/lottery_result_history_view.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../widgets/background_widget.dart';
import 'invoice/lottery_invoice_history_view.dart';

class LotteryHistoryView extends StatelessWidget {
  const LotteryHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryHistoryController>(
      init: LotteryHistoryController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            backgroundColor: Colors.redAccent.shade700,
            centerTitle: true,
            elevation: 0,
            title: Text(
              'history'.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge1,
              ),
            ),
          ),
          body: Stack(
            children: [
              BackgroundWidget(),
              Column(
                children: [
                  Row(
                    children: [
                      buildTabButtonInvoice(controller),
                      buildTabButtonResult(controller),
                    ],
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: controller.tabIndex.value,
                      children: [
                        LotteryInvoiceHistoryView(),
                        LotteryResultHistoryView(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildTabButtonInvoice(LotteryHistoryController controller) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.setTabIndex(0);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: controller.tabIndex.value != 0
                ? Colors.grey.shade300
                : Colors.redAccent.shade700,
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Container(
            height: 38,
            margin: const EdgeInsets.only(
              bottom: 3.0,
              right: 1,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "buyLottery".tr,
                style: robotoBold.copyWith(
                  color: controller.tabIndex.value != 1
                      ? Colors.redAccent.shade700
                      : Colors.black,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTabButtonResult(LotteryHistoryController controller) {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.setTabIndex(1);
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: controller.tabIndex.value != 1
                ? Colors.grey.shade300
                : Colors.redAccent.shade700,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
          ),
          child: Container(
            height: 38,
            margin: const EdgeInsets.only(
              bottom: 3.0,
              left: 1,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                "lotteryResult".tr,
                style: robotoBold.copyWith(
                  color: controller.tabIndex.value != 0
                      ? Colors.redAccent.shade700
                      : Colors.black,
                  fontSize: Dimensions.fontSizeLarge,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
