import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../buy_lottery_controller.dart';

class CountDownWidget extends GetView<BuyLotteryController> {
  const CountDownWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      margin: EdgeInsets.only(left: 17, right: 17),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.newDesignTimeUpBg),
          fit: BoxFit.fill,
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            if (controller.millisecond.value > 1) ...[
              Wrap(
                direction: Axis.vertical,
                spacing: -5,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    '${Translates.DRAW_DATE.tr} ${DateConverter.isoStringToLocalString(controller.dashboard[0].roundDate.toString())}',
                    style:
                        robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  ),
                  Text(
                    Translates.SALE_CLOSE_IN.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeDefault,
                      color: Colors.redAccent.shade700,
                    ),
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
                            image: AssetImage(Assets.newDesignSlot),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.daysUntil.value > 0
                                ? '${controller.daysUntil.value.toString().padLeft(2, '0')}'
                                : '00',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge),
                          ),
                        ),
                      ),
                      Text(Translates.DAYS.tr, style: robotoRegular)
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
                            image: AssetImage(Assets.newDesignSlot),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.hoursUntil > 0
                                ? '${controller.hoursUntil.toString().padLeft(2, '0')}'
                                : '00',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge),
                          ),
                        ),
                      ),
                      Text(Translates.HOURS.tr, style: robotoRegular)
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
                            image: AssetImage(Assets.newDesignSlot),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            controller.minutesUntil > 0
                                ? '${controller.minutesUntil.toString().padLeft(2, '0')}'
                                : '00',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge),
                          ),
                        ),
                      ),
                      Text(Translates.MINUTES.tr, style: robotoRegular)
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
                              image: AssetImage(Assets.newDesignSlot),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Center(
                            child: Text(
                                '${controller.second.toString().padLeft(2, '0')}',
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge),
                                textAlign: TextAlign.center),
                          ),
                        ),
                        Text(Translates.SECONDS.tr, style: robotoRegular)
                      ],
                    ),
                  )
                ],
              ),
            ] else ...[
              Column(
                children: [
                  Wrap(
                    direction: Axis.vertical,
                    spacing: -5,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        Translates.DRAW_DATE.tr,
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge),
                      ),
                      Text(
                        Translates.SALE_CLOSE_IN.tr,
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
                                image: AssetImage(Assets.newDesignSlot),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '00',
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge),
                              ),
                            ),
                          ),
                          Text(Translates.DAYS.tr, style: robotoRegular)
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
                                image: AssetImage(Assets.newDesignSlot),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '00',
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge),
                              ),
                            ),
                          ),
                          Text(Translates.HOURS.tr, style: robotoRegular)
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
                                image: AssetImage(Assets.newDesignSlot),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '00',
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeOverLarge),
                              ),
                            ),
                          ),
                          Text(Translates.MINUTES.tr, style: robotoRegular)
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
                                  image: AssetImage(Assets.newDesignSlot),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '00',
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeOverLarge),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Text(Translates.SECONDS.tr, style: robotoRegular)
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}
