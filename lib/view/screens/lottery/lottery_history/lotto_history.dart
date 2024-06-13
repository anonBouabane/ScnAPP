import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/helper/date_converter.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LottoHistory extends StatefulWidget {
  const LottoHistory({Key? key}) : super(key: key);

  @override
  State<LottoHistory> createState() => _LottoHistoryState();
}

class _LottoHistoryState extends State<LottoHistory> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LotteryController>().getLotteryHistory(0, true);
    });
  }

  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(builder: (lotCtrl) {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent && lotCtrl.drawModel.isNotEmpty && !lotCtrl.paginate) {
          int pageSize = (lotCtrl.pageSize).ceil();
          if (lotCtrl.offset < pageSize) {
            lotCtrl.setOffset(lotCtrl.offset + 1);
            lotCtrl.showBottomLoader();
            lotCtrl.getLotteryHistory(lotCtrl.offset, false);
          }
        }
      });

      return OverlayLoaderWithAppIcon(
          isLoading: lotCtrl.historyLoading,
          appIcon: Image.asset(Images.loadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: lotCtrl.drawModel.isNotEmpty
              ? Scrollbar(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: SizedBox(
                      width: Dimensions.WEB_MAX_WIDTH,
                      child: ListView.builder(
                          itemCount: lotCtrl.drawModel.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 80,
                              margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                              decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.historyLotResultBg), fit: BoxFit.fill)),
                              child: Stack(
                                children: [
                                  ListTile(
                                    title: Column(
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '${"lotteryResult".tr}: ${lotCtrl.drawModel[index].roundDate != "" ? DateConverter.isoStringToLocalString(lotCtrl.drawModel[index].roundDate.toString()) : 0}',
                                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                                            ),
                                          ],
                                        ),
                                        lotCtrl.drawModel[index].winNumber != ""
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  for (int i = 0; i < lotCtrl.drawModel[index].winNumber.toString().length; i++)
                                                    Expanded(
                                                      child: Container(
                                                        padding: EdgeInsets.only(top: 8.0,bottom: 4),
                                                        margin: EdgeInsets.all(2.0),
                                                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.redAccent.shade700),
                                                        child: Center(
                                                          child: Text(
                                                            lotCtrl.drawModel[index].winNumber != "" ? lotCtrl.drawModel[index].winNumber![i].toString() : '',
                                                            style: robotoBold.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeLarge),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              )
                                            : Container(
                                                padding: EdgeInsets.only(bottom: 8.0, top: 4),
                                                child: Center(
                                                  child: Text("ເລກຍັງບໍ່ທັນອອກ", style: robotoBold, textAlign: TextAlign.center),
                                                ),
                                              ),
                                      ],
                                    ),
                                    trailing: SizedBox(width: 40, height: 40),
                                  ),
                                  Positioned(
                                      top: 4,
                                      right: 15,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          for (int i = 0; i < lotCtrl.getChoiceList().length; i++)
                                            if (lotCtrl.drawModel[index].winNumber != "" &&
                                                lotCtrl
                                                    .getChoiceList()[i]
                                                    .contains(lotCtrl.drawModel[index].winNumber.toString().substring(lotCtrl.drawModel[index].winNumber.toString().length - 2))) ...[
                                              Text('${lotCtrl.getNameList()[i].tr}', style: robotoBold),
                                            ],
                                          for (int i = 0; i < lotCtrl.getChoiceList().length; i++)
                                            if (lotCtrl.drawModel[index].winNumber != "" &&
                                                lotCtrl
                                                    .getChoiceList()[i]
                                                    .contains(lotCtrl.drawModel[index].winNumber.toString().substring(lotCtrl.drawModel[index].winNumber.toString().length - 2))) ...[
                                              // Text('${lotCtrl.getNameList()[i].tr}', style: robotoBold),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 8.0),
                                                child: Image.asset(lotCtrl.getChoiceListImg()[i], fit: BoxFit.fill, width: 40, height: 40),
                                              )
                                            ]
                                        ],
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                  ),
                )
              : Text(""));
    });
  }
}
