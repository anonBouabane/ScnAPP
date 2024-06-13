import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/controller/lottery_controller.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/auth_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class LottoRewardDetail extends StatelessWidget {
  final String drawDate;
  final int drawId;

  const LottoRewardDetail(
      {super.key, required this.drawDate, required this.drawId});

  @override
  Widget build(BuildContext context) {
    Get.find<LotteryController>()
        .getBonusDetail(drawId, Get.find<AuthController>().getUserNumber());
    return Scaffold(
      appBar: AppBar(
        // title: Text("${"draw_date".tr}: ${DateConverter.dateTimeStringToDateOnly(drawDate)}", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1)),
        title: Text(
          "$drawDate",
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge1,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: GetBuilder<LotteryController>(builder: (lotCtrl) {
        return OverlayLoaderWithAppIcon(
            isLoading: lotCtrl.bonusDetailLoading,
            appIcon: Image.asset(Images.loadingLogo),
            circularProgressColor: Colors.green.shade800,
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.red.shade600,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              // mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ທ່ານແນະນຳທັງໝົດ",
                                        style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge,
                                            color: Colors.white),
                                      ),
                                      Text(
                                        "${lotCtrl.bonusDetail.totaluser != null ? lotCtrl.bonusDetail.totaluser : 0}",
                                        style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeHugeLarge1,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "ເງິນແນະນຳໃນງວດ",
                                        style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        "${lotCtrl.bonusDetail.totalreward != null ? lotCtrl.bonusDetail.totalreward : 0}",
                                        style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeHugeLarge1,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    ListView.builder(
                        itemCount: lotCtrl.items.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 90,
                            margin: EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 4,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ຄົນທີ່ທ່ານແນະນຳ",
                                          style: robotoMedium.copyWith(
                                              fontSize: Dimensions
                                                  .fontSizeExtraLarge),
                                        ),
                                        Text(
                                          "${lotCtrl.items[index].lottouser}",
                                          style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeOverLarge,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "ເງິນແນະນຳ",
                                          style: robotoMedium.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeExtraLarge,
                                          ),
                                        ),
                                        Text(
                                          "${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.items[index].totalreward.toString()))}",
                                          style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeOverLarge,
                                            color: Colors.redAccent.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
