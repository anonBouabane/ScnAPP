import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/util/textStyle.dart';
import 'package:scn_easy/view/base/fade_animation.dart';
import 'package:screenshot/screenshot.dart';

import '../../languages/translates.dart';
import 'invoice_detail_controller.dart';

class InvoiceDetailView extends GetView<InvoiceDetailController> {
  const InvoiceDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          Translates.APP_TITLE_INVOICE_DETAIL.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge1,
          ),
        ),
        actions: [
          IconButton(
            onPressed: controller.captureScreenShoot,
            icon: const Icon(
              Icons.share,
            ),
          ),
        ],
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Screenshot(
        controller: controller.screenshotController,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.width * 0.5,
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Image.asset(
                        Assets.imagesBgInvoiceSuccess,
                        fit: BoxFit.fill,
                        width: Get.width,
                        height: Get.width * 0.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          buildBillSuccessful(),
                          buildBillSuccessfulDateTime(),
                          buildBillSuccessfulDrawDateTime(),
                          Gap(18),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              buildTableLine(),
              buildTableHeader(),
              buildTableLine(),
              Expanded(
                child: SingleChildScrollView(
                  child: RepaintBoundary(
                    key: controller.captureGlobalKey,
                    child: Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          controller.invoiceItem.value
                                              .lotteryDetails!.length;
                                      i++)
                                    if (i % 2 == 0)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          controller.invoiceItem.value
                                                  .lotteryDetails![i].digit
                                                  .toString()
                                                  .isEmpty
                                              ? const Text('No Lottery')
                                              : Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        for (int j = 0;
                                                            j <
                                                                controller
                                                                    .getChoiceList()
                                                                    .length;
                                                            j++) ...[
                                                          if (controller
                                                                  .invoiceItem
                                                                  .value
                                                                  .lotteryDetails!
                                                                  .isNotEmpty &&
                                                              controller
                                                                      .invoiceItem
                                                                      .value
                                                                      .lotteryDetails![
                                                                          i]
                                                                      .digit
                                                                      .toString()
                                                                      .length ==
                                                                  1) ...[
                                                            if (controller.getChoiceList()[j].contains('0' +
                                                                controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails![
                                                                        i]
                                                                    .digit
                                                                    .toString()
                                                                    .substring(controller
                                                                            .invoiceItem
                                                                            .value
                                                                            .lotteryDetails![
                                                                                i]
                                                                            .digit
                                                                            .toString()
                                                                            .length -
                                                                        1)))
                                                              Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  child:
                                                                      Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              3),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                8,
                                                                            child: Image.asset(controller.getChoiceListImg()[j],
                                                                                fit: BoxFit.fill,
                                                                                width: 30,
                                                                                height: 30),
                                                                          )),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        width:
                                                                            2.0),
                                                                  )),
                                                          ] else ...[
                                                            if (controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails!
                                                                    .isNotEmpty &&
                                                                controller.getChoiceList()[j].contains(controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails![
                                                                        i]
                                                                    .digit
                                                                    .toString()
                                                                    .substring(controller
                                                                            .invoiceItem
                                                                            .value
                                                                            .lotteryDetails![
                                                                                i]
                                                                            .digit
                                                                            .toString()
                                                                            .length -
                                                                        2)))
                                                              Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  child:
                                                                      Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              3),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                8,
                                                                            child: Image.asset(controller.getChoiceListImg()[j],
                                                                                fit: BoxFit.fill,
                                                                                width: 30,
                                                                                height: 30),
                                                                          )),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        width:
                                                                            2.0),
                                                                  )),
                                                          ]
                                                        ],
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          controller
                                                              .invoiceItem
                                                              .value
                                                              .lotteryDetails![
                                                                  i]
                                                              .digit
                                                              .toString(),
                                                          style:
                                                              OptionTextStyle()
                                                                  .optionStyle(
                                                                      null,
                                                                      null,
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            controller.invoiceItem.value
                                                    .lotteryDetails![i].amount
                                                    .toString()
                                                    .isEmpty
                                                ? '0'
                                                : PriceConverter
                                                    .convertPriceNoCurrency(
                                                        double.parse(controller
                                                            .invoiceItem
                                                            .value
                                                            .lotteryDetails![i]
                                                            .amount
                                                            .toString())),
                                            style: OptionTextStyle()
                                                .optionStyle(null, null,
                                                    FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Expanded(
                            child: Container(
                              child: Column(
                                children: [
                                  for (int i = 0;
                                      i <
                                          controller.invoiceItem.value
                                              .lotteryDetails!.length;
                                      i++)
                                    if (i % 2 == 1)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          controller.invoiceItem.value
                                                  .lotteryDetails![i].digit
                                                  .toString()
                                                  .isEmpty
                                              ? const Text('No Lottery')
                                              : Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        for (int j = 0;
                                                            j <
                                                                controller
                                                                    .getChoiceList()
                                                                    .length;
                                                            j++) ...[
                                                          if (controller
                                                                  .invoiceItem
                                                                  .value
                                                                  .lotteryDetails!
                                                                  .isNotEmpty &&
                                                              controller
                                                                      .invoiceItem
                                                                      .value
                                                                      .lotteryDetails![
                                                                          i]
                                                                      .digit
                                                                      .toString()
                                                                      .length ==
                                                                  1) ...[
                                                            if (controller.getChoiceList()[j].contains('0' +
                                                                controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails![
                                                                        i]
                                                                    .digit
                                                                    .toString()
                                                                    .substring(controller
                                                                            .invoiceItem
                                                                            .value
                                                                            .lotteryDetails![
                                                                                i]
                                                                            .digit
                                                                            .toString()
                                                                            .length -
                                                                        1)))
                                                              Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  child:
                                                                      Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              3),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                8,
                                                                            child: Image.asset(controller.getChoiceListImg()[j],
                                                                                fit: BoxFit.fill,
                                                                                width: 30,
                                                                                height: 30),
                                                                          )),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        width:
                                                                            2.0),
                                                                  )),
                                                          ] else ...[
                                                            if (controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails!
                                                                    .isNotEmpty &&
                                                                controller.getChoiceList()[j].contains(controller
                                                                    .invoiceItem
                                                                    .value
                                                                    .lotteryDetails![
                                                                        i]
                                                                    .digit
                                                                    .toString()
                                                                    .substring(controller
                                                                            .invoiceItem
                                                                            .value
                                                                            .lotteryDetails![
                                                                                i]
                                                                            .digit
                                                                            .toString()
                                                                            .length -
                                                                        2)))
                                                              Container(
                                                                  height: 30.0,
                                                                  width: 30.0,
                                                                  child:
                                                                      Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              3),
                                                                          child:
                                                                              CircleAvatar(
                                                                            backgroundColor:
                                                                                Colors.transparent,
                                                                            radius:
                                                                                8,
                                                                            child: Image.asset(controller.getChoiceListImg()[j],
                                                                                fit: BoxFit.fill,
                                                                                width: 30,
                                                                                height: 30),
                                                                          )),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    border: Border.all(
                                                                        color: Colors
                                                                            .deepOrange,
                                                                        width:
                                                                            2.0),
                                                                  )),
                                                          ]
                                                        ],
                                                        const SizedBox(
                                                            width: 4),
                                                        Text(
                                                          controller
                                                              .invoiceItem
                                                              .value
                                                              .lotteryDetails![
                                                                  i]
                                                              .digit
                                                              .toString(),
                                                          style:
                                                              OptionTextStyle()
                                                                  .optionStyle(
                                                                      null,
                                                                      null,
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                          Text(
                                            controller.invoiceItem.value
                                                    .lotteryDetails![i].amount
                                                    .toString()
                                                    .isEmpty
                                                ? '0'
                                                : PriceConverter
                                                    .convertPriceNoCurrency(
                                                        double.parse(controller
                                                            .invoiceItem
                                                            .value
                                                            .lotteryDetails![i]
                                                            .amount
                                                            .toString())),
                                            style: OptionTextStyle()
                                                .optionStyle(null, null,
                                                    FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: const Divider(height: 1.5, color: Colors.black),
              ),
              buildTotalResult(),
              Container(
                margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: const Divider(height: 1, color: Colors.black),
              ),
              const Gap(8),
              buildFooter(),
              const Gap(24)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBillSuccessful() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Translates.SUCCESS.tr,
          style: robotoBold.copyWith(fontSize: 16.sp, color: Colors.white),
        ),
        FadeAnimation(
          0.5,
          Icon(Icons.check_circle, color: Colors.white, size: 32),
        ),
      ],
    );
  }

  Widget buildBillSuccessfulDateTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Translates.TIME.tr,
          style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            '${controller.invoiceItem.value.orderDate != null ? DateConverter.dateToTime(controller.invoiceItem.value.orderDate) : 0}',
            style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
          ),
        ),
        SizedBox(width: 8),
        Text(
          Translates.DATE.tr,
          style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            ' ${controller.invoiceItem.value.orderDate != null ? DateConverter.dateTimeDashToDateOnly(controller.invoiceItem.value.orderDate.toString()) : 0}',
            style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildBillSuccessfulDrawDateTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Translates.DRAW.tr,
          style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            '${controller.invoiceItem.value.drawId}',
            style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
          ),
        ),
        SizedBox(width: 8),
        Text(
          Translates.RESULT_DATE.tr,
          style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            '${DateConverter.dateTimeDashToDateOnly(controller.invoiceItem.value.drawDate.toString())}',
            style: robotoBold.copyWith(fontSize: 12.sp, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildTableLine() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: const Divider(color: Colors.black),
    );
  }

  Widget buildTableHeader() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Translates.LUCKY_NUMBER.tr, style: robotoBold),
                Text(Translates.LUCKY_NUMBER_QUANTITY.tr, style: robotoBold),
              ],
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(Translates.LUCKY_NUMBER.tr, style: robotoBold),
                Text(Translates.LUCKY_NUMBER_QUANTITY.tr, style: robotoBold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalResult() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${Translates.LUCKY_NUMBER_AMOUNT.tr} ${controller.invoiceItem.value.lotteryDetails!.length} ${Translates.LUCKY_NUMBER_UNIT.tr}',
            style: robotoBold,
          ),
          Text(
            Translates.TOTAL_AMOUNT.tr +
                PriceConverter.convertPriceNoCurrency(
                  double.parse(
                      controller.invoiceItem.value.totalAmount.toString()),
                ),
            style: robotoBold,
          )
        ],
      ),
    );
  }

  Widget buildFooter() {
    return Container(
      margin: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
              '${Translates.BILL_NUMBER.tr}${controller.invoiceItem.value.billNumber}'),
          Text(
              '${Translates.LOTTERY_BILL_NUMBER.tr}${controller.invoiceItem.value.paymentReference}'),
          Text('${Translates.PAY_BY.tr}${controller.invoiceItem.value.payBy}'),
          Text('${'contact'.tr}030 5494222, 021 330710'),
        ],
      ),
    );
  }
}
