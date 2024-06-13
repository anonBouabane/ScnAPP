import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/routes/app_pages.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/util/textStyle.dart';

import '../../languages/translates.dart';
import '../../models/buy_lottery_model.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/error_alert_widget.dart';
import 'buy_lottery_controller.dart';
import 'widgets/add_to_front_widget.dart';
import 'widgets/animal_book_widget.dart';
import 'widgets/lottery_dashboard_widget.dart';
import 'widgets/lottery_number_widget.dart';
import 'widgets/random_number_widget.dart';

class BuyLotteryView extends GetView<BuyLotteryController> {
  const BuyLotteryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            Translates.APP_TITLE_BUY_LOTTERY.tr,
            style: robotoBold.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge1,
            ),
          ),
          backgroundColor: Colors.redAccent.shade700,
          actions: [
            InkWell(
              onTap: () {
                Get.toNamed(Routes.INVOICE_RESULT_HISTORY);
              },
              child: Container(
                child: Row(
                  children: [
                    Icon(Icons.history, size: 28),
                    SizedBox(width: 4),
                    Text(Translates.VIEW_LOTTERY_HISTORY.tr, style: robotoBold),
                    SizedBox(width: 6)
                  ],
                ),
              ),
            ),
          ],
        ),
        body: OverlayLoaderWithAppIcon(
          isLoading: controller.isDataLoading.value,
          appIcon: Image.asset(Assets.newDesignLoadingLogo),
          circularProgressColor: Colors.green.shade800,
          child: Stack(
            children: [
              BackgroundWidget(),
              SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: controller.viewVisible == true,
                      child: LotteryDashboardWidget(),
                    ),
                    Visibility(
                      visible: controller.viewVisible == false,
                      child: LotteryNumberWidget(),
                    ),
                  ],
                ),
              ),

              /// Show/Hide Error Buy Lottery
              controller.isNotFound.isTrue
                  ? Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: Text(
                          '${controller.errorMessage.value}',
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),

              /// Show/Hide Buy Lottery or Closed
              controller.closeSecond.value > 1 && controller.checkLot.value
                  ? buildBuyLotteryMenu()
                  : buildLotteryNotOpen(),
            ],
          ),
        ),
      );
    });
  }

  Widget buildLotteryNotOpen() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.only(bottom: 30),
        height: 51,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.newDesignLotNotOpenBtn),
          ),
        ),
      ),
    );
  }

  Widget buildBuyLotteryMenu() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BottomAppBar(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            controller.viewVisible == false
                ? buildLotteryTotalAmount()
                : SizedBox.shrink(),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.newDesignBuyAddRandomBg),
                  fit: BoxFit.fill,
                ),
              ),
              child: Row(
                children: [
                  buildAnimalBookButton(),
                  buildLotteryRandomButton(),
                  buildLotteryInputNumber(),
                  buildLotteryInputAmount(),

                  /// ປຸ່ມເພີ່ມເລກທີ່ຊື້ເຂົ້າໃນ array sharedPreferences
                  GestureDetector(
                    onTap: controller.addNumberToList,
                    child: Container(
                      margin: const EdgeInsets.only(top: 18, left: 2, right: 4),
                      width: 47,
                      height: 48,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Assets.newDesignAddBtn),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// ປຸ່ມຢືນຢັນການຊື້ເລກ
            GestureDetector(
              onTap: () {
                // Logger().w('numberToPlay: ${controller.numberToPay().length}');
                if (controller.numberToPay().isNotEmpty) {
                  BuyLotteryModel buyLotteryModel = BuyLotteryModel();
                  buyLotteryModel.customerPhone =
                      controller.userController.userInfoModel.phone;
                  buyLotteryModel.orders = controller.numberToPay();
                  // Get.to(() => LottoPaymentOption(lottoData: buyLotteryModel));
                  Get.toNamed(Routes.PAYMENT, arguments: buyLotteryModel);
                } else {
                  Get.dialog(
                      ErrorAlertWidget(message: Translates.INVALID_NUMBER.tr));
                }
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.newDesignConfirmBtn),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLotteryTotalAmount() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Row(
        children: [
          Text(
            Translates.TOTAL_AMOUNT.tr,
            style: OptionTextStyle().optionStyle2(20, null, FontWeight.bold),
          ),
          Spacer(),
          Text(
            '${PriceConverter.convertPriceNoCurrency(double.parse(controller.totalAmount.toString()))}',
            style: OptionTextStyle()
                .optionStyle2(20, Colors.redAccent, FontWeight.bold),
          ),
          SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(Translates.KIP.tr),
          ),
        ],
      ),
    );
  }

  Widget buildAnimalBookButton() {
    return GestureDetector(
      onTap: () {
        Get.dialog(AnimalBookWidget());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 18, left: 2, right: 4),
        width: 47,
        height: 48,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.newDesignBookAnimalBtn),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildLotteryRandomButton() {
    return GestureDetector(
      onTap: () {
        controller.selectedChoice.value = '6';
        Get.dialog(barrierDismissible: false, RandomNumberWidget());
      },
      child: Container(
        margin: const EdgeInsets.only(top: 18, left: 2, right: 4),
        width: 47,
        height: 48,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.newDesignRandomBtn),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget buildLotteryInputNumber() {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              Translates.TEXT_FIELD_INPUT_NUMBER.tr,
              style: OptionTextStyle().optionStyle(10, null, FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 2, bottom: 1),
            child: TypeAheadField(
              direction: AxisDirection.up,
              hideSuggestionsOnKeyboardHide: true,
              minCharsForSuggestions: 2,
              suggestionsBoxVerticalOffset: 20,
              // hideOnEmpty: true,
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              textFieldConfiguration: TextFieldConfiguration(
                textAlign: TextAlign.center,
                focusNode: controller.inputNode,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp('[0-9,]'),
                  ),
                ],
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none),
                ),
                controller: controller.txtUpdateNumber,
                onChanged: (String? newValue) =>
                    controller.onChangeSelectField.value = newValue.toString(),
              ),
              suggestionsCallback: (pattern) async {
                return controller.getSuggestions(pattern);
              },
              transitionBuilder: (context, suggestionsBox, controller) {
                return suggestionsBox;
              },
              itemBuilder: (context, suggestion) {
                return Column(
                  children: [
                    ListTile(title: Center(child: Text(suggestion.toString()))),
                    controller.onChangeSelectField.isNotEmpty
                        ? TextButton(
                            onPressed: () {
                              Get.dialog(AddToFrontWidget());
                            },
                            child: Text(
                              Translates.BUTTON_ADD_LEADING.tr,
                              style: OptionTextStyle().optionStyle(),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
              noItemsFoundBuilder: (context) {
                return TextButton(
                  onPressed: () {
                    Get.dialog(AddToFrontWidget());
                  },
                  child: Text(
                    Translates.BUTTON_ADD_LEADING.tr,
                    style: OptionTextStyle().optionStyle(),
                  ),
                );
              },
              onSuggestionSelected: (suggestion) {
                controller.txtUpdateNumber.text = suggestion.toString();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildLotteryInputAmount() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            Translates.AMOUNT.tr,
            style: OptionTextStyle().optionStyle(10, null, FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 2, bottom: 8),
          width: Get.width / 4.8,
          height: 60,
          child: TypeAheadField(
            direction: AxisDirection.up,
            hideSuggestionsOnKeyboardHide: true,
            suggestionsBoxVerticalOffset: 20,
            // hideOnEmpty: true,
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
                shadowColor: Colors.redAccent,
                borderRadius: BorderRadius.circular(10)),
            textFieldConfiguration: TextFieldConfiguration(
              focusNode: controller.amountNode,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp('[0-9]'),
                ),
              ],
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 5),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none),
              ),
              controller: controller.txtUpdateAmount,
              onChanged: (String? newValue) {},
            ),
            suggestionsCallback: (pattern) async {
              return controller.getAmountSuggestions();
            },
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Center(
                  child: Text(
                    PriceConverter.convertPriceNoCurrency(
                        double.parse(suggestion.toString())),
                    style:
                        OptionTextStyle().optionStyle(12, Colors.black87, null),
                  ),
                ),
              );
            },
            onSuggestionSelected: (suggestion) {
              controller.txtUpdateAmount.text = suggestion.toString();
            },
          ),
        ),
      ],
    );
  }
}
