import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/screens/lottery/reward_point/lotto_reward.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/images.dart';
import 'lotto_point.dart';

class LottoRewardAndPointMain extends StatefulWidget {
  final bool fromViewPoint;

  const LottoRewardAndPointMain({super.key, this.fromViewPoint = false});

  @override
  State<LottoRewardAndPointMain> createState() =>
      _LottoRewardAndPointMainState();
}

class _LottoRewardAndPointMainState extends State<LottoRewardAndPointMain> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.fromViewPoint) {
        Get.find<LotteryController>().setTabIndex(1);
      } else {
        Get.find<LotteryController>().setTabIndex(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.redAccent.shade700,
        ),
        body: Stack(
          children: [
            Image(
              image: AssetImage(Images.scnBackgroundPng),
              fit: BoxFit.fill,
              width: Get.width,
              height: Get.height,
            ),
            GetBuilder<LotteryController>(builder: (lotCtrl) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => lotCtrl.setTabIndex(0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20)),
                              image: DecorationImage(
                                image: AssetImage(lotCtrl.tabIndex != 0
                                    ? Images.bonusTab
                                    : Images.bonusTabSelected),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "bonus".tr,
                                style: robotoBold.copyWith(
                                  color: lotCtrl.tabIndex != 1
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => lotCtrl.setTabIndex(1),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                  lotCtrl.tabIndex != 1
                                      ? Images.pointTab
                                      : Images.pointTabSelected,
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "points".tr,
                                style: robotoBold.copyWith(
                                  color: lotCtrl.tabIndex != 0
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (lotCtrl.tabIndex == 0) ...[
                    Expanded(child: LottoReward()),
                  ] else ...[
                    Expanded(child: LottoPoints())
                  ]
                ],
              );
            }),
          ],
        ));
  }
}
