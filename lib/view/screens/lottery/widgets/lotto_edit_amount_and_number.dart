import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LottoEditAmountAndNumber extends StatelessWidget {
  final int amount;
  final int index;
  final bool isNumber;

  const LottoEditAmountAndNumber(this.amount, this.index, {this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<LotteryController>(builder: (lotCtrl) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red.shade800,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                ),
                child: Text(isNumber ? 'edit_number'.tr : 'edit_amount'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Colors.white), textAlign: TextAlign.center),
              ),
              Stack(
                children: [
                  Image(image: AssetImage(Images.scnBackgroundPng), fit: BoxFit.fill, height: 100, width: MediaQuery.of(context).size.width),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0, right: 18),
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.inputBg), fit: BoxFit.fill)),
                      child: TextFormField(
                        controller: isNumber ? lotCtrl.editNumberCtrl.value : lotCtrl.editAmountCtrl.value,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        decoration: InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.only(top: 8)),
                        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 20, left: 20),
                margin: EdgeInsets.all(6),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'cancel'.tr,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (isNumber) {
                            lotCtrl.editNumberInCart(index);
                          } else {
                            lotCtrl.editAmountInCart(index);
                          }
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'ok'.tr,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
