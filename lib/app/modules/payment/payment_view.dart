import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/util/utils.dart';

import '../../languages/translates.dart';
import '../../widgets/error_alert_widget.dart';
import 'buy_lottery_body.dart';
import 'payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
        title: Text(
          Translates.APP_TITLE_PAYMENT.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        ),
      ),
      body: Obx(() {
        return OverlayLoaderWithAppIcon(
          isLoading: controller.isBuyLoading.value,
          appIcon: Image.asset(Assets.newDesignLoadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: Stack(
            children: [
              Image(
                image: AssetImage(Assets.imagesScnBackground),
                fit: BoxFit.fill,
                width: Get.width,
                height: Get.height,
              ),
              SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              Assets.newDesignLottoLogo,
                              height: 100,
                              width: 100,
                            ),
                            Image.asset(
                              Assets.newDesignScnLottoLogo,
                              height: 80,
                              width: 140,
                              fit: BoxFit.fill,
                            ),
                          ]),
                    ),
                    Text(
                      'ເງິນລາງວັນຈະຖຶກມອບເຂົ້າບັນຊີທີ່ທ່ານຊຳລະ'.tr,
                      style: robotoBold.copyWith(
                        color: Colors.red.shade800,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                    SizedBox(height: 6),

                    /// Show/Hide TextFormField Referral
                    if (controller.isShowReferralTextFormField.value) ...[
                      Text(
                        Translates.ENTER_YOUR_REFERRAL_CODE_IF_EXIST.tr,
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge.sp,
                        ),
                      ),
                      SizedBox(height: 6),
                      buildReferralTextFormField(context),
                    ],
                    buildButtonPayByPoint(),
                    SizedBox(height: 20),
                    Text(
                      Translates.BUTTON_PAY_BY_MONEY.tr,
                      style: robotoBold.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade900,
                      ),
                    ),
                    GridView(
                      padding: EdgeInsets.only(left: 40, right: 40, top: 12),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 2.5,
                      ),
                      children: [
                        buildButtonBCELBankPayment(),
                        buildButtonLDBBankPayment(),
                        buildButtonAPBBankPayment(),
                        buildButtonJDBBankPayment(),
                        buildButtonLVBBankPayment(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildReferralTextFormField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 40.0,
        right: 40,
        bottom: 20,
      ),
      child: TextField(
        onTap: () {
          // showDialog(
          //   barrierDismissible: false,
          //   context: context,
          //   builder: (context) =>
          //       LottoChangeReferralNumber(),
          // );
        },
        controller: controller.txtReferralCode,
        textAlign: TextAlign.center,
        readOnly: true,
        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
        textCapitalization: TextCapitalization.none,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          counter: SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 0,
                color: Theme.of(context).primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              width: 0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          isDense: true,
          filled: true,
          hintText: '',
          fillColor: Theme.of(context).cardColor,
          hintStyle: robotoRegular.copyWith(
            fontSize: Dimensions.fontSizeLarge,
            color: Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }

  Widget buildButtonPayByPoint() {
    return InkWell(
      onTap: () async {
        if (controller.userController.userInfoModel.accountNo != null) {
          final response = await controller.buyingLottery();
          if (response != null) {
            controller.payByPoint(ticketId: response.ticketId.toString());
          }
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40),
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.newDesignButtonBg),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Text(
              Translates.BUTTON_PAY_BY_POINT.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: Colors.white,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Translates.POINT_THAT_YOU_HAVE.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '0',
                    // '${controller.pointModel.value != null ? PriceConverter.convertPriceNoCurrencyByThin(controller.pointModel.value!.balance.toString()) : 0}',
                    style: robotoBold.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  Translates.POINTS.tr,
                  style: robotoBold.copyWith(
                    color: Colors.white,
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildButtonBCELBankPayment() {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('BCEL index 1');
          Logger().i(controller.bankList[1].toJson());
        }

        if (controller.bankList.isNotEmpty) {
          if (controller.bankList[1].bankId == 3) {
            controller.onePayMCID.value =
                controller.bankList[1].mcId.toString();
            final response = await controller.buyingLottery();
            if (response != null) {
              BuyLotteryBody request = BuyLotteryBody();
              // request.amount = 1;
              request.amount = response.totalAmount;
              request.companyId = 1;
              request.transactionNo = response.ticketId;
              request.payFor = 'LOTTERY';
              request.bankId = 3;
              request.custPhone =
                  controller.userController.userInfoModel.phone!;
              controller.submitPayment(request);
              if (controller.rewardModel.value != null &&
                  controller.rewardModel.value!.expAt != null &&
                  int.parse(DateConverter.dateToDate(kCurrentDate)
                          .replaceAll('-', '')
                          .trim()) >=
                      int.parse(DateConverter.dateToDate(
                              controller.rewardModel.value!.expAt!)
                          .replaceAll("-", "")
                          .trim())) {
                if (controller.txtReferralCode.text.isNotEmpty) {
                  controller.saveRewardId(
                    controller.userController.userInfoModel.phone!,
                    controller.txtReferralCode.text,
                  );
                }
              }
            }
          }
        } else {
          Get.dialog(
              ErrorAlertWidget(message: 'ບໍ່ມີລາຍການ Payment ກາລຸນາລອງໃໝ່'));
        }
      },
      child: Image.asset(Assets.imagesPaymentButtonBcel, fit: BoxFit.fitHeight),
    );
  }

  Widget buildButtonLDBBankPayment() {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('LDB index 0');
          Logger().i(controller.bankList[0].toJson());
        }

        /// if debug is uat else prod
        if (kDebugMode) {
          if (controller.bankList.isNotEmpty) {
            if (controller.bankList[0].bankId == 21) {
              bool isRewardIdExpired = false;
              if (controller.rewardModel.value!.expAt != null) {
                isRewardIdExpired = int.parse(
                        DateConverter.dateToDate(kCurrentDate)
                            .replaceAll('-', '')
                            .trim()) >=
                    int.parse(DateConverter.dateToDate(
                            controller.rewardModel.value!.expAt!)
                        .replaceAll('-', '')
                        .trim());
              }

              final response = await controller.buyingLottery();
              if (response != null) {
                BuyLotteryBody request = BuyLotteryBody();
                // request.amount = 1;
                request.amount = response.totalAmount;
                request.companyId = 1;
                request.transactionNo = response.ticketId;
                request.payFor = 'LOTTERY';
                request.bankId = 21;
                request.custPhone =
                    controller.userController.userInfoModel.phone!;

                controller.submitPayment(request);
                if (isRewardIdExpired) {
                  controller.saveRewardId(
                    controller.userController.userInfoModel.phone!,
                    controller.txtReferralCode.text,
                  );
                }
              }
            }
          } else {
            Get.dialog(
                ErrorAlertWidget(message: 'ບໍ່ມີລາຍການ Payment ກາລຸນາລອງໃໝ່'));
          }
        } else {
          Get.dialog(ErrorAlertWidget(message: 'LDB Coming soon...'));
        }
      },
      child: Image.asset(Assets.imagesPaymentButtonLdb, fit: BoxFit.fitHeight),
    );
  }

  Widget buildButtonAPBBankPayment() {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('APB index 2');
          Logger().i(controller.bankList[2].toJson());
        }

        // if (controller.bankList.isNotEmpty) {
        //   if (controller.bankList[2].bankId == 2) {
        //     bool isRewardIdExpired = false;
        //     if (controller.rewardModel.value!.expAt != null) {
        //       isRewardIdExpired = int.parse(DateConverter.dateToDate(kCurrentDate).replaceAll('-', '').trim()) >=
        //           int.parse(DateConverter.dateToDate(controller.rewardModel.value!.expAt!).replaceAll('-', '').trim());
        //     }
        //     final response = await controller.buyingLottery();
        //     if (response != null) {
        //       BuyLotteryBody request = BuyLotteryBody();
        //       // request.amount = 1;
        //       request.amount = response.totalAmount;
        //       request.companyId = 1;
        //       request.transactionNo = response.ticketId;
        //       request.payFor = 'LOTTERY';
        //       request.bankId = 2;
        //       request.custPhone = controller.userController.userInfoModel.phone!;
        //
        //       controller.submitPayment(request);
        //       if (isRewardIdExpired) {
        //         controller.saveRewardId(
        //           controller.userController.userInfoModel.phone!,
        //           controller.txtReferralCode.text,
        //         );
        //       }
        //     }
        //   }
        // } else {
        //   Get.dialog(
        //       ErrorAlertWidget(message: 'ບໍ່ມີລາຍການ Payment ກາລຸນາລອງໃໝ່'));
        // }

        Get.dialog(ErrorAlertWidget(message: 'APB Coming soon...'));
      },
      child: Image.asset(Assets.imagesPaymentButtonApb, fit: BoxFit.fitHeight),
    );
  }

  Widget buildButtonJDBBankPayment() {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          Logger().i('JDB index 3');
          Logger().i(controller.bankList[3].toJson());
        }

        Get.dialog(ErrorAlertWidget(message: 'JDB Coming soon...'));
      },
      child: Image.asset(Assets.imagesPaymentButtonJdb, fit: BoxFit.fitHeight),
    );
  }

  Widget buildButtonLVBBankPayment() {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('LVB index 4');
          Logger().i(controller.bankList[4].toJson());
        }

        /// if debug is uat else prod
        if (kDebugMode) {
          if (controller.bankList.isNotEmpty) {
            if (controller.bankList[4].bankId == 4) {
              bool isRewardIdExpired = false;
              if (controller.rewardModel.value!.expAt != null) {
                isRewardIdExpired = int.parse(
                        DateConverter.dateToDate(kCurrentDate)
                            .replaceAll('-', '')
                            .trim()) >=
                    int.parse(DateConverter.dateToDate(
                            controller.rewardModel.value!.expAt!)
                        .replaceAll('-', '')
                        .trim());
              }

              final response = await controller.buyingLottery();
              if (response != null) {
                BuyLotteryBody request = BuyLotteryBody();
                // request.amount = 1;
                request.amount = response.totalAmount;
                request.companyId = 1;
                request.transactionNo = response.ticketId;
                request.payFor = 'LOTTERY';
                request.bankId = 4;
                request.custPhone =
                    controller.userController.userInfoModel.phone!;

                controller.submitPayment(request);
                if (isRewardIdExpired) {
                  controller.saveRewardId(
                    controller.userController.userInfoModel.phone!,
                    controller.txtReferralCode.text,
                  );
                }
              }
            }
          } else {
            Get.dialog(
                ErrorAlertWidget(message: 'ບໍ່ມີລາຍການ Payment ກາລຸນາລອງໃໝ່'));
          }
        } else {
          Get.dialog(ErrorAlertWidget(message: 'LVB Coming soon...'));
        }
      },
      child: Image.asset(Assets.imagesPaymentButtonLvb, fit: BoxFit.fitHeight),
    );
  }
}
