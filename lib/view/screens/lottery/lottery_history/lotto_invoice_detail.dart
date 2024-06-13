import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_model.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../helper/date_converter.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/textStyle.dart';
import '../../../base/fade_animation.dart';

class LotteryHistoryDetail extends StatefulWidget {
  // final Invoices invoice;
  final LotteryInvoiceHistoryItem invoice;
  final bool fromPayment;

  LotteryHistoryDetail(
      {Key? key, required this.invoice, this.fromPayment = false})
      : super(key: key);

  @override
  _LotteryHistoryDetailState createState() => _LotteryHistoryDetailState();
}

class _LotteryHistoryDetailState extends State<LotteryHistoryDetail> {
  List<LotteryInvoiceHistoryDetailItem> winDraw = [];
  List<LotteryInvoiceHistoryDetailItem> detailDraw = [];

  @override
  void initState() {
    super.initState();
    widget.invoice.lotteryHistoryDetails!.forEach((draw) {
      if (draw.winStatus != null && draw.winStatus == true) {
        winDraw.add(draw);
      }
      if (draw.amount! > 0) {
        detailDraw.add(draw);
      }
    });

    Logger().w(detailDraw);
  }

  ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey _captureGlobalKey = GlobalKey();

  void captureScreenShoot() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      //Start Capture long images
      final RenderRepaintBoundary boundary = _captureGlobalKey.currentContext!
          .findRenderObject()! as RenderRepaintBoundary;
      final ui.Image image1 = await boundary.toImage();
      final ByteData? byteData =
          await image1.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();
      //End Capture long images

      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        final imagePath1 = await File('${directory.path}/image1.png').create();
        await imagePath.writeAsBytes(image);
        await imagePath1.writeAsBytes(pngBytes);

