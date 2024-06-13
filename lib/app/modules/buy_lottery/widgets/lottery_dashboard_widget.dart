import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../buy_lottery_controller.dart';
import 'count_down_widget.dart';

class LotteryDashboardWidget extends GetView<BuyLotteryController> {
  const LotteryDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 130.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
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
          if (controller.closeSecond.value > 1 &&
              controller.checkLot.value) ...[
            CountDownWidget(),
          ] else ...[
            SizedBox(height: 50)
          ],
          SizedBox(height: 10),
          if (controller.dashboard.isNotEmpty) ...[
            if (controller.dashboard.isNotEmpty &&
                controller.dashboard[0].winNumber != '') ...[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.shade800,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${Translates.LOTTERY_RESULT.tr} ${controller.dashboard[0].roundDate.toString()}',
                          style: robotoBold.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeOverLarge,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0;
                                  i <
                                      controller.dashboard[0].winNumber
                                          .toString()
                                          .length;
                                  i++)
                                Expanded(
                                  child: Container(
                                    height: 55,
                                    padding: EdgeInsets.only(top: 5.0),
                                    margin: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red.shade800,
                                      // border: Border.all(width: 5, color: Colors.red.shade800),
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.dashboard[0].winNumber
                                            .toString()[i],
                                        style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeOverLarge,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          for (int i = 0;
                              i < controller.getChoiceList().length;
                              i++)
                            if (controller.dashboard.isNotEmpty &&
                                controller.getChoiceList()[i].contains(
                                    controller.dashboard[0].winNumber
                                        .toString()
                                        .substring(controller
                                                .dashboard[0].winNumber
                                                .toString()
                                                .length -
                                            2))) ...[
                              Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  controller.getChoiceListImg()[i],
                                  width: Get.width / 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text(
                                  controller.getNameList()[i].tr,
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeHugeLarge1,
                                  ),
                                ),
                              ),
                            ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (controller.dashboard.isNotEmpty &&
                controller.dashboard[0].winNumber == '') ...[
              Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.red.shade800,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${Translates.LOTTERY_RESULT.tr} ${DateConverter.isoStringToLocalString(controller.dashboard[1].roundDate.toString())}',
                          style: robotoBold.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeOverLarge,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 0.75),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (int i = 0;
                                  i <
                                      controller.dashboard[1].winNumber
                                          .toString()
                                          .length;
                                  i++)
                                Expanded(
                                  child: Container(
                                    height: 55,
                                    padding: EdgeInsets.only(top: 5.0),
                                    margin: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red.shade800),
                                    child: Center(
                                      child: Text(
                                        controller.dashboard[1].winNumber
                                            .toString()[i],
                                        style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeOverLarge,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          for (int i = 0;
                              i < controller.getChoiceList().length;
                              i++)
                            if (controller.dashboard.isNotEmpty &&
                                controller.getChoiceList()[i].contains(
                                    controller.dashboard[1].winNumber
                                        .toString()
                                        .substring(controller
                                                .dashboard[1].winNumber
                                                .toString()
                                                .length -
                                            2))) ...[
                              Container(
                                margin: const EdgeInsets.only(top: 8.0),
                                child: Image.asset(
                                  controller.getChoiceListImg()[i],
                                  width: Get.width / 3,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: Text(
                                  controller.getNameList()[i].tr,
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeHugeLarge1,
                                  ),
                                ),
                              ),
                            ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
          const Gap(40),
        ],
      ),
    );
  }
}
