import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:scn_easy/controller/lottery_controller.dart';

import '../../../../helper/responsive_helper.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../controller/auth_controller.dart';
import '../../data/model/body/m_money.dart';

class MMoneyConfirmDialog extends StatelessWidget {
  final MMoneyCashOutBody request;

  const MMoneyConfirmDialog({Key? key, required this.request})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(),
      body: SafeArea(
        child: GetBuilder<LotteryController>(
          builder: (lotCtrl) {
            return Container(
              margin: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 40),
                  Text("confirm_with_otp".tr, style: robotoBold),
                  SizedBox(height: 10),
                  Text("please_enter_6_digit_code".tr, style: robotoRegular),
                  Text("${Get.find<AuthController>().getUserNumber()}",
                      style: robotoBold),
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveHelper.isTab(context) ? 200 : 8,
                        vertical: 8),
                    // padding: const EdgeInsets.symmetric(horizontal: 39, vertical: 35),
                    child: PinCodeTextField(
                      length: 6,
                      appContext: context,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.slide,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 50,
                        fieldWidth: 50,
                        borderWidth: 1,
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_SMALL),
                        selectedColor: Theme.of(context).primaryColor,
                        selectedFillColor: Colors.white,
                        inactiveFillColor: Colors.grey.shade100,
                        inactiveColor: Theme.of(context).primaryColor,
                        activeColor: Theme.of(context).primaryColor,
                        activeFillColor: Colors.white,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: Colors.transparent,
                      enableActiveFill: true,
                      onChanged: lotCtrl.updateVerificationCode,
                      beforeTextPaste: (text) => true,
                    ),
                  ),
                  lotCtrl.cashOutLoading
                      ? Align(
                          alignment: Alignment.center,
                          child: Center(child: CircularProgressIndicator()))
                      : Container(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () async {
                                    request.otp = lotCtrl.verificationCode;

                                    if (kDebugMode) {
                                      Logger()
                                          .d("request:: ${request.toJson()}");
                                    }

                                    var response =
                                        await lotCtrl.mMoneyCashOut(request);
                                    if (response) {
                                      Get.back();
                                      await lotCtrl.getInvoiceDetail(
                                          "${Get.find<AuthController>().getUserNumber()}",
                                          "${request.topUpTransactionId}");

                                      if (kDebugMode) {
                                        Logger()
                                            .d("CashOut complete::: $response");
                                      }
                                      // Get.back();
                                      // var completeResp = await lotCtrl.topUp(request.topUpTransactionId.toString());
                                      // Get.to(() => TopUpCompleteScreen(response: completeResp, fromMMoney: true));
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red.shade500,
                                      borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(8.0),
                                          bottomLeft: Radius.circular(8.0)),
                                    ),
                                    child: Text('ok'.tr,
                                        style: robotoRegular.copyWith(
                                            fontSize: 18, color: Colors.white),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