        /// Share image
        // if (detailDraw.length <= 20) {
        await Share.shareFiles([imagePath.path],
            text: 'Share bill detail', subject: 'Bill Detail');
        // } else {
        //   await Share.shareFiles([imagePath.path, imagePath1.path], text: 'Share bill detail', subject: 'Bill Detail');
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.fromPayment) {
          Get.close(1);
          Get.back();
          return true;
        } else {
          Navigator.pop(context);
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                if (widget.fromPayment) {
                  Get.close(1);
                  Get.back();
                } else {
                  Navigator.pop(context);
                }
              }),
          title: Text(
            'lotto_bill'.tr,
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge1,
            ),
          ),
          actions: [
            IconButton(
              onPressed: captureScreenShoot,
              icon: const Icon(
                Icons.share,
              ),
            ),
          ],
          backgroundColor: Colors.redAccent.shade700,
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Colors.white,
            child: GetBuilder<LotteryController>(
              builder: (lotCtrl) {
                // return widget.invoice == null
                //     ? Center(
                //         child: CircularProgressIndicator(),
                //       ) :
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: Get.width * 0.5,
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.all(16),
                            child: Image.asset(
                              Images.historyBillSuccess,
                              fit: BoxFit.fill,
                              width: Get.width,
                              height: Get.width * 0.5,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                buildBillSuccessful(),
                                buildBillSuccessfulDateTime(),
                                buildBillSuccessfulDrawDateTime(),
                                Gap(18),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// old version
                    // Center(
                    //   child: Container(
                    //     child: Image.asset(
                    //       Images.historyBillTopBanner,
                    //       fit: BoxFit.fitWidth,
                    //       width: MediaQuery.of(context).size.width / 1.5,
                    //     ),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 8.0),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'success'.tr,
                    //         style: robotoBold.copyWith(
                    //           fontSize: Dimensions.fontSizeLarge,
                    //           color: Colors.green.shade700,
                    //         ),
                    //       ),
                    //       FadeAnimation(
                    //         0.5,
                    //         Icon(
                    //           Icons.check_circle,
                    //           color: Colors.green.shade700,
                    //           size: 25,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Center(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text('${"time".tr}',
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Text(":",
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 2.0),
                    //         child: Text(
                    //             " ${widget.invoice.orderDate != null ? DateConverter.dateToTime(widget.invoice.orderDate) : 0}",
                    //             style: robotoBold.copyWith(
                    //                 fontSize: Dimensions.fontSizeSmall)),
                    //       ),
                    //       SizedBox(width: 10),
                    //       Text('${"date".tr}',
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Text(":",
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 2.0),
                    //         child: Text(
                    //             " ${widget.invoice.orderDate != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.orderDate.toString()) : 0}",
                    //             style: robotoBold.copyWith(
                    //                 fontSize: Dimensions.fontSizeSmall)),
                    //       ),
                    //     ],
                    //   ),
                    //   // Text.rich(
                    //   //   TextSpan(
                    //   //     children: <InlineSpan>[
                    //   //       TextSpan(
                    //   //         text: '${"time".tr}: ${widget.invoice.drawDate != null ? DateConverter.dateToTime(widget.invoice.saleDate) : 0}',
                    //   //         style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                    //   //       ),
                    //   //       TextSpan(
                    //   //           text: "  ${"date".tr}: ${widget.invoice.drawDate != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString()) : 0}",
                    //   //           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall))
                    //   //     ],
                    //   //   ),
                    //   // ),
                    // ),
                    // Center(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text('${"draw".tr}',
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Text(":",
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 2.0),
                    //         child: Text(
                    //             " ${widget.invoice != null ? widget.invoice.drawId : ''}",
                    //             style: robotoBold.copyWith(
                    //                 fontSize: Dimensions.fontSizeSmall)),
                    //       ),
                    //       SizedBox(width: 10),
                    //       Text('${"result_date".tr}',
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Text(":",
                    //           style: robotoBold.copyWith(
                    //               fontSize: Dimensions.fontSizeSmall)),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 2.0),
                    //         child: Text(
                    //             " ${widget.invoice != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString()) : ''}",
                    //             style: robotoBold.copyWith(
                    //                 fontSize: Dimensions.fontSizeSmall)),
                    //       ),
                    //     ],
                    //   ),
                    //   // Text.rich(
                    //   //   TextSpan(
                    //   //     children: <InlineSpan>[
                    //   //       TextSpan(
                    //   //         text: '${"draw".tr}: ${widget.invoice != null ? widget.invoice.drawId : ''}',
                    //   //         style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                    //   //       ),
                    //   //       TextSpan(
                    //   //           text: '  ${"result_date".tr}: ${widget.invoice != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString()) : ''}',
                    //   //           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall))
                    //   //     ],
                    //   //   ),
                    //   // ),
                    // ),
                    /// Table Header
                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(left: 8.0, right: 8.0),
                    //   child: const Divider(color: Colors.black),
                    // ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(left: 8.0, right: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Expanded(
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text('lucky_number'.tr,
                    //                 style: robotoBold),
                    //             Text('amount'.tr, style: robotoBold),
                    //           ],
                    //         ),
                    //       ),
                    //       const SizedBox(
                    //         width: 30,
                    //       ),
                    //       Expanded(
                    //         child: Row(
                    //           mainAxisAlignment:
                    //               MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text('lucky_number'.tr,
                    //                 style: robotoBold),
                    //             Text('amount'.tr, style: robotoBold),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   margin:
                    //       const EdgeInsets.only(left: 8.0, right: 8.0),
                    //   child: const Divider(color: Colors.black),
                    // ),
                    buildTableLine(),
                    buildTableHeader(),
                    buildTableLine(),
                    Expanded(
                      child: SingleChildScrollView(
                        child: RepaintBoundary(
                          key: _captureGlobalKey,
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < detailDraw.length;
                                            i++)
                                          if (i % 2 == 0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                detailDraw[i]
                                                        .digit
                                                        .toString()
                                                        .isEmpty
                                                    ? const Text('No Lottery')
                                                    : Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              for (int j = 0;
                                                                  j <
                                                                      lotCtrl
                                                                          .getChoiceList()
                                                                          .length;
                                                                  j++) ...[
                                                                if (detailDraw
                                                                        .isNotEmpty &&
                                                                    detailDraw[i]
                                                                            .digit
                                                                            .toString()
                                                                            .length ==
                                                                        1) ...[
                                                                  if (lotCtrl.getChoiceList()[j].contains('0' +
                                                                      detailDraw[i]
                                                                          .digit
                                                                          .toString()
                                                                          .substring(detailDraw[i].digit.toString().length -
                                                                              1)))
                                                                    Container(
                                                                        height:
                                                                            30.0,
                                                                        width:
                                                                            30.0,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(3),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              radius: 8,
                                                                              child: Image.asset(lotCtrl.getChoiceListImg()[j], fit: BoxFit.fill, width: 30, height: 30),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border: Border.all(
                                                                              color: Colors.deepOrange,
                                                                              width: 2.0),
                                                                        )),
                                                                ] else ...[
                                                                  if (detailDraw
                                                                          .isNotEmpty &&
                                                                      lotCtrl.getChoiceList()[j].contains(detailDraw[i]
                                                                          .digit
                                                                          .toString()
                                                                          .substring(detailDraw[i].digit.toString().length -
                                                                              2)))
                                                                    Container(
                                                                        height:
                                                                            30.0,
                                                                        width:
                                                                            30.0,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(3),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              radius: 8,
                                                                              child: Image.asset(lotCtrl.getChoiceListImg()[j], fit: BoxFit.fill, width: 30, height: 30),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border: Border.all(
                                                                              color: Colors.deepOrange,
                                                                              width: 2.0),
                                                                        )),
                                                                ]
                                                              ],
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                detailDraw[i]
                                                                    .digit
                                                                    .toString(),
                                                                style: OptionTextStyle()
                                                                    .optionStyle(
                                                                        null,
                                                                        null,
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                Text(
                                                  detailDraw[i]
                                                          .amount
                                                          .toString()
                                                          .isEmpty
                                                      ? "0"
                                                      : PriceConverter
                                                          .convertPriceNoCurrency(
                                                              double.parse(
                                                                  detailDraw[i]
                                                                      .amount
                                                                      .toString())),
                                                  style: OptionTextStyle()
                                                      .optionStyle(null, null,
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        for (int i = 0;
                                            i < detailDraw.length;
                                            i++)
                                          if (i % 2 == 1)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                detailDraw[i]
                                                        .digit
                                                        .toString()
                                                        .isEmpty
                                                    ? const Text('No Lottery')
                                                    : Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              for (int j = 0;
                                                                  j <
                                                                      lotCtrl
                                                                          .getChoiceList()
                                                                          .length;
                                                                  j++) ...[
                                                                if (detailDraw
                                                                        .isNotEmpty &&
                                                                    detailDraw[i]
                                                                            .digit
                                                                            .toString()
                                                                            .length ==
                                                                        1) ...[
                                                                  if (lotCtrl.getChoiceList()[j].contains('0' +
                                                                      detailDraw[i]
                                                                          .digit
                                                                          .toString()
                                                                          .substring(detailDraw[i].digit.toString().length -
                                                                              1)))
                                                                    Container(
                                                                        height:
                                                                            30.0,
                                                                        width:
                                                                            30.0,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(3),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              radius: 8,
                                                                              child: Image.asset(lotCtrl.getChoiceListImg()[j], fit: BoxFit.fill, width: 30, height: 30),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border: Border.all(
                                                                              color: Colors.deepOrange,
                                                                              width: 2.0),
                                                                        )),
                                                                ] else ...[
                                                                  if (detailDraw
                                                                          .isNotEmpty &&
                                                                      lotCtrl.getChoiceList()[j].contains(detailDraw[i]
                                                                          .digit
                                                                          .toString()
                                                                          .substring(detailDraw[i].digit.toString().length -
                                                                              2)))
                                                                    Container(
                                                                        height:
                                                                            30.0,
                                                                        width:
                                                                            30.0,
                                                                        child: Padding(
                                                                            padding: const EdgeInsets.all(3),
                                                                            child: CircleAvatar(
                                                                              backgroundColor: Colors.transparent,
                                                                              radius: 8,
                                                                              child: Image.asset(lotCtrl.getChoiceListImg()[j], fit: BoxFit.fill, width: 30, height: 30),
                                                                            )),
                                                                        decoration: BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border: Border.all(
                                                                              color: Colors.deepOrange,
                                                                              width: 2.0),
                                                                        )),
                                                                ]
                                                              ],
                                                              const SizedBox(
                                                                  width: 4),
                                                              Text(
                                                                detailDraw[i]
                                                                    .digit
                                                                    .toString(),
                                                                style: OptionTextStyle()
                                                                    .optionStyle(
                                                                        null,
                                                                        null,
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                Text(
                                                  detailDraw[i]
                                                          .amount
                                                          .toString()
                                                          .isEmpty
                                                      ? '0'
                                                      : PriceConverter
                                                          .convertPriceNoCurrency(
                                                              double.parse(
                                                                  detailDraw[i]
                                                                      .amount
                                                                      .toString())),
                                                  style: OptionTextStyle()
                                                      .optionStyle(null, null,
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Divider(
                        height: 1.5,
                        color: Colors.black,
                      ),
                    ),
                    buildTotalResult(),
                    Container(
                      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: const Divider(height: 1, color: Colors.black),
                    ),
                    Gap(8),
                    Container(
                        margin: const EdgeInsets.only(
                          left: 8.0,
                          right: 8.0,
                        ),
                        child: Column(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   'bill_no'.tr,
                            //   // style: robotoMedium.copyWith(
                            //   //   fontSize: Dimensions.fontSizeDefault,
                            //   // ),
                            // ),
                            Text('${'bill_no'.tr}${widget.invoice.billNumber}'),
                            Text(
                                '${'lotto_bill_no'.tr}${widget.invoice.paymentReference}'),
                            Text(
                                '${'pay_by_option'.tr}${widget.invoice.payBy}'),
                            Text('${'contact'.tr}030 5494222, 021 330710'),
                          ],
                        )
                        // Text('${"bill_no".tr} ${widget.invoice.billNo}', style: OptionTextStyle().optionStyle()),
                        ),
                    // Container(
                    //     margin: const EdgeInsets.only(
                    //       left: 8.0,
                    //       right: 8.0,
                    //     ),
                    //     child: Row(
                    //       // mainAxisSize: MainAxisSize.min,
                    //       // mainAxisAlignment: MainAxisAlignment.start,
                    //       // crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(
                    //           'lotto_bill_no'.tr,
                    //           style: robotoMedium.copyWith(
                    //             fontSize: Dimensions.fontSizeDefault,
                    //           ),
                    //         ),
                    //         // Text(": ", style: OptionTextStyle().optionStyle()),
                    //         Text("${widget.invoice.paymentReference}"),
                    //       ],
                    //     )
                    //
                    //     //  Text('${"lotto_bill_no".tr}${widget.invoice.paymentRef}', style: OptionTextStyle().optionStyle()),
                    //     ),
                    // Container(
                    //     margin:
                    //         const EdgeInsets.only(left: 8.0, right: 8.0),
                    //     child: Row(
                    //       // mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(
                    //           '${"pay_by_option".tr}: ',
                    //           style: robotoMedium.copyWith(
                    //             fontSize: Dimensions.fontSizeDefault,
                    //           ),
                    //         ),
                    //         // Text(": ", style: OptionTextStyle().optionStyle()),
                    //         Text("${widget.invoice.payBy}"),
                    //       ],
                    //     )
                    //     //Text('${"pay_by_option".tr}: ${widget.invoice.payBy}', style: robotoMedium),
                    //     ),
                    // Container(
                    //     margin:
                    //         const EdgeInsets.only(left: 8.0, right: 8.0),
                    //     child: Row(
                    //       // mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         Text(
                    //           '${"contact".tr}: ',
                    //           style: robotoMedium.copyWith(
                    //             fontSize: Dimensions.fontSizeDefault,
                    //           ),
                    //         ),
                    //         // Text(": "),
                    //         Text("030 5494222, 021 330710"),
                    //       ],
                    //     )
                    //     //Text('${"contact".tr} 030 5494222, 021 330710', style: robotoMedium),
                    //     ),
                    const Gap(24)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBillSuccessful() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'success'.tr,
          style: robotoBold.copyWith(
            fontSize: 16.sp,
            color: Colors.white,
          ),
        ),
        FadeAnimation(
          0.5,
          Icon(
            Icons.check_circle,
            color: Colors.white,
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget buildBillSuccessfulDateTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${"time".tr}:',
          style: robotoBold.copyWith(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
        // Text(
        //   ":",
        //   style: robotoBold.copyWith(
        //     fontSize: Dimensions.fontSizeDefault,
        //     color: Colors.white,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            " ${widget.invoice.orderDate != null ? DateConverter.dateToTime(widget.invoice.orderDate) : 0}",
            style: robotoBold.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${"date".tr}:',
          style: robotoBold.copyWith(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
        // Text(
        //   ":",
        //   style: robotoBold.copyWith(
        //     fontSize: Dimensions.fontSizeDefault,
        //     color: Colors.white,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 1.0),
          child: Text(
            " ${widget.invoice.orderDate != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.orderDate.toString()) : 0}",
            style: robotoBold.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBillSuccessfulDrawDateTime() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${"draw".tr}:',
          style: robotoBold.copyWith(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
        // Text(
        //   ":",
        //   style: robotoBold.copyWith(
        //     fontSize: Dimensions.fontSizeDefault,
        //     color: Colors.white,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            // " ${widget.invoice != null ? widget.invoice.drawId : ''}",
            " ${widget.invoice.drawId}",
            style: robotoBold.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${"result_date".tr}:',
          style: robotoBold.copyWith(
            fontSize: 12.sp,
            color: Colors.white,
          ),
        ),
        // Text(
        //   ":",
        //   style: robotoBold.copyWith(
        //     fontSize: Dimensions.fontSizeDefault,
        //     color: Colors.white,
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Text(
            // " ${widget.invoice != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString()) : ''}",
            "${DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString())}",
            // " ${DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString())}",
            style: robotoBold.copyWith(
              fontSize: 12.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTableLine() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: const Divider(color: Colors.black),
    );
  }

  Widget buildTableHeader() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('lucky_number'.tr, style: robotoBold),
                Text('amount'.tr, style: robotoBold),
              ],
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('lucky_number'.tr, style: robotoBold),
                Text('amount'.tr, style: robotoBold),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTotalResult() {
    return Container(
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${"lucky_no".tr} ${detailDraw.length} ຕົວ',
            style: robotoBold,
          ),
          Text(
            'total_amount'.tr +
                PriceConverter.convertPriceNoCurrency(
                  double.parse(widget.invoice.totalAmount.toString()),
                ),
            style: robotoBold,
          )
        ],
      ),
    );
  }
}
