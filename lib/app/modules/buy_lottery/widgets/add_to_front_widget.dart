import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';

import '../../../../util/textStyle.dart';
import '../buy_lottery_controller.dart';

class AddToFrontWidget extends GetView<BuyLotteryController> {
  const AddToFrontWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ຕື່ມຫຼັກ',
              style: OptionTextStyle().optionStyle(24, null, FontWeight.bold),
            ),
            Container(
              padding: const EdgeInsets.only(top: 8, left: 8.0, right: 8.0),
              child: Text(
                'ຖ້າທ່ານມີເລກ "91,51,11" ຖ້າຕື່ມເລກ 8 ໃສ່ຈະກາຍເປັນ "891,851,811',
                style: OptionTextStyle().optionStyle(),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: TextField(
                controller: controller.txtLeadingNumber,
                autofocus: true,
                style: OptionTextStyle().optionStyle(),
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        // Navigator.of(context).pop(false);
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade500,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(15.0)),
                        ),
                        child: Text(
                          Translates.BUTTON_CANCEL.tr,
                          style: OptionTextStyle()
                              .optionStyle(null, Colors.white, FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        controller.isOpenAddFrontNumber.value = true;
                        List<String> tempData = [];
                        for (int i = 0;
                            i <
                                controller.txtUpdateNumber.text
                                    .split(',')
                                    .length;
                            i++) {
                          tempData.add(controller.txtLeadingNumber.text +
                              controller.txtUpdateNumber.text.split(',')[i]);
                        }
                        controller.txtUpdateNumber.text = tempData.join(',');
                        Get.back();
                        controller.txtLeadingNumber.clear();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(15.0)),
                        ),
                        child: Text(
                          Translates.BUTTON_OK.tr,
                          style: OptionTextStyle()
                              .optionStyle(null, Colors.white, FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
