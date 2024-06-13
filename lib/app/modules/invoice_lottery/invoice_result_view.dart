import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../languages/translates.dart';
import '../../widgets/background_widget.dart';
import 'invoice_history_view.dart';
import 'invoice_result_controller.dart';
import 'result_history_view.dart';

class InvoiceResultView extends GetView<InvoiceResultController> {
  const InvoiceResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.redAccent.shade700,
          centerTitle: true,
          elevation: 0,
          title: Text(
            Translates.APP_TITLE_HISTORY.tr,
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
                    buildTabButtonInvoice(),
                    buildTabButtonResult(),
                  ],
                ),
                Expanded(
                  child: IndexedStack(
                    index: controller.currentTabIndex.value,
                    children: [
                      InvoiceHistoryView(),
                      ResultHistoryView(),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget buildTabButtonInvoice() {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.currentTabIndex.value = 0;
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: controller.currentTabIndex.value != 0
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
                Translates.APP_TITLE_BUY_LOTTERY.tr,
                style: robotoBold.copyWith(
                  color: controller.currentTabIndex.value != 1
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

  Widget buildTabButtonResult() {
    return Expanded(
      child: InkWell(
        onTap: () {
          controller.currentTabIndex.value = 1;
        },
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: controller.currentTabIndex.value != 1
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
                Translates.APP_TITLE_LOTTERY_RESULT.tr,
                style: robotoBold.copyWith(
                  color: controller.currentTabIndex.value != 0
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
