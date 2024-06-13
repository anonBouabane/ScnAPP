import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_view.dart';
import 'package:scn_easy/app/modules/lottery_history/result/lottery_result_history_view.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';

class LottoMHI extends StatefulWidget {
  const LottoMHI({Key? key}) : super(key: key);

  @override
  State<LottoMHI> createState() => _LottoMHIState();
}

class _LottoMHIState extends State<LottoMHI> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LotteryController>().setTabIndex(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     body: Stack(
    //       children: [
    //         Image(
    //           image: AssetImage(Images.scnBackgroundPng),
    //           fit: BoxFit.fill,
    //           height: Get.height,
    //           width: Get.width,
    //         ),
    //         GetBuilder<LotteryController>(
    //           builder: (controller) {
    //             return DefaultTabController(
    //               length: 2,
    //               child: TabBarView(
    //                 children: [
    //                   CustomScrollView(
    //                     shrinkWrap: true,
    //                     keyboardDismissBehavior:
    //                         ScrollViewKeyboardDismissBehavior.onDrag,
    //                     physics: const AlwaysScrollableScrollPhysics(),
    //                     slivers: [
    //                       showSliverAppBar('buyLottery'.tr),
    //                       SliverToBoxAdapter(
    //                         child: Column(
    //                           children: [
    //                             Container(
    //                               height: 45,
    //                               decoration: BoxDecoration(
    //                                 color: Colors.redAccent.shade700,
    //                                 borderRadius: BorderRadius.only(
    //                                   bottomRight: Radius.circular(20),
    //                                 ),
    //                               ),
    //                               child: Container(
    //                                 height: 38,
    //                                 margin: EdgeInsets.only(
    //                                   bottom: 3.0,
    //                                   right: 1,
    //                                 ),
    //                                 decoration: BoxDecoration(
    //                                   color: Colors.grey.shade200,
    //                                   borderRadius: BorderRadius.only(
    //                                     bottomRight: Radius.circular(20),
    //                                   ),
    //                                 ),
    //                                 child: Center(
    //                                   child: Text('Lottory'),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                   CustomScrollView(
    //                     shrinkWrap: true,
    //                     keyboardDismissBehavior:
    //                         ScrollViewKeyboardDismissBehavior.onDrag,
    //                     physics: const AlwaysScrollableScrollPhysics(),
    //                     slivers: [
    //                       showSliverAppBar('lotteryResult'.tr),
    //                     ],
    //                   ),
    //                 ],
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
        elevation: 0,
        title: Text(
          'history'.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge1,
          ),
        ),
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage(Images.scnBackgroundPng),
            fit: BoxFit.fill,
            height: Get.height,
            width: Get.width,
          ),
          GetBuilder<LotteryController>(builder: (lotCtrl) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => lotCtrl.setTabIndex(0),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: lotCtrl.tabIndex != 0
                                ? Colors.grey.shade300
                                : Colors.redAccent.shade700,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            height: 38,
                            margin: const EdgeInsets.only(
                              bottom: 3.0,
                              right: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "buyLottery".tr,
                                style: robotoBold.copyWith(
                                  color: lotCtrl.tabIndex != 1
                                      ? Colors.redAccent.shade700
                                      : Colors.black,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
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
                          height: 40,
                          decoration: BoxDecoration(
                            color: lotCtrl.tabIndex != 1
                                ? Colors.grey.shade300
                                : Colors.redAccent.shade700,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: Container(
                            height: 38,
                            margin: const EdgeInsets.only(
                              bottom: 3.0,
                              left: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                "lotteryResult".tr,
                                style: robotoBold.copyWith(
                                  color: lotCtrl.tabIndex != 0
                                      ? Colors.redAccent.shade700
                                      : Colors.black,
                                  fontSize: Dimensions.fontSizeLarge,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (lotCtrl.tabIndex == 0) ...[
                  Expanded(
                    // child: LottoInvoice(),
                    child: LotteryInvoiceHistoryView(),
                  ),
                ] else ...[
                  Expanded(
                    // child: LottoHistory(),
                    child: LotteryResultHistoryView(),
                  )
                ]
              ],
            );
          }),
        ],
      ),
    );
  }
}
