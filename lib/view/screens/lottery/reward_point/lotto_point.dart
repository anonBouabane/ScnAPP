import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../controller/lottery_controller.dart';
import '../../../../helper/price_converter.dart';
import '../../../../util/images.dart';

class LottoPoints extends StatefulWidget {
  const LottoPoints({Key? key}) : super(key: key);

  @override
  State<LottoPoints> createState() => _LottoPointsState();
}

class _LottoPointsState extends State<LottoPoints> {
  @override
  void initState() {
    super.initState();
    Get.find<LotteryController>()
        .getPoints(Get.find<AuthController>().getUserNumber());
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(
      builder: (lotCtrl) {
        return OverlayLoaderWithAppIcon(
          isLoading: lotCtrl.pointLoading,
          appIcon: Image.asset(Images.loadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "point_that_you_have".tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                ),
                Text(
                  "${lotCtrl.pointModel != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointModel!.balance.toString())) : 0} ",
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeOverLarge,
                    color: Colors.redAccent.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                lotCtrl.pointStatement.length > 0
                    ? Container(
                        child: ListView.builder(
                            itemCount: lotCtrl.pointStatement.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Container(
                                      height: 85,
                                      margin: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            Images.pointStatementBg,
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // --- start added by thin --- //
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  lotCtrl.pointStatement[i]
                                                      .description
                                                      .toString()
                                                      .replaceAll(
                                                          new RegExp(r"\d"), "")
                                                      .replaceAll('//', '')
                                                      .replaceAll('::', '')
                                                      .replaceAll('AM', '')
                                                      .replaceAll('PM', '')
                                                      .replaceAll("|", ""),
                                                  style: robotoBold,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text(
                                                "${DateConverter.dateToDateAndTime1(lotCtrl.pointStatement[i].datetime)}",
                                                style: robotoRegular.copyWith(
                                                  fontSize:
                                                      Dimensions.fontSizeSmall,
                                                ),
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              buildReferenceText(lotCtrl, i),
                                              SizedBox(width: 10),
                                              buildScoreText(lotCtrl, i),
                                              // Text(
                                              //   int.parse(lotCtrl
                                              //               .pointStatement[i]
                                              //               .credit
                                              //               .toString()) >
                                              //           0
                                              //       ? "+${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointStatement[i].credit!))} ${"points".tr}"
                                              //       : "-${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointStatement[i].debit!.replaceAll("-", "")))} ${"points".tr}",
                                              //   style: robotoRegular.copyWith(
                                              //     color: int.parse(lotCtrl
                                              //                 .pointStatement[i]
                                              //                 .credit
                                              //                 .toString()) >
                                              //             0
                                              //         ? Colors.green.shade900
                                              //         : Colors
                                              //             .redAccent.shade700,
                                              //     fontSize: Dimensions
                                              //         .fontSizeDefault,
                                              //     fontWeight: FontWeight.bold,
                                              //   ),
                                              // ),
                                              // SizedBox(width: 5),
                                              // Text(
                                              //   "points".tr,
                                              //   style: robotoRegular.copyWith(
                                              //     color: int.parse(lotCtrl
                                              //                 .pointStatement[i]
                                              //                 .credit
                                              //                 .toString()) >
                                              //             0
                                              //         ? Colors.green.shade900
                                              //         : Colors
                                              //             .redAccent.shade700,
                                              //     fontSize:
                                              //         Dimensions.fontSizeSmall,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          // --- end added by thin --- //
                                          // Row(
                                          //   children: [
                                          //     Text(
                                          //         lotCtrl.pointStatement[i]
                                          //             .description
                                          //             .toString()
                                          //             .replaceAll(
                                          //                 new RegExp(r"\d"), "")
                                          //             .replaceAll('//', '')
                                          //             .replaceAll('::', '')
                                          //             .replaceAll('AM', '')
                                          //             .replaceAll('PM', '')
                                          //             .replaceAll("|", ""),
                                          //         style: robotoBold),
                                          //     // Text(int.parse(lotCtrl.pointStatement[i].credit.toString()) > 0 ? "ໄດ້ຮັບເງິນຄືນຈາກການຊື້ຫວຍ" : "ໃຊ້ຄະແນນຊື້ຫວຍ", style: robotoBold),
                                          //     Spacer(),
                                          //     Text(
                                          //       "${DateConverter.dateToDateAndTime1(lotCtrl.pointStatement[i].datetime)}",
                                          //       style: robotoRegular.copyWith(
                                          //         fontSize:
                                          //             Dimensions.fontSizeSmall,
                                          //       ),
                                          //     ),
                                          //   ],
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          // ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.start,
                                          //   crossAxisAlignment:
                                          //       CrossAxisAlignment.start,
                                          //   children: [
                                          //     Text(
                                          //       "${"reference_no".tr} ${lotCtrl.pointStatement[i].paymentReferenceNo.toString().replaceAll("null", "")}",
                                          //       style: robotoRegular.copyWith(
                                          //         color: Colors.grey,
                                          //         fontSize: Dimensions
                                          //             .fontSizeDefault,
                                          //       ),
                                          //       overflow: TextOverflow.ellipsis,
                                          //     ),
                                          //     Spacer(),
                                          //     Text(
                                          //         int.parse(lotCtrl
                                          //                     .pointStatement[i]
                                          //                     .credit
                                          //                     .toString()) >
                                          //                 0
                                          //             ? "+${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointStatement[i].credit!))}"
                                          //             : "-${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.pointStatement[i].debit!.replaceAll("-", "")))}",
                                          //         style: robotoBold.copyWith(
                                          //             color: int.parse(lotCtrl
                                          //                         .pointStatement[
                                          //                             i]
                                          //                         .credit
                                          //                         .toString()) >
                                          //                     0
                                          //                 ? Colors
                                          //                     .green.shade900
                                          //                 : Colors.redAccent
                                          //                     .shade700,
                                          //             fontSize:
                                          //                 Dimensions.fontSizeLarge)),
                                          //     SizedBox(width: 5),
                                          //     Text(
                                          //       "points".tr,
                                          //       style: robotoBold.copyWith(
                                          //         color: int.parse(lotCtrl
                                          //                     .pointStatement[i]
                                          //                     .credit
                                          //                     .toString()) >
                                          //                 0
                                          //             ? Colors.green.shade900
                                          //             : Colors
                                          //                 .redAccent.shade700,
                                          //         fontSize:
                                          //             Dimensions.fontSizeSmall,
                                          //       ),
                                          //     ),
                                          //   ],
                                          // ),
                                        ],
                                      )),
                                  SizedBox(height: 4)
                                ],
                              );
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 108.0),
                        child: Center(
                          child: Text(
                            "ບໍ່ມີລາຍການ",
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeOverLarge,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildScoreText(LotteryController lotCtrl, int index) {
    String text = '';
    Color color = Colors.transparent;
    String credit = lotCtrl.pointStatement[index].credit.toString();
    String debit = lotCtrl.pointStatement[index].debit.toString();
    String? referenceText = lotCtrl.pointStatement[index].paymentReferenceNo;

    // if (int.parse(credit) == 0 && int.parse(debit) == 0) {
    if (int.parse(credit) == 0 && referenceText == 'end_year_clear_point') {
      text =
          "${PriceConverter.convertPriceNoCurrency(double.parse(credit))} ${"points".tr}";
      color = Colors.black;
    } else if (int.parse(credit) > 0 && int.parse(debit) == 0) {
      text =
          "+${PriceConverter.convertPriceNoCurrency(double.parse(credit))} ${"points".tr}";
      color = Colors.green.shade900;
    } else {
      text =
          "-${PriceConverter.convertPriceNoCurrency(double.parse(debit.replaceAll("-", "")))} ${"points".tr}";
      color = Colors.redAccent.shade700;
    }
    return Text(
      text,
      style: robotoRegular.copyWith(
        color: color,
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget buildReferenceText(LotteryController lotCtrl, int index) {
    String? text = lotCtrl.pointStatement[index].paymentReferenceNo;
    if (text == 'end_year_clear_point') {
      text = lotCtrl.pointStatement[index].description.toString();
    } else if (text == null) {
      text = lotCtrl.pointStatement[index].description.toString();
    }

    return Flexible(
      child: Text(
        "${"reference_no".tr} $text",
        style: robotoRegular.copyWith(
          color: Colors.grey,
          fontSize: Dimensions.fontSizeDefault,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
