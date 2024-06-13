import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/buy_lottery/buy_lottery_controller.dart';
import 'package:scn_easy/generated/assets.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../languages/translates.dart';

class EditNumberWidget extends StatelessWidget {
  const EditNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: GetBuilder<BuyLotteryController>(builder: (state) {
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Text(
                  Translates.EDIT_NUMBER.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Stack(
                children: [
                  Image(
                    image: AssetImage(Assets.imagesScnBackground),
                    fit: BoxFit.fill,
                    height: 100,
                    width: Get.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    child: Container(
                      height: 60,
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.newDesignInputBg),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: TextFormField(
                        controller: state.txtEditNumber,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 8),
                        ),
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 10, right: 20, left: 20),
                margin: EdgeInsets.all(6),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              Translates.BUTTON_CANCEL.tr,
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeExtraLarge1,
                                color: Colors.white,
                              ),
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
                          state.editNumberFormCart(
                            state.selectedIndex.value,
                            state.txtEditNumber.text,
                          );
                          state.txtEditNumber.clear();
                          Get.back();
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              Translates.BUTTON_OK.tr,
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge1,
                                  color: Colors.white),
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
