import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/modules/lottery_history/lottery_history_view.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/controller/lottery_controller.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../data/model/body/lotto_buy_number.dart';
import '../../../util/textStyle.dart';
import '../../base/message_alert_message.dart';
import 'lotto_dashboard.dart';
import 'lotto_number_list.dart';
import 'lotto_payment_option.dart';
import 'widgets/lotto_animal_books.dart';
import 'widgets/lotto_header_popup.dart';
import 'widgets/lotto_random_number.dart';

class LottoMain extends StatefulWidget {
  const LottoMain({Key? key}) : super(key: key);

  @override
  State<LottoMain> createState() => _LottoMainState();
}

class _LottoMainState extends State<LottoMain> {
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      Logger().w('LottoMainScreen');
    }
    getData();
  }

  void getData() async {
    Get.find<LotteryController>().getNumberList();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LotteryController>().getDashboard();
    });
    // Get.find<LotteryController>()
    //     .getPoints(Get.find<AuthController>().getUserNumber());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(
          'buyLottery'.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge1,
          ),
        ),
        backgroundColor: Colors.redAccent.shade700,
        actions: [
          InkWell(
            onTap: () {
              // Get.to(() => LottoMHI());
              Get.to(() => LotteryHistoryView());
            },
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.history, size: 28),
                  SizedBox(width: 4),
                  Text("ເບິ່ງບິນ", style: robotoBold),
                  SizedBox(width: 6)
                ],
              ),
            ),
          ),
        ],
      ),
      body: GetBuilder<LotteryController>(
        builder: (lotCtrl) {
          return OverlayLoaderWithAppIcon(
            isLoading: lotCtrl.dashboardLoading,
            appIcon: Image.asset(Images.loadingLogo),
            circularProgressColor: Colors.green.shade800,
            child: SafeArea(
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(Images.scnBackgroundPng),
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Visibility(
                          visible: lotCtrl.viewVisible == true,
                          child: LottoDashboard(),
                        ),
                        Visibility(
                          visible: lotCtrl.viewVisible == false,
                          child: LottoNumberList(),
                        ),
                      ],
                    ),
                  ),
                  lotCtrl.isNotFound
                      ? Align(
                          alignment: Alignment.center,
                          child: Center(
                            child: Text(
                              "${lotCtrl.errorMessage}",
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: Colors.redAccent.shade700,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  lotCtrl.closeSecond > 1 && lotCtrl.checkLot
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: BottomAppBar(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                lotCtrl.viewVisible == false
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8, top: 8),
                                        child: Row(
                                          children: [
                                            Text('total_amount'.tr,
                                                style: OptionTextStyle()
                                                    .optionStyle2(20, null,
                                                        FontWeight.bold)),
                                            Spacer(),
                                            Text(
                                                "${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.totalAmount.toString()))}",
                                                style: OptionTextStyle()
                                                    .optionStyle2(
                                                        20,
                                                        Colors.redAccent,
                                                        FontWeight.bold)),
                                            SizedBox(width: 5),
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6.0),
                                                child: Text('kip'.tr)),
                                          ],
                                        ),
                                      )
                                    : SizedBox(),
                                Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.addRandomBuy),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      //animal book
                                      InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  LottoAnimalBook());
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 18.0, left: 2, right: 4),
                                          width: 47,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  Images.bookAnimalBtn),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      //random lottery
                                      InkWell(
                                        onTap: () {
                                          lotCtrl.setSelectedChoice("6");
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) =>
                                                  LottoRandomNumber());
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 18.0, left: 2, right: 4),
                                          width: 47,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image:
                                                  AssetImage(Images.randomBtn),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 3.0),
                                              child: Text('inputNo'.tr,
                                                  style: OptionTextStyle()
                                                      .optionStyle(10.0, null,
                                                          FontWeight.bold)),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.only(
                                                  right: 2.0, bottom: 1.0),
                                              child: TypeAheadField(
                                                  direction: AxisDirection.up,
                                                  hideSuggestionsOnKeyboardHide:
                                                      true,
                                                  minCharsForSuggestions: 2,
                                                  suggestionsBoxVerticalOffset:
                                                      20.0,
                                                  // hideOnEmpty: true,
                                                  suggestionsBoxDecoration:
                                                      SuggestionsBoxDecoration(
                                                          shadowColor: Colors
                                                              .redAccent,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0)),
                                                  textFieldConfiguration:
                                                      TextFieldConfiguration(
                                                    textAlign: TextAlign.center,
                                                    focusNode:
                                                        lotCtrl.inputNode.value,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    // added by thin
                                                    inputFormatters: [
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp("[0-9,]"),
                                                      ),
                                                      // LengthLimitingTextInputFormatter(
                                                      //     6),
                                                    ],
                                                    // maxLength: 6, // added by thin
                                                    decoration: InputDecoration(
                                                        fillColor: Colors.white,
                                                        filled: true,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 5.0),
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0),
                                                                borderSide:
                                                                    BorderSide
                                                                        .none)),
                                                    controller: lotCtrl
                                                        .numberCtrl.value,
                                                    onChanged:
                                                        (String? newValue) {
                                                      lotCtrl
                                                          .setOnChangeSelectField(
                                                              newValue
                                                                  .toString());
                                                    },
                                                  ),
                                                  suggestionsCallback:
                                                      (pattern) async {
                                                    return lotCtrl
                                                        .getSuggestions(
                                                            pattern);
                                                  },
                                                  transitionBuilder: (context,
                                                      suggestionsBox,
                                                      controller) {
                                                    return suggestionsBox;
                                                  },
                                                  itemBuilder:
                                                      (context, suggestion) {
                                                    return Column(
                                                      children: [
                                                        ListTile(
                                                            title: Center(
                                                                child: Text(
                                                                    suggestion
                                                                        .toString()))),
                                                        lotCtrl.onChangeSelectField!
                                                                .isNotEmpty
                                                            ? TextButton(
                                                                onPressed: () {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) =>
                                                                              const LottoHeaderPopup());
                                                                },
                                                                child: Text(
                                                                    'ເພີ່ມຫຼັກ',
                                                                    style: OptionTextStyle()
                                                                        .optionStyle()))
                                                            : const SizedBox(),
                                                      ],
                                                    );
                                                  },
                                                  noItemsFoundBuilder:
                                                      (context) {
                                                    return TextButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder: (context) =>
                                                                  const LottoHeaderPopup());
                                                        },
                                                        child: Text('ເພີ່ມຫຼັກ',
                                                            style: OptionTextStyle()
                                                                .optionStyle()));
                                                  },
                                                  onSuggestionSelected:
                                                      (suggestion) {
                                                    lotCtrl.numberCtrl.value
                                                            .text =
                                                        suggestion.toString();
                                                  }),
                                            ),
                                          ],
                                        ),
                                      ),

                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10.0),
                                            child: Text('amount'.tr,
                                                style: OptionTextStyle()
                                                    .optionStyle(10.0, null,
                                                        FontWeight.bold)),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            padding: const EdgeInsets.only(
                                              right: 2.0,
                                              bottom: 8.0,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.8,
                                            height: 60,
                                            child: TypeAheadField(
                                                direction: AxisDirection.up,
                                                hideSuggestionsOnKeyboardHide:
                                                    true,
                                                suggestionsBoxVerticalOffset:
                                                    20.0,
                                                // hideOnEmpty: true,
                                                suggestionsBoxDecoration:
                                                    SuggestionsBoxDecoration(
                                                        shadowColor:
                                                            Colors.redAccent,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                10.0)),
                                                textFieldConfiguration:
                                                    TextFieldConfiguration(
                                                  focusNode:
                                                      lotCtrl.amountNode.value,
                                                  textAlign: TextAlign.center,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp("[0-9]"),
                                                    ),
                                                  ],
                                                  decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      contentPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              vertical: 5.0),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none)),
                                                  controller:
                                                      lotCtrl.amountCtrl.value,
                                                  onChanged:
                                                      (String? newValue) {},
                                                ),
                                                suggestionsCallback:
                                                    (pattern) async {
                                                  return lotCtrl
                                                      .getAmountSuggestions();
                                                },
                                                transitionBuilder: (context,
                                                    suggestionsBox,
                                                    controller) {
                                                  return suggestionsBox;
                                                },
                                                itemBuilder:
                                                    (context, suggestion) {
                                                  return ListTile(
                                                    title: Center(
                                                        child: Text(
                                                      PriceConverter
                                                          .convertPriceNoCurrency(
                                                              double.parse(
                                                                  suggestion
                                                                      .toString())),
                                                      style: OptionTextStyle()
                                                          .optionStyle(
                                                              12.0,
                                                              Colors.black87,
                                                              null),
                                                    )),
                                                  );
                                                },
                                                onSuggestionSelected:
                                                    (suggestion) {
                                                  lotCtrl.amountCtrl.value
                                                          .text =
                                                      suggestion.toString();
                                                }),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          lotCtrl.addNumberToList();
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              top: 18.0, left: 2, right: 4),
                                          width: 47,
                                          height: 48,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(Images.addBtn),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (lotCtrl.numberToPay().isNotEmpty) {
                                      LottoBuyNumber lottoBuyNumber =
                                          LottoBuyNumber();
                                      lottoBuyNumber.custPhone =
                                          Get.find<AuthController>()
                                              .getUserNumber();
                                      lottoBuyNumber.orders =
                                          lotCtrl.numberToPay();
                                      Get.to(() => LottoPaymentOption(
                                          lottoData: lottoBuyNumber));
                                    } else {
                                      showDialog(
                                        context: Get.context!,
                                        builder: (context) => MessageAlertMsg(
                                          'error',
                                          "invalid_number",
                                          Icons.error_outline,
                                          Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(Images.confirmBtn),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.lotNotOpenBtn),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
