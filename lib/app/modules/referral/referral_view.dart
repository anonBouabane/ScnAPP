import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

import '../../languages/translates.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/error_alert_widget.dart';
import 'referral_controller.dart';

class ReferralView extends GetView<ReferralController> {
  const ReferralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ໃສ່ເລກແນະນໍາ'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          BackgroundWidget(),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.inputBg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.txtReferralCode,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 6.0,
                    bottom: 6,
                    right: 20,
                    left: 20,
                  ),
                  margin: EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            height: 50,
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.redAccent.shade700,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                Translates.BUTTON_CANCEL.tr,
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
                            if (controller.txtReferralCode.text.isEmpty) {
                              Get.dialog(
                                ErrorAlertWidget(
                                  message: 'ປ້ອນເລກແນະນຳກ່ອນ',
                                ),
                              );
                            } else {
                              await controller.saveRewardId();
                              if (controller.isSaveSuccess.isTrue) {
                                Get.back(result: true);
                              }
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              top: 10,
                              bottom: 10,
                            ),
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                Translates.BUTTON_OK.tr,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
