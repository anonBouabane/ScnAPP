// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
// import 'package:scn_easy/helper/date_converter.dart';
// import 'package:scn_easy/helper/price_converter.dart';
//
// import '../../../../controller/auth_controller.dart';
// import '../../../../controller/lottery_controller.dart';
// import '../../../../util/dimensions.dart';
// import '../../../../util/images.dart';
// import '../../../../util/styles.dart';
// import 'lotto_invoice_detail.dart';
// import 'lotto_invoice_won_detail.dart';
//
// class LottoInvoice extends StatefulWidget {
//   const LottoInvoice({Key? key}) : super(key: key);
//
//   @override
//   State<LottoInvoice> createState() => _LottoInvoiceState();
// }
//
// class _LottoInvoiceState extends State<LottoInvoice> {
//   final ScrollController scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     getInvoice();
//
//     scrollController.addListener(() {
//       if (scrollController.position.pixels ==
//               scrollController.position.maxScrollExtent &&
//           Get.find<LotteryController>().invoiceModel.isNotEmpty &&
//           !Get.find<LotteryController>().invoiceLoading) {
//         int pageSize =
//             (Get.find<LotteryController>().invoicePageSize / 20).ceil();
//         // Logger().d(pageSize);
//         if (Get.find<LotteryController>().invoiceOffset < pageSize) {
//           Get.find<LotteryController>().setInvoiceOffset(
//               Get.find<LotteryController>().invoiceOffset + 1);
//           Get.find<LotteryController>().getInvoice(
//               false,
//               Get.find<LotteryController>().invoiceOffset,
//               Get.find<AuthController>().getUserNumber());
//           Get.find<LotteryController>().setInvoiceLoading(true);
//         } else {
//           Get.find<LotteryController>().setInvoiceLoading(false);
//           Get.snackbar('no_lottery_result'.tr, 'no_invoice_history'.tr,
//               snackPosition: SnackPosition.BOTTOM);
//         }
//       }
//     });
//   }
//
//   void getInvoice() async {
//     await Get.find<LotteryController>()
//         .getInvoice(true, 0, Get.find<AuthController>().getUserNumber());
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     scrollController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<LotteryController>(builder: (lotCtrl) {
//       return OverlayLoaderWithAppIcon(
//         isLoading: lotCtrl.invoiceLoading,
//         appIcon: Image.asset(Images.loadingLogo),
//         circularProgressColor: Colors.green.shade800,
//         child: RefreshIndicator(
//           onRefresh: () async {
//             await lotCtrl.getInvoice(
//                 true, 0, Get.find<AuthController>().getUserNumber());
//           },
//           child: Scrollbar(
//             child: SingleChildScrollView(
//               controller: scrollController,
//               physics: AlwaysScrollableScrollPhysics(),
//               child: SizedBox(
//                 // width: Dimensions.WEB_MAX_WIDTH,
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: lotCtrl.invoiceModel.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 10),
//                           Container(
//                             height: 30,
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10)),
//                                 color: Colors.red.shade800),
//                             child: Center(
//                               child: Text(
//                                 "${lotCtrl.invoiceModel[index].drawResult == null ? "draw_date".tr : "lotteryResult".tr} ${DateConverter.dateToDateOnly(lotCtrl.invoiceModel[index].drawDate)}",
//                                 style: robotoBold.copyWith(
//                                     color: Colors.white,
//                                     fontSize: Dimensions.fontSizeLarge),
//                               ),
//                             ),
//                           ),
//                           Stack(
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   if (lotCtrl.invoiceModel[index].winStatus !=
//                                           null &&
//                                       lotCtrl.invoiceModel[index].winStatus ==
//                                           true) {
//                                     Get.to(() => LottoInvoiceWonDetail(
//                                         invoice: lotCtrl.invoiceModel[index]));
//                                   } else {
//                                     Get.to(() => LotteryHistoryDetail(
//                                         invoice: lotCtrl.invoiceModel[index]));
//                                   }
//                                 },
//                                 child: Container(
//                                   decoration:
//                                       BoxDecoration(color: Colors.white),
//                                   padding: EdgeInsets.all(8),
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Row(
//                                         children: [
//                                           Text.rich(
//                                             TextSpan(
//                                               children: <InlineSpan>[
//                                                 TextSpan(
//                                                   // text: "bill_no".tr,
//                                                   text: "lotto_bill_no".tr,
//                                                   style: robotoBold.copyWith(
//                                                       fontSize: Dimensions
//                                                           .fontSizeSmall),
//                                                 ),
//                                                 TextSpan(
//                                                     text:
//                                                         '${lotCtrl.invoiceModel[index].billNo}',
//                                                     style: robotoBold.copyWith(
//                                                         fontSize: Dimensions
//                                                             .fontSizeSmall))
//                                               ],
//                                             ),
//                                           ),
//                                           // Spacer(),
//                                           Expanded(
//                                               child: Text(
//                                                   ' ${DateConverter.dateToDateAndTime1(lotCtrl.invoiceModel[index].orderDate)}',
//                                                   style: robotoBold.copyWith(
//                                                       fontSize: Dimensions
//                                                           .fontSizeSmall))),
//                                         ],
//                                       ),
//                                       Text.rich(
//                                         TextSpan(
//                                           children: <InlineSpan>[
//                                             TextSpan(
//                                               text: "pay_by".tr,
//                                               style: robotoBold.copyWith(
//                                                   fontSize:
//                                                       Dimensions.fontSizeSmall),
//                                             ),
//                                             TextSpan(
//                                                 text:
//                                                     ' ${lotCtrl.invoiceModel[index].payBy}',
//                                                 style: robotoBold.copyWith(
//                                                     fontSize: Dimensions
//                                                         .fontSizeSmall))
//                                           ],
//                                         ),
//                                       ),
//                                       Container(
//                                         // height: 100,
//                                         margin: EdgeInsets.only(
//                                             left: 20, right: 20),
//                                         child: GridView.builder(
//                                             gridDelegate:
//                                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                               crossAxisCount: 4,
//                                               childAspectRatio: 2 / 0.8,
//                                               crossAxisSpacing: 4,
//                                               mainAxisSpacing: 4,
//                                             ),
//                                             itemCount: lotCtrl
//                                                 .invoiceModel[index]
//                                                 .details!
//                                                 .length,
//                                             shrinkWrap: true,
//                                             physics:
//                                                 NeverScrollableScrollPhysics(),
//                                             itemBuilder: (BuildContext ctx, i) {
//                                               return Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                     3,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             2),
//                                                     border: Border.all(
//                                                         color: Colors
//                                                             .grey.shade300)),
//                                                 child: Text(
//                                                   "${lotCtrl.invoiceModel[index].details![i].digit}",
//                                                 ),
//                                               );
//                                             }),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 child: lotCtrl.invoiceModel[index].winStatus !=
//                                             null &&
//                                         lotCtrl.invoiceModel[index].winStatus ==
//                                             true
//                                     ? Icon(
//                                         Icons.check_circle_rounded,
//                                         color: Colors.green,
//                                         size: 30,
//                                       )
//                                     : Text(""),
//                                 bottom: 0,
//                                 right: 0,
//                               )
//                             ],
//                           ),
//                           Container(
//                             height: 35,
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(10),
//                                     bottomRight: Radius.circular(10))),
//                             child: Container(
//                               height: 20,
//                               width: MediaQuery.of(context).size.width,
//                               margin: EdgeInsets.only(
//                                   bottom: 3, top: 3, left: 2, right: 2),
//                               padding: EdgeInsets.only(right: 10),
//                               alignment: Alignment.bottomRight,
//                               decoration: BoxDecoration(
//                                   image: DecorationImage(
//                                       image: AssetImage(Images.invoiceBottomBg),
//                                       fit: BoxFit.fill),
//                                   borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10))),
//                               child: Text.rich(
//                                 TextSpan(
//                                   children: <InlineSpan>[
//                                     TextSpan(
//                                       text: "total".tr,
//                                       style: robotoBold.copyWith(
//                                           fontSize: Dimensions.fontSizeLarge,
//                                           color: Colors.red.shade600),
//                                     ),
//                                     TextSpan(
//                                         text:
//                                             ' ${PriceConverter.convertPriceCurrency(double.parse(lotCtrl.invoiceModel[index].totalAmount.toString()))}',
//                                         style: robotoBold.copyWith(
//                                             fontSize: Dimensions.fontSizeLarge,
//                                             color: Colors.red.shade600))
//                                   ],
//                                 ),
//                               ),
//                               //Text("total".tr,style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge,color: Colors.red.shade800)),
//                             ),
//                           ),
//                           SizedBox(height: 10)
//                         ],
//                       ),
//                     );
//
//                     //   Card(
//                     //   shadowColor: Colors.red,
//                     //   child: Column(
//                     //     children: [
//                     //       ListTile(
//                     //         leading: CircleAvatar(
//                     //             radius: 20.0,
//                     //             backgroundColor: lotCtrl.invoiceModel[index].winStatus != null && lotCtrl.invoiceModel[index].winStatus == true ? Colors.green : Colors.deepOrange,
//                     //             child: Icon(
//                     //                 lotCtrl.invoiceModel[index].winStatus != null && lotCtrl.invoiceModel[index].winStatus == true ? Icons.check_circle_outline : Icons.assignment_turned_in)),
//                     //         title: Column(
//                     //           mainAxisAlignment: MainAxisAlignment.start,
//                     //           crossAxisAlignment: CrossAxisAlignment.start,
//                     //           children: [
//                     //             Text(
//                     //               "${DateConverter.dateToDateAndTime(lotCtrl.invoiceModel[index].saleDate)}",
//                     //               style: OptionTextStyle().optionStyle(),
//                     //             ),
//                     //             Text(
//                     //               "${"bill_no".tr}: ${lotCtrl.invoiceModel[index].lotoBillNo}",
//                     //               style: OptionTextStyle().optionStyle(),
//                     //             )
//                     //           ],
//                     //         ),
//                     //         subtitle: Wrap(
//                     //           runSpacing: 3.0,
//                     //           spacing: 3.0,
//                     //           children: [
//                     //             Text('${"lucky_no".tr}: ', style: OptionTextStyle().optionStyle()),
//                     //             for (int i = 0; i < lotCtrl.invoiceModel[index].details!.length; i++) ...[
//                     //               if (i <= 29)
//                     //                 Container(
//                     //                   padding: const EdgeInsets.all(1.0),
//                     //                   decoration: BoxDecoration(
//                     //                       // color: Colors.orange,
//                     //                       borderRadius: BorderRadius.circular(5),
//                     //                       border: Border.all(width: 1, color: Colors.redAccent)),
//                     //                   child: Text(
//                     //                     lotCtrl.invoiceModel[index].details![i].digit.toString(),
//                     //                   ),
//                     //                 ),
//                     //               if (i > 29 && i == (lotCtrl.invoiceModel[index].details!.length - 1))
//                     //                 Container(
//                     //                   padding: const EdgeInsets.all(1.0),
//                     //                   decoration: BoxDecoration(
//                     //                       // color: Colors.orange,
//                     //                       borderRadius: BorderRadius.circular(5),
//                     //                       border: Border.all(width: 1, color: Colors.redAccent)),
//                     //                   child: Text(
//                     //                     'More ${lotCtrl.invoiceModel[index].details!.length - 30} ...',
//                     //                     style: OptionTextStyle().optionStyle(null, Colors.red, null),
//                     //                   ),
//                     //                 ),
//                     //             ]
//                     //           ],
//                     //         ),
//                     //         trailing: Text(
//                     //           _formatNumber(lotCtrl.invoiceModel[index].totalAmount.toString()) + ' ₭',
//                     //           style: OptionTextStyle().optionStyle(16, Colors.deepOrange, FontWeight.bold),
//                     //         ),
//                     //         onTap: () {
//                     //           if (lotCtrl.invoiceModel[index].winStatus != null && lotCtrl.invoiceModel[index].winStatus == true) {
//                     //             Get.to(() => LottoInvoiceWonDetail(invoice: lotCtrl.invoiceModel[index]));
//                     //           } else {
//                     //             Get.to(() => LotteryHistoryDetail(invoice: lotCtrl.invoiceModel[index]));
//                     //           }
//                     //         },
//                     //       ),
//                     //     ],
//                     //   ),
//                     // );
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
