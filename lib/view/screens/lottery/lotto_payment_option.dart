import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/services/telegram_service.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../controller/lottery_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../data/model/body/lotto_buy_number.dart';
import '../../../data/model/body/lotto_laoviet_payment.dart';
import '../../../util/images.dart';
import '../../../util/utils.dart';
import '../../base/message_alert_message.dart';
import 'widgets/lotto_change_referral_number.dart';

class LottoPaymentOption extends StatefulWidget {
  final LottoBuyNumber lottoData;

  const LottoPaymentOption({Key? key, required this.lottoData})
      : super(key: key);

  @override
  State<LottoPaymentOption> createState() => _LottoPaymentOptionState();
}

class _LottoPaymentOptionState extends State<LottoPaymentOption> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      Logger().i('----- Lotto Payment Option');
      Logger().i('lottoData: ${widget.lottoData.toJson()}');
    }
    if (Get.find<LotteryController>().paymentOption.isEmpty) {
      Get.find<LotteryController>().getBankPaymentOptions();
    }
    // Get.find<LotteryController>().getBankPaymentOptions();
    // Get.find<LotteryController>().getPoints(Get.find<AuthController>().getUserNumber());
    getDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        centerTitle: true,
        title: Text(
          'select_payment_options'.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        ),
      ),
      body: GetBuilder<LotteryController>(builder: (lotCtrl) {
        return OverlayLoaderWithAppIcon(
          isLoading: lotCtrl.buyLoading,
          appIcon: Image.asset(Images.loadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: Stack(
            children: [
              Image(
                image: AssetImage(Images.scnBackgroundPng),
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
                              Images.lottoLogo,
                              height: 100,
                              width: 100,
                            ),
                            Image.asset(
                              Images.scnLottoLogo,
                              height: 80,
                              width: 140,
                              fit: BoxFit.fill,
                            ),
                          ]),
                    ),
                    Text(
                      "ເງິນລາງວັນຈະຖຶກມອບເຂົ້າບັນຊີທີ່ທ່ານຊຳລະ",
                      style: robotoBold.copyWith(
                        color: Colors.red.shade800,
                        fontSize: Dimensions.fontSizeExtraLarge,
                      ),
                    ),
                    SizedBox(height: 6),
                    if (lotCtrl.lottoRewardIdResponse!.custId == 0 ||
                        int.parse(DateConverter.dateToDate(kCurrentDate)
                                .replaceAll("-", "")
                                .trim()) >=
                            int.parse(DateConverter.dateToDate(
                                    lotCtrl.lottoRewardIdResponse!.expAt!)
                                .replaceAll("-", "")
                                .trim())) ...[
                      Text(
                        "enter_your_referral_code_if_exist".tr,
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge.sp,
                        ),
                      ),
                      SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 40.0,
                          right: 40,
                          bottom: 20,
                        ),
                        child: TextField(
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) =>
                                    LottoChangeReferralNumber(),
                              );
                            },
                            controller: lotCtrl.referralCode.value,
                            textAlign: TextAlign.center,
                            readOnly: true,
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                            textCapitalization: TextCapitalization.none,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 8.0),
                              counter: SizedBox.shrink(),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 0),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 0,
                                    color: Theme.of(context).primaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                borderSide: BorderSide(
                                    style: BorderStyle.solid,
                                    width: 0,
                                    color: Theme.of(context).primaryColor),
                              ),
                              isDense: true,
                              hintText: '',
                              fillColor: Theme.of(context).cardColor,
                              hintStyle: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
                                  color: Theme.of(context).hintColor),
                              filled: true,
                            )),
                      ),
                    ] else if (lotCtrl.lottoRewardIdResponse!.rewardId !=
                        null) ...[
                      // Container(
                      //   decoration: BoxDecoration(color: Colors.redAccent.shade700, borderRadius: BorderRadius.circular(6)),
                      //   height: 120,
                      //   margin: EdgeInsets.only(left: 40, right: 40),
                      //   width: MediaQuery.of(context).size.width,
                      //   child: Center(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text("ທ່ານຖຶກແນະນຳໂດຍ", style: robotoBold.copyWith(color: Colors.white)),
                      //         Padding(
                      //           padding: const EdgeInsets.only(top: 4.0),
                      //           child: Text("${lotCtrl.lottoRewardIdResponse?.rewardId != null ? lotCtrl.lottoRewardIdResponse!.rewardId : ""}",
                      //               style: robotoBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeExtraLarge1)),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.only(left: 2.0, right: 2),
                      //           child: Text(
                      //               "ທ່ານສາມາດປ່ຽນຜູ້ແນະນຳໄດ້ຫຼັງຈາກວັນທີ່ ${lotCtrl.lottoRewardIdResponse?.expAt != null ? DateConverter.dateToDateWithDot(lotCtrl.lottoRewardIdResponse?.expAt) : ""}",
                      //               style: robotoBold.copyWith(color: Colors.white),
                      //               softWrap: true),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 15)
                    ],
                    buildButtonPayByPoint(lotCtrl),
                    SizedBox(height: 20),
                    Text(
                      'ຊໍາລະເງິນດ້ວຍ',
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
                        buildButtonBCELBankPayment(lotCtrl),
                        buildButtonLDBBankPayment(lotCtrl),
                        buildButtonAPBBankPayment(lotCtrl),
                        buildButtonJDBBankPayment(lotCtrl),
                        buildButtonLVBBankPayment(lotCtrl),
                      ],
                    ),
                    // ------- bcel one ------ //
                    // buildButtonPayByBCEL(lotCtrl),
                    // ------- ldb ------ //
                    // buildButtonPayByLDB(lotCtrl),
                    // ------- apb ------ //
                    // buildButtonPayByAPB(lotCtrl),
                    // ------- jdb ------ //
                    // buildButtonPayByJDB(lotCtrl),
                    // ------- lvb ------ //
                    // buildButtonPayByLVB(lotCtrl),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  /// Point payment button
  Widget buildButtonPayByPoint(LotteryController lotCtrl) {
    return InkWell(
      onTap: () async {
        // if (Get.find<UserController>().userInfoModel != null) {
        //   if (Get.find<UserController>().userInfoModel.accountNo == null ||
        //       Get.find<UserController>().userInfoModel.accountNo == "") {
        //     showDialog(
        //       barrierDismissible: false,
        //       context: Get.context!,
        //       builder: (context) => UpdateCustomerAccount(),
        //     );
        //   } else {
        //     widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
        //     var response = await lotCtrl.buyingLotto(
        //       widget.lottoData,
        //     );
        //     if (response != null) {
        //       lotCtrl.pointPayment(
        //         widget.lottoData.custPhone.toString(),
        //         response.ticketId.toString(),
        //       );
        //     }
        //   }
        // } else
        if (Get.find<UserController>().userInfoModel.accountNo != null) {
          widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
          var response = await lotCtrl.buyingLotto(
            widget.lottoData,
          );
          if (response != null) {
            lotCtrl.pointPayment(
              widget.lottoData.custPhone.toString(),
              response.ticketId.toString(),
            );
          }
        }
      },
      child: Container(
        // height: 70,
        margin: EdgeInsets.only(left: 40, right: 40),
        padding: EdgeInsets.only(top: 8, bottom: 8),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.buttonBg),
            fit: BoxFit.fill,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Column(
          children: [
            Text(
              "payment_by_point".tr,
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
                  "you_have".tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "${lotCtrl.pointModel != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointModel!.balance.toString())) : 0}",
                    style: robotoBold.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "points".tr,
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

  /// LDB olb payment button
  // Widget buildButtonPayByLDB(LotteryController lotCtrl) {
  //   return InkWell(
  //     onTap: () {
  //       if (kDebugMode) {
  //         Logger().i('LDB index 0');
  //         Logger().i(lotCtrl.paymentOption[0].toJson());
  //       }
  //       showDialog(
  //         context: context,
  //         builder: (context) => MessageAlertMsg(
  //           'error',
  //           "LDB Coming soon...",
  //           Icons.error_outline,
  //           Colors.red,
  //         ),
  //       );
  //     },
  //     child: Container(
  //       height: 68,
  //       margin: EdgeInsets.only(left: 40, right: 40, bottom: 4),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(Images.ldb),
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// BCEL olb payment button
  // Widget buildButtonPayByBCEL(LotteryController lotCtrl) {
  //   return InkWell(
  //     onTap: () async {
  //       if (kDebugMode) {
  //         Logger().i('BCEL index 1');
  //         Logger().i(lotCtrl.paymentOption[1].toJson());
  //       }
  //       if (lotCtrl.paymentOption.isNotEmpty) {
  //         if (lotCtrl.paymentOption[1].bankId == 3) {
  //           lotCtrl.setOnePayMCID(lotCtrl.paymentOption[1].mcId.toString());
  //           widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
  //           var response = await lotCtrl.buyingLotto(widget.lottoData);
  //           if (response != null) {
  //             LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
  //             // request.amount = 1;
  //             request.amount = response.totalAmount;
  //             request.companyId = 1;
  //             request.transactionNo = response.ticketId;
  //             request.payFor = "LOTTERY";
  //             request.bankId = 3;
  //             request.custPhone = widget.lottoData.custPhone;
  //             lotCtrl.bankPayment(request);
  //             if (lotCtrl.lottoRewardIdResponse != null &&
  //                 lotCtrl.lottoRewardIdResponse!.expAt != null &&
  //                 int.parse(DateConverter.dateToDate(kCurrentDate)
  //                         .replaceAll("-", "")
  //                         .trim()) >=
  //                     int.parse(DateConverter.dateToDate(
  //                             lotCtrl.lottoRewardIdResponse!.expAt!)
  //                         .replaceAll("-", "")
  //                         .trim())) {
  //               if (lotCtrl.referralCode.value.text.isNotEmpty) {
  //                 lotCtrl.saveRewardId(widget.lottoData.custPhone!,
  //                     lotCtrl.referralCode.value.text);
  //               }
  //             }
  //           }
  //         }
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (context) => MessageAlertMsg(
  //             'error',
  //             "ບໍ່ມີລາຍການ Payment, ກາລຸນາລອງໃໝ່",
  //             Icons.error_outline,
  //             Colors.red,
  //           ),
  //         );
  //       }
  //     },
  //     child: Container(
  //       height: 68,
  //       margin: EdgeInsets.only(left: 40, right: 40, bottom: 4),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(Images.bcel),
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// APB olb payment button
  // Widget buildButtonPayByAPB(LotteryController lotCtrl) {
  //   return InkWell(
  //     onTap: () async {
  //       if (kDebugMode) {
  //         Logger().i('APB index 2');
  //         Logger().i(lotCtrl.paymentOption[2].toJson());
  //       }
  //       // if (lotCtrl.paymentOption.isNotEmpty) {
  //       //   if (lotCtrl.paymentOption[2].bankId == 2) {
  //       //     widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
  //       //     bool isRewardIdExpired = false;
  //       //     if (lotCtrl.lottoRewardIdResponse!.expAt != null) {
  //       //       isRewardIdExpired = int.parse(DateConverter.dateToDate(kCurrentDate).replaceAll("-", "").trim()) >=
  //       //           int.parse(DateConverter.dateToDate(lotCtrl.lottoRewardIdResponse!.expAt!).replaceAll("-", "").trim());
  //       //     }
  //       //     var response = await lotCtrl.buyingLotto(widget.lottoData);
  //       //     if (response != null) {
  //       //       LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
  //       //       // request.amount = 1;
  //       //       request.amount = response.totalAmount;
  //       //       request.companyId = 1;
  //       //       request.transactionNo = response.ticketId;
  //       //       request.payFor = "LOTTERY";
  //       //       request.bankId = 2;
  //       //       request.custPhone = widget.lottoData.custPhone;
  //       //       lotCtrl.bankPayment(request);
  //       //       if (isRewardIdExpired) {
  //       //         lotCtrl.saveRewardId(widget.lottoData.custPhone!, lotCtrl.referralCode.value.text);
  //       //       }
  //       //     }
  //       //   }
  //       // } else {
  //       //   showDialog(context: context, builder: (context) => MessageAlertMsg('error', "ບໍ່ມີລາຍການ Payment", Icons.error_outline, Colors.red));
  //       // }
  //       showDialog(
  //         context: context,
  //         builder: (context) => MessageAlertMsg(
  //           'error',
  //           "APB Coming soon...",
  //           Icons.error_outline,
  //           Colors.red,
  //         ),
  //       );
  //     },
  //     child: Container(
  //       height: 68,
  //       margin: EdgeInsets.only(left: 40, right: 40, bottom: 4),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(Images.apb),
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// JDB olb payment button
  // Widget buildButtonPayByJDB(LotteryController lotCtrl) {
  //   return InkWell(
  //     onTap: () {
  //       if (kDebugMode) {
  //         Logger().i('JDB index 3');
  //         Logger().i(lotCtrl.paymentOption[3].toJson());
  //       }
  //       showDialog(
  //         context: context,
  //         builder: (context) => MessageAlertMsg(
  //           'error',
  //           "JDB Coming soon...",
  //           Icons.error_outline,
  //           Colors.red,
  //         ),
  //       );
  //     },
  //     child: Container(
  //       height: 68,
  //       margin: EdgeInsets.only(left: 40, right: 40, bottom: 4),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(Images.jdb),
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// LVB olb payment button
  // Widget buildButtonPayByLVB(LotteryController lotCtrl) {
  //   return InkWell(
  //     onTap: () async {
  //       if (kDebugMode) {
  //         Logger().i('LVB index 4');
  //         Logger().i(lotCtrl.paymentOption[4].toJson());
  //       }
  //       if (lotCtrl.paymentOption.isNotEmpty) {
  //         if (lotCtrl.paymentOption[4].bankId == 4) {
  //           widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
  //           bool isRewardIdExpired = false;
  //           if (lotCtrl.lottoRewardIdResponse!.expAt != null) {
  //             isRewardIdExpired = int.parse(
  //                     DateConverter.dateToDate(kCurrentDate)
  //                         .replaceAll("-", "")
  //                         .trim()) >=
  //                 int.parse(DateConverter.dateToDate(
  //                         lotCtrl.lottoRewardIdResponse!.expAt!)
  //                     .replaceAll("-", "")
  //                     .trim());
  //           }
  //
  //           if (kDebugMode) {
  //             Logger().i(widget.lottoData.toString());
  //           }
  //
  //           var response = await lotCtrl.buyingLotto(widget.lottoData);
  //           if (response != null) {
  //             LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
  //             // request.amount = 1;
  //             request.amount = response.totalAmount;
  //             request.companyId = 1;
  //             request.transactionNo = response.ticketId;
  //             request.payFor = "LOTTERY";
  //             request.bankId = 4;
  //             request.custPhone = widget.lottoData.custPhone;
  //
  //             if (kDebugMode) {
  //               Logger().i(request);
  //             }
  //
  //             lotCtrl.bankPayment(request);
  //             if (isRewardIdExpired) {
  //               lotCtrl.saveRewardId(
  //                 widget.lottoData.custPhone!,
  //                 lotCtrl.referralCode.value.text,
  //               );
  //             }
  //           }
  //         }
  //       } else {
  //         showDialog(
  //           context: context,
  //           builder: (context) => MessageAlertMsg(
  //             'error',
  //             "ບໍ່ມີລາຍການ Payment",
  //             Icons.error_outline,
  //             Colors.red,
  //           ),
  //         );
  //       }
  //       // showDialog(
  //       //   context: context,
  //       //   builder: (context) => MessageAlertMsg(
  //       //     'error',
  //       //     "Coming soon...",
  //       //     Icons.error_outline,
  //       //     Colors.red,
  //       //   ),
  //       // );
  //     },
  //     child: Container(
  //       height: 68,
  //       margin: EdgeInsets.only(left: 40, right: 40, bottom: 60),
  //       decoration: BoxDecoration(
  //         image: DecorationImage(
  //           image: AssetImage(Images.lvb),
  //           fit: BoxFit.contain,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// BCEL Payment Button
  Widget buildButtonBCELBankPayment(LotteryController lotCtrl) {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('BCEL index 1');
          Logger().i(lotCtrl.paymentOption[1].toJson());
        }

        if (lotCtrl.paymentOption.isNotEmpty) {
          if (lotCtrl.paymentOption[1].bankId == 3) {
            lotCtrl.setOnePayMCID(lotCtrl.paymentOption[1].mcId.toString());
            widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
            var response = await lotCtrl.buyingLotto(widget.lottoData);
            if (response != null) {
              LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
              // request.amount = 1;
              request.amount = response.totalAmount;
              request.companyId = 1;
              request.transactionNo = response.ticketId;
              request.payFor = "LOTTERY";
              request.bankId = 3;
              request.custPhone = widget.lottoData.custPhone;
              lotCtrl.bankPayment(request);
              if (lotCtrl.lottoRewardIdResponse != null &&
                  lotCtrl.lottoRewardIdResponse!.expAt != null &&
                  int.parse(DateConverter.dateToDate(kCurrentDate)
                          .replaceAll("-", "")
                          .trim()) >=
                      int.parse(DateConverter.dateToDate(
                              lotCtrl.lottoRewardIdResponse!.expAt!)
                          .replaceAll("-", "")
                          .trim())) {
                if (lotCtrl.referralCode.value.text.isNotEmpty) {
                  lotCtrl.saveRewardId(widget.lottoData.custPhone!,
                      lotCtrl.referralCode.value.text);
                }
              }
            }
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => MessageAlertMsg(
              'error',
              "ບໍ່ມີລາຍການ Payment, ກາລຸນາລອງໃໝ່",
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      },
      child: Image.asset(
        Assets.imagesPaymentButtonBcel,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  /// LDB Payment Button
  Widget buildButtonLDBBankPayment(LotteryController lotCtrl) {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('LDB index 0');
          Logger().i(lotCtrl.paymentOption[0].toJson());
        }

        /// if debug is uat else prod
        if (kDebugMode) {
          if (lotCtrl.paymentOption.isNotEmpty) {
            if (lotCtrl.paymentOption[0].bankId == 21) {
              widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
              bool isRewardIdExpired = false;
              if (lotCtrl.lottoRewardIdResponse!.expAt != null) {
                isRewardIdExpired = int.parse(
                        DateConverter.dateToDate(kCurrentDate)
                            .replaceAll("-", "")
                            .trim()) >=
                    int.parse(DateConverter.dateToDate(
                            lotCtrl.lottoRewardIdResponse!.expAt!)
                        .replaceAll("-", "")
                        .trim());
              }

              if (kDebugMode) {
                Logger().i(widget.lottoData.toString());
              }

              var response = await lotCtrl.buyingLotto(widget.lottoData);
              if (response != null) {
                LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
                // request.amount = 1;
                request.amount = response.totalAmount;
                request.companyId = 1;
                request.transactionNo = response.ticketId;
                request.payFor = "LOTTERY";
                request.bankId = 21;
                request.custPhone = widget.lottoData.custPhone;

                if (kDebugMode) {
                  Logger().i(request.toJson());
                  TelegramService.sendMessage(
                    customerPhone: request.custPhone!,
                    transactionNo: request.transactionNo!,
                    companyId: request.companyId!,
                    payFor: request.payFor!,
                    bankId: request.bankId!,
                    amount: request.amount!,
                  );
                }

                lotCtrl.bankPayment(request);
                if (isRewardIdExpired) {
                  lotCtrl.saveRewardId(
                    widget.lottoData.custPhone!,
                    lotCtrl.referralCode.value.text,
                  );
                }
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => MessageAlertMsg(
                'error',
                "ບໍ່ມີລາຍການ Payment",
                Icons.error_outline,
                Colors.red,
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => MessageAlertMsg(
              'error',
              "LDB Coming soon...",
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      },
      child: Image.asset(
        Assets.imagesPaymentButtonLdb,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  /// APB Payment Button
  Widget buildButtonAPBBankPayment(LotteryController lotCtrl) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          Logger().i('APB index 2');
          Logger().i(lotCtrl.paymentOption[2].toJson());
        }

        // if (lotCtrl.paymentOption.isNotEmpty) {
        //   if (lotCtrl.paymentOption[2].bankId == 2) {
        //     widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
        //     bool isRewardIdExpired = false;
        //     if (lotCtrl.lottoRewardIdResponse!.expAt != null) {
        //       isRewardIdExpired = int.parse(DateConverter.dateToDate(kCurrentDate).replaceAll("-", "").trim()) >=
        //           int.parse(DateConverter.dateToDate(lotCtrl.lottoRewardIdResponse!.expAt!).replaceAll("-", "").trim());
        //     }
        //     var response = await lotCtrl.buyingLotto(widget.lottoData);
        //     if (response != null) {
        //       LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
        //       // request.amount = 1;
        //       request.amount = response.totalAmount;
        //       request.companyId = 1;
        //       request.transactionNo = response.ticketId;
        //       request.payFor = "LOTTERY";
        //       request.bankId = 2;
        //       request.custPhone = widget.lottoData.custPhone;
        //       lotCtrl.bankPayment(request);
        //       if (isRewardIdExpired) {
        //         lotCtrl.saveRewardId(widget.lottoData.custPhone!, lotCtrl.referralCode.value.text);
        //       }
        //     }
        //   }
        // } else {
        //   showDialog(context: context, builder: (context) => MessageAlertMsg('error', "ບໍ່ມີລາຍການ Payment", Icons.error_outline, Colors.red));
        // }

        showDialog(
          context: context,
          builder: (context) => MessageAlertMsg(
            'error',
            "APB Coming soon...",
            Icons.error_outline,
            Colors.red,
          ),
        );
      },
      child: Image.asset(
        Assets.imagesPaymentButtonApb,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  /// JDB Payment Button
  Widget buildButtonJDBBankPayment(LotteryController lotCtrl) {
    return InkWell(
      onTap: () {
        if (kDebugMode) {
          Logger().i('JDB index 3');
          Logger().i(lotCtrl.paymentOption[3].toJson());
        }

        showDialog(
          context: context,
          builder: (context) => MessageAlertMsg(
            'error',
            "JDB Coming soon...",
            Icons.error_outline,
            Colors.red,
          ),
        );
      },
      child: Image.asset(
        Assets.imagesPaymentButtonJdb,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  /// LVB Payment Button
  Widget buildButtonLVBBankPayment(LotteryController lotCtrl) {
    return InkWell(
      onTap: () async {
        if (kDebugMode) {
          Logger().i('LVB index 4');
          Logger().i(lotCtrl.paymentOption[4].toJson());
        }

        /// if debug is uat else prod
        if (kDebugMode) {
          if (lotCtrl.paymentOption.isNotEmpty) {
            if (lotCtrl.paymentOption[4].bankId == 4) {
              widget.lottoData.rewardId = lotCtrl.referralCode.value.text;
              bool isRewardIdExpired = false;
              if (lotCtrl.lottoRewardIdResponse!.expAt != null) {
                isRewardIdExpired = int.parse(
                        DateConverter.dateToDate(kCurrentDate)
                            .replaceAll("-", "")
                            .trim()) >=
                    int.parse(DateConverter.dateToDate(
                            lotCtrl.lottoRewardIdResponse!.expAt!)
                        .replaceAll("-", "")
                        .trim());
              }
              if (kDebugMode) {
                Logger().i(widget.lottoData.toString());
              }
              var response = await lotCtrl.buyingLotto(widget.lottoData);
              if (response != null) {
                LottoLaoVietPaymentBody request = LottoLaoVietPaymentBody();
                // request.amount = 1;
                request.amount = response.totalAmount;
                request.companyId = 1;
                request.transactionNo = response.ticketId;
                request.payFor = "LOTTERY";
                request.bankId = 4;
                request.custPhone = widget.lottoData.custPhone;

                if (kDebugMode) {
                  Logger().i(request);
                }

                lotCtrl.bankPayment(request);
                if (isRewardIdExpired) {
                  lotCtrl.saveRewardId(
                    widget.lottoData.custPhone!,
                    lotCtrl.referralCode.value.text,
                  );
                }
              }
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => MessageAlertMsg(
                'error',
                "ບໍ່ມີລາຍການ Payment",
                Icons.error_outline,
                Colors.red,
              ),
            );
          }
        } else {
          showDialog(
            context: context,
            builder: (context) => MessageAlertMsg(
              'error',
              "LVB Coming soon...",
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      },
      child: Image.asset(
        Assets.imagesPaymentButtonLvb,
        fit: BoxFit.fitHeight,
      ),
    );
  }
}
