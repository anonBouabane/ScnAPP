import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../languages/translates.dart';
import '../../../widgets/error_alert_widget.dart';
import '../buy_lottery_controller.dart';

class RandomNumberWidget extends GetView<BuyLotteryController> {
  const RandomNumberWidget({Key? key}) : super(key: key);

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.red.shade800,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      child: Text(
        Translates.RANDOM_NUMBER.tr,
        style: robotoBold.copyWith(
          fontSize: Dimensions.fontSizeHugeLarge1,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildChoosePrefix() {
    return Obx(() {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int i = 0; i < controller.lotteryHeader.value; i++)
              GestureDetector(
                onTap: () {
                  controller.selectedChoice.value =
                      ((i + controller.lotteryMinNumber.value).toString());
                },
                child: Container(
                  margin: EdgeInsets.all(2),
                  padding: EdgeInsets.only(top: 4),
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: controller.selectedChoice.value ==
                            (i + controller.lotteryMinNumber.value).toString()
                        ? Colors.redAccent.shade700
                        : Colors.white,
                    border: Border.all(color: Colors.redAccent.shade700),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Center(
                    child: Text(
                      '${(i + controller.lotteryMinNumber.value)}',
                      style: robotoBold.copyWith(
                        color: controller.selectedChoice.value ==
                                (i + controller.lotteryMinNumber.value)
                                    .toString()
                            ? Colors.white
                            : Colors.black,
                        fontSize: Dimensions.fontSizeExtraLarge1,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Widget buildDigitForm(
    BuildContext context, {
    required TextEditingController controllerName,
    required FocusNode focusNode,
    required Function(String) onChanged,
  }) {
    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.all(2),
      child: TextFormField(
        controller: controllerName,
        style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
        textAlign: TextAlign.center,
        focusNode: focusNode,
        maxLength: 1,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '?',
          isDense: true,
          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 2,
          ),
        ),
      ),
    );
  }

  Widget buildQuantityAndAmount() {
    return Container(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(right: 4.0),
              child: Column(
                children: [
                  Text(
                    Translates.TOTAL_NUMBER.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.newDesignInputBg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.inputNumberToBuyController,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                children: [
                  Text(
                    Translates.AMOUNT.tr,
                    style:
                        robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  ),
                  Container(
                    height: 60,
                    padding: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Assets.newDesignInputBg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextFormField(
                      controller: controller.inputAmountToBuyController,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 2,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonCancelAndOk() {
    return Container(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10, right: 20, left: 20),
      margin: EdgeInsets.all(6),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.back();
                controller.onDialogCancel();
              },
              child: Container(
                height: 60,
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                decoration: BoxDecoration(
                  color: Colors.redAccent.shade700,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    Translates.BUTTON_CANCEL.tr,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge1,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (controller.selectedChoice.value == '6') {
                  if (controller.txtOneDigit.text != '' &&
                      controller.txtTwoDigit.text != '' &&
                      controller.txtThreeDigit.text != '' &&
                      controller.txtFourDigit.text != '' &&
                      controller.txtFiveDigit.text != '' &&
                      controller.txtSixDigit.text != '') {
                    Get.dialog(ErrorAlertWidget(
                      message:
                          'ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${controller.selectedChoice.value} ຫຼັກ',
                    ));
                  } else {
                    if (kDebugMode) {
                      Logger().w('sixDigit and Random');
                    }
                    controller.onRandom();
                  }
                } else if (controller.selectedChoice.value == '5') {
                  if (controller.txtOneDigit.text != '' &&
                      controller.txtTwoDigit.text != '' &&
                      controller.txtThreeDigit.text != '' &&
                      controller.txtFourDigit.text != '' &&
                      controller.txtFiveDigit.text != '') {
                    Get.dialog(ErrorAlertWidget(
                      message:
                          'ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${controller.selectedChoice.value} ຫຼັກ',
                    ));
                  } else {
                    controller.onRandom();
                  }
                } else if (controller.selectedChoice == '4') {
                  if (controller.txtOneDigit.text != '' &&
                      controller.txtTwoDigit.text != '' &&
                      controller.txtThreeDigit.text != '' &&
                      controller.txtFourDigit.text != '') {
                    Get.dialog(ErrorAlertWidget(
                      message:
                          'ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${controller.selectedChoice.value} ຫຼັກ',
                    ));
                  } else {
                    controller.onRandom();
                  }
                } else if (controller.selectedChoice == '3') {
                  if (controller.txtOneDigit.text != '' &&
                      controller.txtTwoDigit.text != '' &&
                      controller.txtThreeDigit.text != '') {
                    Get.dialog(ErrorAlertWidget(
                      message:
                          'ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${controller.selectedChoice.value} ຫຼັກ',
                    ));
                  } else {
                    controller.onRandom();
                  }
                } else if (controller.selectedChoice == '2') {
                  if (controller.txtOneDigit.text != '' &&
                      controller.txtTwoDigit.text != '') {
                    Get.dialog(ErrorAlertWidget(
                      message:
                          'ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${controller.selectedChoice.value} ຫຼັກ',
                    ));
                  } else {
                    controller.onRandom();
                  }
                }
                //  lotCtrl.onRandom();
              },
              child: Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.shade500,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    Translates.BUTTON_OK.tr,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge1,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SizedBox(
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildHeader(),
              Container(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  Translates.CHOOSE_PREFIX.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
              buildChoosePrefix(),
              Container(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  Translates.SET_NUMBER.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (controller.selectedChoice.value == '6') ...[
                      buildDigitForm(
                        context,
                        controllerName: controller.txtOneDigit,
                        focusNode: controller.fnOneDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnOneDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtTwoDigit,
                        focusNode: controller.fnTwoDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnOneDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtThreeDigit,
                        focusNode: controller.fnThreeDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          } else if (value.length == 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtFourDigit,
                        focusNode: controller.fnFourDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFiveDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtFiveDigit,
                        focusNode: controller.fnFiveDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnFiveDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnSixDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnFiveDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtSixDigit,
                        focusNode: controller.fnSixDigit,
                        onChanged: (value) {
                          if (value.length == 0) {
                            controller.fnSixDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFiveDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnSixDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFiveDigit);
                          }
                        },
                      ),
                    ] else if (controller.selectedChoice.value == '5') ...[
                      buildDigitForm(
                        context,
                        controllerName: controller.txtOneDigit,
                        focusNode: controller.fnOneDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnOneDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtTwoDigit,
                        focusNode: controller.fnTwoDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnOneDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtThreeDigit,
                        focusNode: controller.fnThreeDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          } else if (value.length == 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtFourDigit,
                        focusNode: controller.fnFourDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFiveDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtFiveDigit,
                        focusNode: controller.fnFiveDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnFiveDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnSixDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnFiveDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          }
                        },
                      ),
                    ] else if (controller.selectedChoice.value == '4') ...[
                      buildDigitForm(
                        context,
                        controllerName: controller.txtOneDigit,
                        focusNode: controller.fnOneDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnOneDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtTwoDigit,
                        focusNode: controller.fnTwoDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnOneDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtThreeDigit,
                        focusNode: controller.fnThreeDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          } else if (value.length == 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtFourDigit,
                        focusNode: controller.fnFourDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFiveDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnFourDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          }
                        },
                      ),
                    ] else if (controller.selectedChoice.value == '3') ...[
                      buildDigitForm(
                        context,
                        controllerName: controller.txtOneDigit,
                        focusNode: controller.fnOneDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnOneDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtTwoDigit,
                        focusNode: controller.fnTwoDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnOneDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtThreeDigit,
                        focusNode: controller.fnThreeDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnFourDigit);
                          } else if (value.length == 0) {
                            controller.fnThreeDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                    ] else if (controller.selectedChoice.value == '2') ...[
                      buildDigitForm(
                        context,
                        controllerName: controller.txtOneDigit,
                        focusNode: controller.fnOneDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnOneDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnTwoDigit);
                          }
                        },
                      ),
                      buildDigitForm(
                        context,
                        controllerName: controller.txtTwoDigit,
                        focusNode: controller.fnTwoDigit,
                        onChanged: (value) {
                          if (value.length > 0) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnThreeDigit);
                          } else if (value.length == 0 && value.isEmpty) {
                            controller.fnTwoDigit.unfocus();
                            FocusScope.of(context)
                                .requestFocus(controller.fnOneDigit);
                          }
                        },
                      ),
                    ]
                  ],
                ),
              ),
              buildQuantityAndAmount(),
              buildButtonCancelAndOk(),
            ],
          ),
        ),
      ),
    );
  }
}
