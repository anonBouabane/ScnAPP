import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../models/invoice_model.dart';
import '../../routes/app_pages.dart';
import '../../widgets/no_item_found_widget.dart';
import 'invoice_result_controller.dart';

class InvoiceHistoryView extends GetView<InvoiceResultController> {
  const InvoiceHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          controller.offsetInvoice.value = 0;
          controller.limitInvoice.value = controller.pageSizeInvoice.value;
          controller.pagingInvoiceController.itemList!.clear();
          await controller.loadInvoices(0);
        },
        child: OverlayLoaderWithAppIcon(
          isLoading: controller.invoiceLoading.value,
          appIcon: Image.asset(Assets.newDesignLoadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: CustomScrollView(
            slivers: [
              PagedSliverList<int, InvoiceItem>.separated(
                pagingController: controller.pagingInvoiceController,
                builderDelegate: PagedChildBuilderDelegate<InvoiceItem>(
                  animateTransitions: true,
                  itemBuilder: (context, item, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              color: Colors.red.shade800,
                            ),
                            child: Center(
                              child: Text(
                                '${item.drawResult == null ? Translates.DRAW_DATE.tr : Translates.APP_TITLE_LOTTERY_RESULT.tr} ${DateConverter.dateToDateOnly(item.drawDate)}',
                                style: robotoBold.copyWith(
                                  color: Colors.white,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (item.winStatus != null &&
                                      item.winStatus == true) {
                                    Get.toNamed(Routes.INVOICE_WON,
                                        arguments: item);
                                  } else {
                                    Get.toNamed(Routes.INVOICE_DETAIL,
                                        arguments: item);
                                  }
                                },
                                child: Container(
                                  decoration:
                                      BoxDecoration(color: Colors.white),
                                  padding: EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      buildPaymentBuildTextRich(item),
                                      buildPaymentByTextRich(item),
                                      buildInvoiceDetail(item),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: item.winStatus != null &&
                                        item.winStatus == true
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        color: Colors.green,
                                        size: 30,
                                      )
                                    : SizedBox.shrink(),
                              ),
                            ],
                          ),
                          buildInvoiceResultTotalMoney(item),
                        ],
                      ),
                    );
                  },
                  noItemsFoundIndicatorBuilder: (_) => NoItemFoundWidget(),
                ),
                separatorBuilder: (_, __) => SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPaymentBuildTextRich(InvoiceItem item) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: Translates.LOTTERY_BILL_NUMBER.tr,
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                ),
              ),
              TextSpan(
                text: '${item.billNumber}',
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Text(
            ' ${DateConverter.dateToDateAndTime1(item.orderDate)}',
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPaymentByTextRich(InvoiceItem item) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: 'pay_by'.tr,
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ),
          ),
          TextSpan(
            text: '${item.payBy}',
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeSmall,
            ),
          )
        ],
      ),
    );
  }

  Widget buildInvoiceDetail(InvoiceItem item) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 0.8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: item.lotteryDetails!.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, i) {
          return Container(
            width: Get.width / 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: item.lotteryDetails![i].winStatus!
                    ? Colors.green.shade800
                    : Colors.grey.shade300,
              ),
              color: item.lotteryDetails![i].winStatus!
                  ? Colors.green.shade50
                  : Colors.white,
            ),
            child: Text(
              '${item.lotteryDetails![i].digit}',
            ),
          );
        },
      ),
    );
  }

  Widget buildInvoiceResultTotalMoney(InvoiceItem item) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Container(
        height: 20,
        width: Get.width,
        margin: EdgeInsets.only(bottom: 3, top: 3, left: 2, right: 2),
        padding: EdgeInsets.only(right: 10),
        alignment: Alignment.bottomRight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.newDesignInvoiceBottomBg),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Text.rich(
          TextSpan(
            children: <InlineSpan>[
              TextSpan(
                text: "total".tr,
                style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Colors.red.shade600),
              ),
              TextSpan(
                text:
                    ' ${PriceConverter.convertPriceCurrency(double.parse(item.totalAmount.toString()))}',
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeLarge,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
