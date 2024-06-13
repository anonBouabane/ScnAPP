import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_model.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/images.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../helper/date_converter.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../../util/textStyle.dart';
import '../../../base/fade_animation.dart';

class LottoInvoiceWonDetail extends StatefulWidget {
  // final Invoicese invoice;
  final LotteryInvoiceHistoryItem invoice;

  const LottoInvoiceWonDetail({Key? key, required this.invoice})
      : super(key: key);

  @override
  State<LottoInvoiceWonDetail> createState() => _LottoInvoiceWonDetailState();
}

class _LottoInvoiceWonDetailState extends State<LottoInvoiceWonDetail>
    with TickerProviderStateMixin {
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

    // winDraw = [
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "1234",
    //     digitType: "4",
    //     amount: 1000000000,
    //     winStatus: true,
    //   ),
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "12345",
    //     digitType: "5",
    //     amount: 3000000000,
    //     winStatus: true,
    //   ),
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "1234",
    //     digitType: "4",
    //     amount: 7400000000,
    //     winStatus: true,
    //   ),
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "1234",
    //     digitType: "4",
    //     amount: 6300000000,
    //     winStatus: true,
    //   ),
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "1234",
    //     digitType: "4",
    //     amount: 450000000,
    //     winStatus: true,
    //   ),
    //   Detail(
    //     ticketId: "43532532423434",
    //     digit: "1234",
    //     digitType: "4",
    //     amount: 134000000,
    //     winStatus: true,
    //   ),
    // ];
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
        // if (widget.invoice.details!.length <= 20) {
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('congrats'.tr,
            style:
                robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1)),
        actions: [
          IconButton(
              onPressed: captureScreenShoot, icon: const Icon(Icons.share))
        ],
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          child: GetBuilder<LotteryController>(
            builder: (lotCtrl) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 320,
                    child: Stack(
                      children: [
                        Container(
                          child: Image.asset(Images.wonLotBg,
                              fit: BoxFit.fill,
                              height: 320,
                              width: MediaQuery.of(context).size.width),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 110.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: 70,
                              child: Center(
                                child: Text(
                                  widget.invoice.totalWinAmount != null
                                      ? PriceConverter.convertPriceNoCurrency(
                                          double.parse(widget
                                              .invoice.totalWinAmount
                                              .toString()))
                                      : "0",
                                  style: OptionTextStyle().optionStyle2(
                                      32, Colors.white, FontWeight.w900),
                                ),
                              ),
                            ),
                          ),
                        ),
                        winDraw.isNotEmpty
                            ? Align(
                                alignment: Alignment.bottomCenter,
                                child: Container(
                                    height: 55,
                                    padding: EdgeInsets.only(top: 6),
                                    child: ListView.builder(
                                      itemCount: winDraw.length,
                                      itemExtent: 45,
                                      itemBuilder: (context, index) {
                                        return Row(children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 48.0),
                                              child: Text(
                                                "${winDraw[index].digit}",
                                                textAlign: TextAlign.center,
                                                style: robotoBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge1,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 68.0),
                                              child: Text(
                                                PriceConverter
                                                    .convertPriceNoCurrency(
                                                        double.parse(
                                                            winDraw[index]
                                                                .amount
                                                                .toString())),
                                                textAlign: TextAlign.center,
                                                style: robotoBold.copyWith(
                                                    fontSize: Dimensions
                                                        .fontSizeExtraLarge1,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]);
                                      },
                                    )),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                  // winDraw.isNotEmpty
                  //     ? Container(
                  //         height: 55,
                  //         child: ListView.builder(
                  //           itemCount: winDraw.length,
                  //           itemBuilder: (context, index) {
                  //             return Row(children: [
                  //               Expanded(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(left: 48.0),
                  //                   child: Text(
                  //                     "${winDraw[index].digit}",
                  //                     textAlign: TextAlign.center,
                  //                     style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Expanded(
                  //                 child: Padding(
                  //                   padding: const EdgeInsets.only(right: 68.0),
                  //                   child: Text(
                  //                     PriceConverter.convertPriceNoCurrency(double.parse(winDraw[index].amount.toString())),
                  //                     textAlign: TextAlign.center,
                  //                     style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, fontWeight: FontWeight.bold),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ]);
                  //           },
                  //         ))
                  //     : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(top: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'success'.tr,
                          style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: Colors.green.shade700),
                        ),
                        FadeAnimation(
                            0.5,
                            Icon(Icons.check_circle,
                                color: Colors.green.shade700, size: 25))
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${"time".tr}',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall)),
                        Text(":",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall)),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                              " ${widget.invoice.orderDate != null ? DateConverter.dateToTime(widget.invoice.orderDate) : 0}",
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall)),
                        ),
                        SizedBox(width: 10),
                        Text('${"date".tr}',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall)),
                        Text(":",
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall)),
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                              " ${widget.invoice.orderDate != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.orderDate.toString()) : 0}",
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall)),
                        ),
                      ],
                    ),
                    // Text.rich(
                    //   TextSpan(
                    //     children: <InlineSpan>[
                    //       TextSpan(
                    //         text: '${"time".tr}: ${widget.invoice.orderDate != null ? DateConverter.dateToTime(widget.invoice.orderDate) : 0}',
                    //         style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                    //       ),
                    //       TextSpan(
                    //           text: "  ${"date".tr}: ${widget.invoice.drawDate != null ? DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString()) : 0}",
                    //           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall))
                    //     ],
                    //   ),
                    // ),
                  ),
                  Center(
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          TextSpan(
                            text: '${"draw".tr}: ${widget.invoice.drawId}',
                            style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeSmall),
                          ),
                          TextSpan(
                              text:
                                  '  ${"result_date".tr}: ${DateConverter.dateTimeDashToDateOnly(widget.invoice.drawDate.toString())}',
                              style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeSmall))
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: const Divider(color: Colors.black),
                  ),
                  Container(
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
                        const SizedBox(width: 30),
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
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: const Divider(color: Colors.black),
                  ),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: RepaintBoundary(
                        key: _captureGlobalKey,
                        child: Container(
                          margin: const EdgeInsets.only(left: 8.0, right: 8.0),
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
                                                MainAxisAlignment.spaceBetween,
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
                                                                if (lotCtrl
                                                                    .getChoiceList()[
                                                                        j]
                                                                    .contains('0' +
                                                                        detailDraw[i]
                                                                            .digit
                                                                            .toString()
                                                                            .substring(detailDraw[i].digit.toString().length -
                                                                                1)))
                                                                  Container(
                                                                    height:
                                                                        30.0,
                                                                    width: 30.0,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            8,
                                                                        child: Image
                                                                            .asset(
                                                                          lotCtrl
                                                                              .getChoiceListImg()[j],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: detailDraw[i].winStatus!
                                                                            ? Colors.green.shade700
                                                                            : Colors.deepOrange,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ] else ...[
                                                                if (detailDraw
                                                                        .isNotEmpty &&
                                                                    lotCtrl.getChoiceList()[j].contains(detailDraw[
                                                                            i]
                                                                        .digit
                                                                        .toString()
                                                                        .substring(detailDraw[i].digit.toString().length -
                                                                            2)))
                                                                  Container(
                                                                    height:
                                                                        30.0,
                                                                    width: 30.0,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            8,
                                                                        child: Image
                                                                            .asset(
                                                                          lotCtrl
                                                                              .getChoiceListImg()[j],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: detailDraw[i].winStatus!
                                                                            ? Colors.green.shade700
                                                                            : Colors.deepOrange,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ]
                                                            ],
                                                            const SizedBox(
                                                              width: 4,
                                                            ),
                                                            Text(
                                                              detailDraw[i]
                                                                  .digit
                                                                  .toString(),
                                                              style: OptionTextStyle()
                                                                  .optionStyle(
                                                                null,
                                                                detailDraw[i]
                                                                        .winStatus!
                                                                    ? Colors
                                                                        .green
                                                                        .shade700
                                                                    : null,
                                                                FontWeight.bold,
                                                              ),
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
                                                style: robotoBold.copyWith(
                                                  color: detailDraw[i]
                                                          .winStatus!
                                                      ? Colors.green.shade700
                                                      : Colors.black,
                                                ),
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
                                                MainAxisAlignment.spaceBetween,
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
                                                                if (lotCtrl
                                                                    .getChoiceList()[
                                                                        j]
                                                                    .contains('0' +
                                                                        detailDraw[i]
                                                                            .digit
                                                                            .toString()
                                                                            .substring(detailDraw[i].digit.toString().length -
                                                                                1)))
                                                                  Container(
                                                                    height:
                                                                        30.0,
                                                                    width: 30.0,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            8,
                                                                        child: Image
                                                                            .asset(
                                                                          lotCtrl
                                                                              .getChoiceListImg()[j],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: detailDraw[i].winStatus!
                                                                            ? Colors.green.shade700
                                                                            : Colors.deepOrange,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ] else ...[
                                                                if (detailDraw
                                                                        .isNotEmpty &&
                                                                    lotCtrl.getChoiceList()[j].contains(detailDraw[
                                                                            i]
                                                                        .digit
                                                                        .toString()
                                                                        .substring(detailDraw[i].digit.toString().length -
                                                                            2)))
                                                                  Container(
                                                                    height:
                                                                        30.0,
                                                                    width: 30.0,
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              3),
                                                                      child:
                                                                          CircleAvatar(
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        radius:
                                                                            8,
                                                                        child: Image
                                                                            .asset(
                                                                          lotCtrl
                                                                              .getChoiceListImg()[j],
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      border:
                                                                          Border
                                                                              .all(
                                                                        color: detailDraw[i].winStatus!
                                                                            ? Colors.green.shade700
                                                                            : Colors.deepOrange,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                  ),
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
                                                                detailDraw[i]
                                                                        .winStatus!
                                                                    ? Colors
                                                                        .green
                                                                        .shade700
                                                                    : null,
                                                                FontWeight.bold,
                                                              ),
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
                                                              .toString(),
                                                        ),
                                                      ),
                                                style: robotoBold.copyWith(
                                                  color: detailDraw[i]
                                                          .winStatus!
                                                      ? Colors.green.shade700
                                                      : Colors.black,
                                                ),
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
                    child: const Divider(height: 1.5, color: Colors.black),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${'lucky_no'.tr} " +
                              detailDraw.length.toString() +
                              ' ຕົວ',
                          style: robotoBold,
                        ),
                        Text(
                          'total_amount'.tr +
                              "${widget.invoice.totalAmount != null ? PriceConverter.convertPriceNoCurrency(double.parse(widget.invoice.totalAmount.toString())) : "0"}",
                          style: robotoBold,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: const Divider(height: 1.5, color: Colors.black),
                  ),
                  Gap(8),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('${'bill_no'.tr}${widget.invoice.billNumber}'),
                          Text(
                              '${'lotto_bill_no'.tr}${widget.invoice.paymentReference}'),
                          Text('${'pay_by_option'.tr}${widget.invoice.payBy}'),
                          Text('${'contact'.tr}030 5494222, 021 330710'),
                        ],
                      )),
                  Gap(8),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
