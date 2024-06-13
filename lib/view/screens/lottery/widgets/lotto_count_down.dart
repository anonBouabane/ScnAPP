import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';

class LottoCountDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(left: 17, right: 17),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.timeUpBg), fit: BoxFit.fill)),
      child: GetBuilder<LotteryController>(builder: (lotCtrl) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              // if (lotCtrl.milliSec != null && lotCtrl.milliSec > 1) ...[
              if (lotCtrl.milliSec > 1) ...[
                Wrap(
                  direction: Axis.vertical,
                  spacing: -5,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "${"draw_date".tr} ${lotCtrl.dashboard.length > 0 ? DateConverter.isoStringToLocalString(lotCtrl.dashboard[0].roundDate.toString()) : ""}",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    Text(
                      "${"sale_close_in".tr}:",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Colors.redAccent.shade700),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.slot),
                                  fit: BoxFit.fill)),
                          child: Center(
                            child: Text(
                              // lotCtrl.daysUntil != null
                              lotCtrl.daysUntil > 0
                                  ? '${lotCtrl.daysUntil.toString().padLeft(2, '0')}'
                                  : '00',
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeOverLarge),
                            ),
                          ),
                        ),
                        Text('days'.tr, style: robotoRegular)
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.slot),
                                  fit: BoxFit.fill)),
                          child: Center(
                              child: Text(
                                  // lotCtrl.hoursUntil != null
                                  lotCtrl.hoursUntil > 0
                                      ? '${lotCtrl.hoursUntil.toString().padLeft(2, '0')}'
                                      : '00',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge))),
                        ),
                        Text('hours'.tr, style: robotoRegular)
                      ],
                    ),
                    SizedBox(width: 30),
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          padding: EdgeInsets.only(top: 6),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Images.slot),
                                  fit: BoxFit.fill)),
                          child: Center(
                              child: Text(
                                  // lotCtrl.minUntil != null
                                  lotCtrl.minUntil > 0
                                      ? '${lotCtrl.minUntil.toString().padLeft(2, '0')}'
                                      : '00',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge))),
                        ),
                        Text('minutes'.tr, style: robotoRegular)
                      ],
                    ),
                    SizedBox(width: 30),
                    Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            padding: EdgeInsets.only(top: 6),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(Images.slot),
                                    fit: BoxFit.fill)),
                            child: Center(
                              child: Text(
                                  // lotCtrl.s != null ?
                                  '${lotCtrl.s.toString().padLeft(2, '0')}',
                                  // : '00',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge),
                                  textAlign: TextAlign.center),
                            ),
                          ),
                          Text('seconds'.tr, style: robotoRegular)
                        ],
                      ),
                    )
                  ],
                ),
                // SizedBox(height: 20),
                // Divider(color: Colors.grey.shade500),
              ] else ...[
                Column(
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      spacing: -5,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "${"draw_date".tr}",
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge),
                        ),
                        Text(
                          "${"sale_close_in".tr}:",
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeDefault,
                              color: Colors.redAccent.shade700),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.only(top: 6),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Images.slot),
                                      fit: BoxFit.fill)),
                              child: Center(
                                child: Text(
                                  '00',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge),
                                ),
                              ),
                            ),
                            Text('days'.tr, style: robotoRegular)
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.only(top: 6),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Images.slot),
                                      fit: BoxFit.fill)),
                              child: Center(
                                  child: Text('00',
                                      style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge))),
                            ),
                            Text('hours'.tr, style: robotoRegular)
                          ],
                        ),
                        SizedBox(width: 30),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              padding: EdgeInsets.only(top: 6),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(Images.slot),
                                      fit: BoxFit.fill)),
                              child: Center(
                                  child: Text('00',
                                      style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge))),
                            ),
                            Text('minutes'.tr, style: robotoRegular)
                          ],
                        ),
                        SizedBox(width: 30),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                padding: EdgeInsets.only(top: 6),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(Images.slot),
                                        fit: BoxFit.fill)),
                                child: Center(
                                  child: Text('00',
                                      style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeOverLarge),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              Text('seconds'.tr, style: robotoRegular)
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                )
              ]
            ],
          ),
        );
      }),
    );
  }
}
