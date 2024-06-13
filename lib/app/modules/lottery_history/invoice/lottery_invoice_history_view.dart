import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_controller.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_model.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/screens/lottery/lottery_history/lotto_invoice_detail.dart';
import 'package:scn_easy/view/screens/lottery/lottery_history/lotto_invoice_won_detail.dart';
import 'package:scn_easy/view/screens/lottery/widgets/no_items_found_widget.dart';

class LotteryInvoiceHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryInvoiceHistoryController>(
      init: LotteryInvoiceHistoryController(),
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
                await controller.loadLotteryHistories(0);
              },
              child: CustomScrollView(
                slivers: [
                  PagedSliverList<int, LotteryInvoiceHistoryItem>.separated(
                    pagingController: controller.pagingController,
                    builderDelegate:
                        PagedChildBuilderDelegate<LotteryInvoiceHistoryItem>(
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
                                    "${item.drawResult == null ? "draw_date".tr : "lotteryResult".tr} ${DateConverter.dateToDateOnly(item.drawDate)}",
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
                                        Get.to(() => LottoInvoiceWonDetail(
                                            invoice: item));
                                      } else {
                                        Get.to(() => LotteryHistoryDetail(
                                            invoice: item));
                                      }
                                    },
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      padding: EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                      noItemsFoundIndicatorBuilder: (_) => NoItemsFoundWidget(),
                    ),
                    separatorBuilder: (_, __) => SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildPaymentBuildTextRich(LotteryInvoiceHistoryItem item) {
    return Row(
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: "lotto_bill_no".tr,
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

  Widget buildPaymentByTextRich(LotteryInvoiceHistoryItem item) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: "pay_by".tr,
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

  Widget buildInvoiceDetail(LotteryInvoiceHistoryItem item) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 2 / 0.8,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: item.lotteryHistoryDetails!.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext ctx, i) {
          return Container(
            width: Get.width / 3,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: item.lotteryHistoryDetails![i].winStatus!
                    ? Colors.green.shade800
                    : Colors.grey.shade300,
              ),
              color: item.lotteryHistoryDetails![i].winStatus!
                  ? Colors.green.shade50
                  : Colors.white,
            ),
            child: Text(
              "${item.lotteryHistoryDetails![i].digit}",
            ),
          );
        },
      ),
    );
  }

  Widget buildInvoiceResultTotalMoney(LotteryInvoiceHistoryItem item) {
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
            image: AssetImage(Images.invoiceBottomBg),
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
