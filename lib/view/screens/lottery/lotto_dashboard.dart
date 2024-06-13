import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/screens/lottery/widgets/lotto_count_down.dart';

import '../../../controller/lottery_controller.dart';
import '../../../util/images.dart';

class LottoDashboard extends StatelessWidget {
  const LottoDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(builder: (lotCtrl) {
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
            if (lotCtrl.closeSecond > 1 && lotCtrl.checkLot) ...[
              LottoCountDown(),
            ] else ...[
              SizedBox(height: 50)
            ],
            SizedBox(height: 10),
            if (lotCtrl.dashboard.isNotEmpty) ...[
              if (lotCtrl.dashboard.isNotEmpty &&
                  lotCtrl.dashboard[0].winNumber != "") ...[
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
                            // "${"lotteryResult".tr} ${DateConverter.isoStringToLocalString(lotCtrl.dashboard[0].roundDate.toString())}",
                            "${"lotteryResult".tr} ${lotCtrl.dashboard[0].roundDate.toString()}",
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
                                        lotCtrl.dashboard[0].winNumber
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
                                          lotCtrl.dashboard[0].winNumber
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
                                i < lotCtrl.getChoiceList().length;
                                i++)
                              if (lotCtrl.dashboard.isNotEmpty &&
                                  lotCtrl.getChoiceList()[i].contains(lotCtrl
                                      .dashboard[0].winNumber
                                      .toString()
                                      .substring(lotCtrl.dashboard[0].winNumber
                                              .toString()
                                              .length -
                                          2))) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  // width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                      lotCtrl.getChoiceListImg()[i],
                                      width: MediaQuery.of(context).size.width /
                                          3),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Text(
                                    lotCtrl.getNameList()[i].tr,
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeHugeLarge1),
                                  ),
                                ),
                              ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (lotCtrl.dashboard.isNotEmpty &&
                  lotCtrl.dashboard[0].winNumber == "") ...[
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
                            "${"lotteryResult".tr} ${DateConverter.isoStringToLocalString(lotCtrl.dashboard[1].roundDate.toString())}",
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
                                        lotCtrl.dashboard[1].winNumber
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
                                          lotCtrl.dashboard[1].winNumber
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
                                i < lotCtrl.getChoiceList().length;
                                i++)
                              if (lotCtrl.dashboard.isNotEmpty &&
                                  lotCtrl.getChoiceList()[i].contains(lotCtrl
                                      .dashboard[1].winNumber
                                      .toString()
                                      .substring(lotCtrl.dashboard[1].winNumber
                                              .toString()
                                              .length -
                                          2))) ...[
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  // width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                      lotCtrl.getChoiceListImg()[i],
                                      width: MediaQuery.of(context).size.width /
                                          3),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 18.0),
                                  child: Text(
                                    lotCtrl.getNameList()[i].tr,
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeHugeLarge1),
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
            SizedBox(height: 40)
          ],
        ),
      );
    });
  }
}
