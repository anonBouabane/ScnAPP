import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../base/message_alert_message.dart';

class LottoChangeReferralNumber extends StatelessWidget {
  const LottoChangeReferralNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<LotteryController>(builder: (lotCtrl) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                    ),
                    child: Text('ໃສ່ເລກແນະນຳ'.tr,
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge1,
                            color: Colors.white),
                        textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.inputBg),
                              fit: BoxFit.fill)),
                      child: TextFormField(
                        controller: lotCtrl.referralCode.value,
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeOverLarge),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8, horizontal: 2)),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 6.0, bottom: 6, right: 20, left: 20),
                    margin: EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              // lotCtrl.onDialogCancel();
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.shade700,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'cancel'.tr,
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge1,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              if (lotCtrl.referralCode.value.text.isEmpty) {
                                showDialog(
                                    context: Get.context!,
                                    builder: (context) => MessageAlertMsg(
                                        'error',
                                        'ປ້ອນເລກແນະນຳກ່ອນ',
                                        Icons.error_outline,
                                        Colors.red));
                              } else {
                                var response = await lotCtrl.saveRewardId(
                                    Get.find<AuthController>().getUserNumber(),
                                    lotCtrl.referralCode.value.text.trim());
                                if (response) {
                                  Get.back();
                                }
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'ok'.tr,
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
                  )
                ],
              ),
            );
          })),
    );
  }
}
