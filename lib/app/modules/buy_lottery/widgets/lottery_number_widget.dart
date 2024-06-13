import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../languages/translates.dart';
import '../../../models/cart.dart';
import '../buy_lottery_controller.dart';
import 'edit_amount_widget.dart';
import 'edit_number_widget.dart';

class LotteryNumberWidget extends GetView<BuyLotteryController> {
  const LotteryNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        margin: const EdgeInsets.only(bottom: 150),
        child: Column(
          children: [
            buildBuyLotteryTitle(),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              controller: controller.scrollController,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Cart item = controller.cartController.carts[index];
                return Container(
                  padding: const EdgeInsets.only(left: 28),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 40.0,
                        width: 40.0,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 10,
                            child: Image.asset(
                              item.houb,
                              fit: BoxFit.fill,
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepOrange,
                            width: 2.0,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.selectedIndex.value = index;
                            controller.txtEditNumber.text =
                                item.number.toString();
                            Get.dialog(EditNumberWidget());
                            controller.update();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              item.number,
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          controller.selectedIndex.value = index;
                          controller.txtEditAmount.text =
                              item.amount.toString();
                          Get.dialog(EditAmountWidget());
                          controller.update();
                        },
                        child: Text(
                          controller.cartController.carts.isEmpty
                              ? '0'
                              : PriceConverter.convertPriceNoCurrency(
                                  double.parse(item.amount.toString())),
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      InkWell(
                        onTap: () => controller.removeFromCart(index),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 8, right: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.redAccent.shade700,
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                      SizedBox(width: 25),
                    ],
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: controller.cartController.carts.length,
            ),
            SizedBox(height: 40),
          ],
        ),
      );
    });
  }

  Widget buildBuyLotteryTitle() {
    return Container(
      height: 50,
      decoration: BoxDecoration(color: Colors.red.shade800),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 28.0),
            child: Text(
              Translates.BUY_LOTTERY_LIST_TITLE.tr,
              style: robotoBold.copyWith(
                color: Colors.white,
                fontSize: Dimensions.fontSizeExtraLarge1,
              ),
            ),
          ),
          Row(
            children: [
              Text(
                Translates.BUY_LOTTERY_LIST_QUANTITY.tr,
                style: robotoBold.copyWith(
                  color: Colors.white,
                  fontSize: Dimensions.fontSizeExtraLarge1,
                ),
              ),
              SizedBox(width: 15),
              GestureDetector(
                onTap: () => controller.clearAllNumberList(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white,
                  ),
                  child: Icon(Icons.clear, color: Colors.red, size: 25),
                ),
              ),
              SizedBox(width: 25),
            ],
          )
        ],
      ),
    );
  }
}
