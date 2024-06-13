import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/controller/lottery_controller.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

class LottoBonusCondition extends StatelessWidget {
  const LottoBonusCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent.shade700,
        title: Text('referral_friends'.tr,
            style:
                robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<LotteryController>(builder: (lotCtrl) {
                    return Column(
                      children: [
                        // HtmlContentViewer(
                        //   htmlContent: lotCtrl.bonusCondition,
                        //   initialContentHeight: MediaQuery.of(context).size.height,
                        //   initialContentWidth: MediaQuery.of(context).size.width,
                        // )
                      ],
                    );
                  })
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
