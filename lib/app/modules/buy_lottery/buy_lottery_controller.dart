import 'dart:async';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';

import '../../apis/api_exception.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/user_controller.dart';
import '../../languages/translates.dart';
import '../../models/buy_lottery_model.dart';
import '../../models/cart.dart';
import '../../models/lottery_history_model.dart';
import '../../widgets/error_alert_widget.dart';
import 'amount_model.dart';
import 'animal_model.dart';
import 'buy_lottery_service.dart';

class BuyLotteryController extends GetxController {
  final BuyLotteryService buyLotteryService = Get.find<BuyLotteryService>();
  final UserController userController = Get.find<UserController>();
  final CartController cartController = Get.find<CartController>();
  late ScrollController scrollController;
  RxBool isDataLoading = false.obs;
  RxBool dashboardLoading = false.obs;
  bool get viewVisible => cartController.carts.isEmpty ? true : false;
  RxString onChangeSelectField = ''.obs;
  RxBool checkLot = false.obs;
  RxInt closeSecond = 0.obs;
  RxString second = ''.obs;
  RxBool isNotFound = false.obs;
  RxString errorMessage = ''.obs;
  RxString selectedChoice = ''.obs;
  RxInt selectedIndex = 0.obs;

  /// Random Number
  RxInt lotteryHeader = 6.obs;
  RxInt lotteryMinNumber = 1.obs;
  late TextEditingController txtOneDigit,
      txtTwoDigit,
      txtThreeDigit,
      txtFourDigit,
      txtFiveDigit,
      txtSixDigit,
      inputNumberToBuyController,
      inputAmountToBuyController,
      txtUpdateNumber,
      txtUpdateAmount,
      txtLeadingNumber,
      txtEditNumber,
      txtEditAmount;
  late FocusNode fnOneDigit,
      fnTwoDigit,
      fnThreeDigit,
      fnFourDigit,
      fnFiveDigit,
      fnSixDigit,
      inputNode,
      amountNode;

  /// Count Down
  Timer? timer;
  Duration? timeUntilDue;
  RxInt daysUntil = 0.obs;
  RxInt hoursUntil = 0.obs;
  RxInt minutesUntil = 0.obs;
  RxInt secondsUntil = 0.obs;
  RxInt millisecond = 0.obs;
  RxList<DrawItem> dashboard = <DrawItem>[].obs;

  /// Number
  RxNum totalAmount = RxNum(0);
  // RxList<LotteryNumberItem> numberModel = <LotteryNumberItem>[].obs;
  RxList<String> selectedChoices = <String>[].obs;
  RxList<String> selectedChoicesList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    txtUpdateNumber = TextEditingController();
    txtUpdateAmount = TextEditingController(text: '5000');
    txtLeadingNumber = TextEditingController();
    inputNode = FocusNode();
    amountNode = FocusNode();
    txtOneDigit = TextEditingController(text: '');
    txtTwoDigit = TextEditingController(text: '');
    txtThreeDigit = TextEditingController(text: '');
    txtFourDigit = TextEditingController(text: '');
    txtFiveDigit = TextEditingController(text: '');
    txtSixDigit = TextEditingController(text: '');
    inputNumberToBuyController = TextEditingController(text: '10');
    inputAmountToBuyController = TextEditingController(text: '1000');
    txtEditNumber = TextEditingController();
    txtEditAmount = TextEditingController();
    fnOneDigit = FocusNode();
    fnTwoDigit = FocusNode();
    fnThreeDigit = FocusNode();
    fnFourDigit = FocusNode();
    fnFiveDigit = FocusNode();
    fnSixDigit = FocusNode();
    loadDashboard();
    checkLotOpenClose();
    totalAmount.value = 0;
    cartController.carts.forEach((element) {
      totalAmount.value += element.amount;
    });
  }

  @override
  void onClose() {
    super.onClose();
    txtUpdateNumber.dispose();
    txtUpdateAmount.dispose();
    txtLeadingNumber.dispose();
    inputNode.dispose();
    amountNode.dispose();
    txtOneDigit.dispose();
    txtTwoDigit.dispose();
    txtThreeDigit.dispose();
    txtFourDigit.dispose();
    txtFiveDigit.dispose();
    txtSixDigit.dispose();
    inputNumberToBuyController.dispose();
    inputAmountToBuyController.dispose();
    txtEditNumber.dispose();
    txtEditAmount.dispose();
    fnOneDigit.dispose();
    fnTwoDigit.dispose();
    fnThreeDigit.dispose();
    fnFourDigit.dispose();
    fnFiveDigit.dispose();
    fnSixDigit.dispose();
    scrollController.dispose();
  }

  onDialogCancel() {
    txtSixDigit.clear();
    txtFiveDigit.clear();
    txtFourDigit.clear();
    txtThreeDigit.clear();
    txtTwoDigit.clear();
  }

  void onRandom() {
    int headNo =
        int.parse(selectedChoice.value == '' ? '0' : selectedChoice.value);
    String allNumbers = txtOneDigit.text +
        txtTwoDigit.text +
        txtThreeDigit.text +
        txtFourDigit.text +
        txtFiveDigit.text +
        txtSixDigit.text;

    int trailNo = allNumbers.length;
    int selectHeadAndTrail = headNo + trailNo;

    if (kDebugMode) {
      Logger().e('onRandom: $headNo\n'
          'allNumbers: $allNumbers\n'
          'selectHeadAndTrail: $selectHeadAndTrail');
    }

    if (selectHeadAndTrail < 1) {
      Get.dialog(
          ErrorAlertWidget(message: Translates.NUMBER_NOT_ALLOW_EMPTY.tr));
    } else if (double.parse(inputAmountToBuyController.text) < 1000) {
      Get.dialog(ErrorAlertWidget(
          message:
              Translates.AMOUNT_SHOULD_MORE_THAN_OR_EQUAL_ONE_THOUSAND.tr));
    } else if (double.parse(inputAmountToBuyController.text) % 1000 != 0) {
      Get.dialog(ErrorAlertWidget(message: Translates.INVALID_AMOUNT.tr));
    } else {
      if (kDebugMode) {
        Logger().w('Random');
      }
      generateRandomLotteryNumber();
      txtUpdateAmount.text = inputAmountToBuyController.text;
      addNumberToList(fromAnother: true);
      txtSixDigit.clear();
      txtFiveDigit.clear();
      txtFourDigit.clear();
      txtThreeDigit.clear();
      txtTwoDigit.clear();
      txtOneDigit.clear();
      Get.back();
    }
  }

  void generateRandomLotteryNumber() {
    int headNo =
        int.parse(selectedChoice.value == '' ? '0' : selectedChoice.value);
    String allNumbers = txtOneDigit.text +
        txtTwoDigit.text +
        txtThreeDigit.text +
        txtFourDigit.text +
        txtFiveDigit.text +
        txtSixDigit.text;

    String fourDigitFirstNumbers = txtTwoDigit.text +
        txtThreeDigit.text +
        txtFourDigit.text +
        txtFiveDigit.text;
    String fourDigitLastNumbers = txtThreeDigit.text +
        txtFourDigit.text +
        txtFiveDigit.text +
        txtSixDigit.text;

    String threeDigitFirstNumbers =
        txtTwoDigit.text + txtThreeDigit.text + txtFourDigit.text;
    String threeDigitLastNumbers =
        txtFourDigit.text + txtFiveDigit.text + txtSixDigit.text;

    String twoDigitFirstNumbers = txtTwoDigit.text + txtThreeDigit.text;
    String twoDigitLastNumbers = txtFiveDigit.text + txtSixDigit.text;

    String oneDigitFirstNumbers = txtTwoDigit.text;
    String oneDigitLastNumbers = txtSixDigit.text;

    int trailNo = allNumbers.length;
    int selectHeadAndTrail = headNo + trailNo;
    List<String> randomNumberList = [];
    for (int j = 0; j < int.parse(inputNumberToBuyController.text); j++) {
      String randomNumber = '';
      String randomAllNumber = '';
      Random rnd = Random();
      if (allNumbers == '') {
        for (int i = 0; i < selectHeadAndTrail; i++) {
          randomNumber = randomNumber + rnd.nextInt(9).toString();
        }
        randomNumberList.add(randomNumber);
      } else {
        if (selectedChoice.value != '' && allNumbers != '' && headNo == 6) {
          for (int i = 0; i < (headNo); i++) {
            randomNumber = randomNumber + rnd.nextInt(9).toString();
          }
          //1,2,3,4,5
          if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber.replaceRange(
                0,
                5,
                txtOneDigit.text +
                    txtTwoDigit.text +
                    txtThreeDigit.text +
                    txtFourDigit.text +
                    txtFiveDigit.text);
          }
          //1,2,3,5,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 3,
                    txtOneDigit.text + txtTwoDigit.text + txtThreeDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,2,4,5,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,2,5,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,2,3,4
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '') {
            randomAllNumber = randomNumber.replaceRange(
                0,
                4,
                txtOneDigit.text +
                    txtTwoDigit.text +
                    txtThreeDigit.text +
                    txtFourDigit.text);
          }
          //1,2,3,5
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 3,
                    txtOneDigit.text + txtTwoDigit.text + txtThreeDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text);
          }
          //1,2,4,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,2,3,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 3,
                    txtOneDigit.text + txtTwoDigit.text + txtThreeDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,2,3
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtThreeDigit.text != '') {
            randomAllNumber = randomNumber.replaceRange(
                0, 3, txtOneDigit.text + txtTwoDigit.text + txtThreeDigit.text);
          }
          //1,2,4
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtFourDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(3, 4, txtFourDigit.text);
          }
          //1,2,5
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text);
          }
          //1,2,6
          else if (txtOneDigit.text != '' &&
              txtTwoDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,3,4,5,6
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,3,5,6
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,5,6
          else if (txtOneDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,3,4,5
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text);
          }
          //1,3,4,6
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }

          //1,3,6
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,3,5
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text);
          }
          //1,3,4
          else if (txtOneDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(2, 3, txtThreeDigit.text)
                .replaceRange(3, 4, txtFourDigit.text);
          }
          //1,4,5,6
          else if (txtOneDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1,4,5
          else if (txtOneDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(4, 5, txtFiveDigit.text);
          }

          //1,4,6
          else if (txtOneDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, txtOneDigit.text)
                .replaceRange(3, 4, txtFourDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //1
          else if (txtOneDigit.text != '') {
            randomAllNumber = randomNumber.replaceRange(0, 1, txtOneDigit.text);
            if (txtTwoDigit.text != '') {
              randomAllNumber = randomNumber
                  .replaceRange(1, 2, txtTwoDigit.text)
                  .replaceRange(0, 1, txtOneDigit.text);
            } else if (txtThreeDigit.text != '') {
              randomAllNumber = randomNumber
                  .replaceRange(2, 3, txtThreeDigit.text)
                  .replaceRange(0, 1, txtOneDigit.text);
            } else if (txtFourDigit.text != '') {
              randomAllNumber = randomNumber
                  .replaceRange(3, 4, txtFourDigit.text)
                  .replaceRange(0, 1, txtOneDigit.text);
            } else if (txtFiveDigit.text != '') {
              randomAllNumber = randomNumber
                  .replaceRange(4, 5, txtFiveDigit.text)
                  .replaceRange(0, 1, txtOneDigit.text);
            } else if (txtSixDigit.text != '') {
              randomAllNumber = randomNumber
                  .replaceRange(5, 6, txtSixDigit.text)
                  .replaceRange(0, 1, txtOneDigit.text);
            }
          }
          //2,3,4,5,6
          else if (txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber.replaceRange(1, 6, allNumbers);
          }
          //2,3,4,6
          else if (txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber = randomNumber
                .replaceRange(1, 4,
                    txtTwoDigit.text + txtThreeDigit.text + txtFourDigit.text)
                .replaceRange(5, 6, txtSixDigit.text);
          }
          //2,3,4,5
          else if (txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(1, 5, fourDigitFirstNumbers);
          }
          //2,3,4
          else if (txtTwoDigit.text != '' &&
              txtThreeDigit.text != '' &&
              txtFourDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(1, 4, threeDigitFirstNumbers);
          }
          //2,3
          else if (txtTwoDigit.text != '' && txtThreeDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(1, 3, twoDigitFirstNumbers);
          } else if (txtTwoDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(1, 2, oneDigitFirstNumbers);
            if (txtFourDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(3, 4, txtFourDigit.text);
            }
            if (txtFiveDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(4, 5, txtFiveDigit.text);
            }
            if (txtSixDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(5, 6, txtSixDigit.text);
            }
          } else if (txtThreeDigit.text != '' &&
              txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(2, 6, fourDigitLastNumbers);
          } else if (txtFourDigit.text != '' &&
              txtFiveDigit.text != '' &&
              txtSixDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(3, 6, threeDigitLastNumbers);
          } else if (txtFiveDigit.text != '' && txtSixDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(4, 6, twoDigitLastNumbers);
          } else if (txtSixDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(5, 6, oneDigitLastNumbers);
            if (txtFourDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(3, 4, txtFourDigit.text);
            }
            if (txtThreeDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(2, 3, txtThreeDigit.text);
            }
          } else if (txtThreeDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(2, 3, txtThreeDigit.text);
            if (txtFourDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(3, 4, txtFourDigit.text);
            }
            if (txtFiveDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(4, 5, txtFiveDigit.text);
            }
          } else if (txtFourDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(3, 4, txtFourDigit.text);
            if (txtSixDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(5, 6, txtSixDigit.text);
            }
            if (txtFiveDigit.text != '') {
              randomAllNumber =
                  randomAllNumber.replaceRange(4, 5, txtFiveDigit.text);
            }
          } else if (txtFiveDigit.text != '') {
            randomAllNumber =
                randomNumber.replaceRange(4, 5, txtFiveDigit.text);
          }
          randomNumberList.add(randomAllNumber);
        } else {
          if (trailNo > 0) {
            if (int.parse(selectedChoice.value) == 5) {
              for (int i = 0; i < 5; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    0,
                    4,
                    txtOneDigit.text +
                        txtTwoDigit.text +
                        txtThreeDigit.text +
                        txtFourDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, txtOneDigit.text)
                    .replaceRange(2, 4, txtThreeDigit.text + txtFourDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(
                        0,
                        3,
                        txtOneDigit.text +
                            txtTwoDigit.text +
                            txtThreeDigit.text)
                    .replaceRange(4, 5, txtFiveDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtFourDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 2, txtOneDigit.text + txtTwoDigit.text)
                    .replaceRange(3, 4, txtFourDigit.text)
                    .replaceRange(4, 5, txtFiveDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    0,
                    4,
                    txtOneDigit.text +
                        txtTwoDigit.text +
                        txtThreeDigit.text +
                        txtFourDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(0, 3,
                    txtOneDigit.text + txtTwoDigit.text + txtThreeDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, txtOneDigit.text)
                    .replaceRange(2, 3, txtThreeDigit.text)
                    .replaceRange(4, 5, txtFiveDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, txtOneDigit.text)
                    .replaceRange(1, 2, txtTwoDigit.text)
                    .replaceRange(4, 5, txtFiveDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, txtOneDigit.text)
                    .replaceRange(1, 2, txtTwoDigit.text)
                    .replaceRange(3, 4, txtFourDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtFourDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, txtOneDigit.text)
                    .replaceRange(3, 4, txtFourDigit.text)
                    .replaceRange(4, 5, txtFiveDigit.text);
              } else if (txtOneDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, txtOneDigit.text);
                if (txtTwoDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, txtTwoDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtThreeDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, txtThreeDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtFourDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, txtFourDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtFiveDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(4, 5, txtFiveDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                }
              } else if (txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    1,
                    5,
                    txtTwoDigit.text +
                        txtThreeDigit.text +
                        txtFourDigit.text +
                        txtFiveDigit.text);
              } else if (txtThreeDigit.text != '' &&
                  txtFourDigit.text != '' &&
                  txtFiveDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(2, 5,
                    txtThreeDigit.text + txtFourDigit.text + txtFiveDigit.text);
              } else if (txtFourDigit.text != '' && txtFiveDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    3, 5, txtFourDigit.text + txtFiveDigit.text);
              } else if (txtThreeDigit.text != '' && txtFourDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    2, 4, txtThreeDigit.text + txtFourDigit.text);
              } else if (txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(1, 4,
                    txtTwoDigit.text + txtThreeDigit.text + txtFourDigit.text);
              } else if (txtTwoDigit.text != '' && txtThreeDigit.text != '') {
                randomAllNumber = randomNumber.replaceRange(
                    1, 3, txtTwoDigit.text + txtThreeDigit.text);
              } else if (txtTwoDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, txtTwoDigit.text);
                if (txtFourDigit.text != '') {
                  randomAllNumber =
                      randomAllNumber.replaceRange(3, 4, txtFourDigit.text);
                }
                if (txtFiveDigit.text != '') {
                  randomAllNumber =
                      randomAllNumber.replaceRange(4, 5, txtFiveDigit.text);
                }
              } else if (txtThreeDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(2, 3, txtThreeDigit.text);
                if (txtFiveDigit.text != '') {
                  randomAllNumber =
                      randomAllNumber.replaceRange(4, 5, txtFiveDigit.text);
                }
              } else if (txtFourDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(3, 4, txtFourDigit.text);
              } else if (txtFiveDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(4, 5, txtFiveDigit.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(selectedChoice.value) == 4) {
              for (int i = 0; i < 4; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(2, 3, txtThreeDigit.text)
                    .replaceRange(1, 2, txtTwoDigit.text)
                    .replaceRange(0, 1, txtOneDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtTwoDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, txtFourDigit.text)
                    .replaceRange(1, 2, txtTwoDigit.text)
                    .replaceRange(0, 1, txtOneDigit.text);
              } else if (txtOneDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, txtFourDigit.text)
                    .replaceRange(2, 3, txtThreeDigit.text)
                    .replaceRange(0, 1, txtOneDigit.text);
              } else if (txtTwoDigit.text != '' &&
                  txtThreeDigit.text != '' &&
                  txtFourDigit.text != '') {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, txtFourDigit.text)
                    .replaceRange(2, 3, txtThreeDigit.text)
                    .replaceRange(1, 2, txtTwoDigit.text);
              } else if (txtOneDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, txtOneDigit.text);
                if (txtTwoDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, txtTwoDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtThreeDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, txtThreeDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtFourDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, txtFourDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                }
              } else if (txtTwoDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, txtTwoDigit.text);
                if (txtThreeDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, txtThreeDigit.text)
                      .replaceRange(1, 2, txtTwoDigit.text);
                } else if (txtFourDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, txtFourDigit.text)
                      .replaceRange(1, 2, txtTwoDigit.text);
                }
              } else if (txtThreeDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(2, 3, txtThreeDigit.text);
                if (txtFourDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, txtFourDigit.text)
                      .replaceRange(2, 3, txtThreeDigit.text);
                }
              } else if (txtFourDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(3, 4, txtFourDigit.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(selectedChoice.value) == 3) {
              for (int i = 0; i < 3; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (txtOneDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, txtOneDigit.text);
                if (txtTwoDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, txtTwoDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                } else if (txtThreeDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, txtThreeDigit.text)
                      .replaceRange(0, 1, txtOneDigit.text);
                }
              } else if (txtTwoDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, txtTwoDigit.text);
                if (txtThreeDigit.text != '') {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, txtThreeDigit.text)
                      .replaceRange(1, 2, txtTwoDigit.text);
                }
              } else if (txtThreeDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(2, 3, txtThreeDigit.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(selectedChoice.value) == 2) {
              for (int i = 0; i < 2; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }

              if (txtOneDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, txtOneDigit.text);
              } else if (txtTwoDigit.text != '') {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, txtTwoDigit.text);
              }
              // Get.back();
              randomNumberList.add(randomAllNumber);
            }
          }
        }
      }
    }
    txtUpdateNumber.text = randomNumberList.join(',');
  }

  RxBool isOpenAddFrontNumber = false.obs;

  void addBySubList(int index, int i) {
    if (selectedChoices.contains(getChoiceList()[index].split(',')[i])) {
      selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      selectedChoices.remove(getChoiceList()[index]);
    } else {
      selectedChoices.remove(getChoiceList()[index]);
      selectedChoices.add(getChoiceList()[index].split(',')[i]);
    }
    selectedChoicesList = selectedChoices;
    txtUpdateNumber.text = selectedChoicesList.join(',');
    isOpenAddFrontNumber.value = true;
    update();
  }

  void addByFullSet(int index) {
    if (selectedChoices.contains(getChoiceList()[index])) {
      selectedChoices.remove(getChoiceList()[index]);
      for (int i = 0; i < getChoiceList()[index].split(',').length; i++) {
        selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      }
    } else {
      for (int i = 0; i < getChoiceList()[index].split(',').length; i++) {
        selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      }
      selectedChoices.add(getChoiceList()[index]);
    }
    selectedChoicesList = selectedChoices;
    txtUpdateNumber.text = selectedChoicesList.join(',');
    isOpenAddFrontNumber.value = true;
    update();
  }

  List<LotteryNumberItem> numberToPay() {
    List<LotteryNumberItem> numberModel = [];
    List<LotteryNumberItem> newNumberModel = [];
    // List<Cart> cartList = [];
    for (Cart item in cartController.carts) {
      numberModel.add(LotteryNumberItem(
        number: item.number,
        amount: item.amount,
      ));
    }
    // numberModel.addAll(cartController.carts.value);

    ///Check number duplicate
    final numbers = <String, int>{};
    for (int i = 0; i < numberModel.length; i++) {
      final item = numberModel[i];
      final itemName = item.number;
      final qty = item.amount;
      int previousValue = 0;
      if (numbers.containsKey(itemName)) {
        previousValue = numbers[itemName]!;
      }
      previousValue = previousValue + qty!;
      numbers[itemName!] = previousValue;
    }
    numbers.forEach((key, value) {
      newNumberModel.add(LotteryNumberItem(number: key, amount: value));
    });

    return newNumberModel;
  }

  final List<AmountModel> amountSuggestionList = [
    AmountModel(amount: '10000'),
    AmountModel(amount: '9000'),
    AmountModel(amount: '8000'),
    AmountModel(amount: '7000'),
    AmountModel(amount: '6000'),
    AmountModel(amount: '5000'),
    AmountModel(amount: '4000'),
    AmountModel(amount: '3000'),
    AmountModel(amount: '2000'),
    AmountModel(amount: '1000'),
  ];
  List<String> getAmountSuggestions() {
    List<String> matches = [];
    for (int i = 0; i < amountSuggestionList.length; i++) {
      matches.add(amountSuggestionList[i].amount.toString());
    }
    return matches;
  }

  List<AnimalModel> animalList = [
    AnimalModel(
        name: 'small_fish',
        lotteryNo: '01,41,81',
        img: 'assets/lotto/img/goldfish.png'),
    AnimalModel(
        name: 'snail',
        lotteryNo: '02,42,82',
        img: 'assets/lotto/img/snail.png'),
    AnimalModel(
        name: 'goose',
        lotteryNo: '03,43,83',
        img: 'assets/lotto/img/goose.png'),
    AnimalModel(
        name: 'peacock',
        lotteryNo: '04,44,84',
        img: 'assets/lotto/img/poem.png'),
    AnimalModel(
        name: 'lion', lotteryNo: '05,45,85', img: 'assets/lotto/img/lion.png'),
    AnimalModel(
        name: 'tiger',
        lotteryNo: '06,46,86',
        img: 'assets/lotto/img/tiger.png'),
    AnimalModel(
        name: 'pig', lotteryNo: '07,47,87', img: 'assets/lotto/img/pig.png'),
    AnimalModel(
        name: 'rabbit',
        lotteryNo: '08,48,88',
        img: 'assets/lotto/img/rabit.png'),
    AnimalModel(
        name: 'buffalo',
        lotteryNo: '09,49,89',
        img: 'assets/lotto/img/buffalo.png'),
    AnimalModel(
        name: 'otter', lotteryNo: '10,50,90', img: 'assets/lotto/img/seal.png'),
    AnimalModel(
        name: 'dog', lotteryNo: '11,51,91', img: 'assets/lotto/img/dog.png'),
    AnimalModel(
        name: 'horse',
        lotteryNo: '12,52,92',
        img: 'assets/lotto/img/horse.png'),
    AnimalModel(
        name: 'elephant',
        lotteryNo: '13,53,93',
        img: 'assets/lotto/img/elephant.png'),
    AnimalModel(
        name: 'cat', lotteryNo: '14,54,94', img: 'assets/lotto/img/cat.png'),
    AnimalModel(
        name: 'rat', lotteryNo: '15,55,95', img: 'assets/lotto/img/rat.png'),
    AnimalModel(
        name: 'bee', lotteryNo: '16,56,96', img: 'assets/lotto/img/bee.png'),
    AnimalModel(
        name: 'egret',
        lotteryNo: '17,57,97',
        img: 'assets/lotto/img/bird3.png'),
    AnimalModel(
        name: 'bobcat',
        lotteryNo: '18,58,98',
        img: 'assets/lotto/img/eurasian.png'),
    AnimalModel(
        name: 'butterfly',
        lotteryNo: '19,59,99',
        img: 'assets/lotto/img/buterfly.png'),
    AnimalModel(
        name: 'centipede',
        lotteryNo: '20,60,00',
        img: 'assets/lotto/img/chinese_red_headed.png'),
    AnimalModel(
        name: 'swallow',
        lotteryNo: '21,61',
        img: 'assets/lotto/img/swallow.png'),
    AnimalModel(
        name: 'pigeon', lotteryNo: '22,62', img: 'assets/lotto/img/bird1.png'),
    AnimalModel(
        name: 'monkey', lotteryNo: '23,63', img: 'assets/lotto/img/monkey.png'),
    AnimalModel(
        name: 'frog', lotteryNo: '24,64', img: 'assets/lotto/img/fog.png'),
    AnimalModel(
        name: 'falcon', lotteryNo: '25,65', img: 'assets/lotto/img/bird2.png'),
    AnimalModel(
        name: 'flying_otter',
        lotteryNo: '26,66',
        img: 'assets/lotto/img/dragon.png'),
    AnimalModel(
        name: 'turtle', lotteryNo: '27,67', img: 'assets/lotto/img/turtle.png'),
    AnimalModel(
        name: 'rooster',
        lotteryNo: '28,68',
        img: 'assets/lotto/img/chicken.png'),
    AnimalModel(
        name: 'eel', lotteryNo: '29,69', img: 'assets/lotto/img/eel.png'),
    AnimalModel(
        name: 'big_fish', lotteryNo: '30,70', img: 'assets/lotto/img/fish.png'),
    AnimalModel(
        name: 'praw', lotteryNo: '31,71', img: 'assets/lotto/img/shrimps.png'),
    AnimalModel(
        name: 'snake', lotteryNo: '32,72', img: 'assets/lotto/img/snack.png'),
    AnimalModel(
        name: 'spider', lotteryNo: '33,73', img: 'assets/lotto/img/spider.png'),
    AnimalModel(
        name: 'deer', lotteryNo: '34,74', img: 'assets/lotto/img/deer.png'),
    AnimalModel(
        name: 'goat', lotteryNo: '35,75', img: 'assets/lotto/img/goat.png'),
    AnimalModel(
        name: 'palm_civet',
        lotteryNo: '36,76',
        img: 'assets/lotto/img/pngtree_civet.png'),
    AnimalModel(
        name: 'pangolin', lotteryNo: '37,77', img: 'assets/lotto/img/ecad.png'),
    AnimalModel(
        name: 'hedgehog',
        lotteryNo: '38,78',
        img: 'assets/lotto/img/exhibition.png'),
    AnimalModel(
        name: 'crab',
        lotteryNo: '39,79',
        img: 'assets/lotto/img/blue-crab.png'),
    AnimalModel(
        name: 'eagle', lotteryNo: '40,80', img: 'assets/lotto/img/orel.png'),
  ];
  List<String> getSuggestions(String query, {bool isSelected = false}) {
    List<String> matches = [];
    for (int i = 0; i < animalList.length; i++) {
      matches.add(animalList[i].lotteryNo!);
    }
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  List<String> getChoiceList() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].lotteryNo!);
    }
    return choiceList;
  }

  List<String> getChoiceListImg() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].img!);
    }
    return choiceList;
  }

  List<String> getNameList() {
    List<String> choiceNameList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceNameList.add(animalList[i].name.toString());
    }
    return choiceNameList;
  }

  String getAnimalImage(String lotteryNumber) {
    String result = '';
    if (lotteryNumber == '01' ||
        lotteryNumber == '41' ||
        lotteryNumber == '81') {
      result = 'assets/images/animals/01.png';
    } else if (lotteryNumber == '02' ||
        lotteryNumber == '42' ||
        lotteryNumber == '82') {
      result = 'assets/images/animals/02.png';
    } else if (lotteryNumber == '03' ||
        lotteryNumber == '43' ||
        lotteryNumber == '83') {
      result = 'assets/images/animals/03.png';
    } else if (lotteryNumber == '04' ||
        lotteryNumber == '44' ||
        lotteryNumber == '84') {
      result = 'assets/images/animals/04.png';
    } else if (lotteryNumber == '05' ||
        lotteryNumber == '45' ||
        lotteryNumber == '85') {
      result = 'assets/images/animals/05.png';
    } else if (lotteryNumber == '06' ||
        lotteryNumber == '46' ||
        lotteryNumber == '86') {
      result = 'assets/images/animals/06.png';
    } else if (lotteryNumber == '07' ||
        lotteryNumber == '47' ||
        lotteryNumber == '87') {
      result = 'assets/images/animals/07.png';
    } else if (lotteryNumber == '08' ||
        lotteryNumber == '48' ||
        lotteryNumber == '88') {
      result = 'assets/images/animals/08.png';
    } else if (lotteryNumber == '09' ||
        lotteryNumber == '49' ||
        lotteryNumber == '89') {
      result = 'assets/images/animals/02.png';
    } else if (lotteryNumber == '10' ||
        lotteryNumber == '50' ||
        lotteryNumber == '90') {
      result = 'assets/images/animals/10.png';
    } else if (lotteryNumber == '11' ||
        lotteryNumber == '51' ||
        lotteryNumber == '91') {
      result = 'assets/images/animals/11.png';
    } else if (lotteryNumber == '12' ||
        lotteryNumber == '52' ||
        lotteryNumber == '92') {
      result = 'assets/images/animals/12.png';
    } else if (lotteryNumber == '13' ||
        lotteryNumber == '53' ||
        lotteryNumber == '93') {
      result = 'assets/images/animals/13.png';
    } else if (lotteryNumber == '14' ||
        lotteryNumber == '54' ||
        lotteryNumber == '94') {
      result = 'assets/images/animals/14.png';
    } else if (lotteryNumber == '15' ||
        lotteryNumber == '55' ||
        lotteryNumber == '95') {
      result = 'assets/images/animals/15.png';
    } else if (lotteryNumber == '16' ||
        lotteryNumber == '56' ||
        lotteryNumber == '96') {
      result = 'assets/images/animals/16.png';
    } else if (lotteryNumber == '17' ||
        lotteryNumber == '57' ||
        lotteryNumber == '97') {
      result = 'assets/images/animals/17.png';
    } else if (lotteryNumber == '18' ||
        lotteryNumber == '58' ||
        lotteryNumber == '98') {
      result = 'assets/images/animals/18.png';
    } else if (lotteryNumber == '19' ||
        lotteryNumber == '59' ||
        lotteryNumber == '99') {
      result = 'assets/images/animals/19.png';
    } else if (lotteryNumber == '20' ||
        lotteryNumber == '60' ||
        lotteryNumber == '00') {
      result = 'assets/images/animals/20.png';
    } else if (lotteryNumber == '21' || lotteryNumber == '61') {
      result = 'assets/images/animals/21.png';
    } else if (lotteryNumber == '22' || lotteryNumber == '62') {
      result = 'assets/images/animals/22.png';
    } else if (lotteryNumber == '23' || lotteryNumber == '63') {
      result = 'assets/images/animals/23.png';
    } else if (lotteryNumber == '24' || lotteryNumber == '64') {
      result = 'assets/images/animals/24.png';
    } else if (lotteryNumber == '25' || lotteryNumber == '65') {
      result = 'assets/images/animals/25.png';
    } else if (lotteryNumber == '26' || lotteryNumber == '66') {
      result = 'assets/images/animals/26.png';
    } else if (lotteryNumber == '27' || lotteryNumber == '67') {
      result = 'assets/images/animals/27.png';
    } else if (lotteryNumber == '28' || lotteryNumber == '68') {
      result = 'assets/images/animals/28.png';
    } else if (lotteryNumber == '29' || lotteryNumber == '69') {
      result = 'assets/images/animals/29.png';
    } else if (lotteryNumber == '30' || lotteryNumber == '70') {
      result = 'assets/images/animals/30.png';
    } else if (lotteryNumber == '31' || lotteryNumber == '71') {
      result = 'assets/images/animals/31.png';
    } else if (lotteryNumber == '32' || lotteryNumber == '72') {
      result = 'assets/images/animals/32.png';
    } else if (lotteryNumber == '33' || lotteryNumber == '73') {
      result = 'assets/images/animals/33.png';
    } else if (lotteryNumber == '34' || lotteryNumber == '74') {
      result = 'assets/images/animals/34.png';
    } else if (lotteryNumber == '35' || lotteryNumber == '75') {
      result = 'assets/images/animals/35.png';
    } else if (lotteryNumber == '36' || lotteryNumber == '76') {
      result = 'assets/images/animals/36.png';
    } else if (lotteryNumber == '37' || lotteryNumber == '77') {
      result = 'assets/images/animals/37.png';
    } else if (lotteryNumber == '38' || lotteryNumber == '78') {
      result = 'assets/images/animals/38.png';
    } else if (lotteryNumber == '39' || lotteryNumber == '79') {
      result = 'assets/images/animals/39.png';
    } else if (lotteryNumber == '40' || lotteryNumber == '80') {
      result = 'assets/images/animals/40.png';
    }
    return result;
  }

  Future<void> checkLotOpenClose() async {
    final response = await buyLotteryService.checkLotteryOpen();
    if (kDebugMode) {
      Logger().i(
        'check status: ${response.statusCode}\n'
        'close: ${response.data}',
      );
    }
    if (response.statusCode == 200) {
      checkLot.value = true;
    } else if (response.statusCode == 404) {
      checkLot.value = false;
      clearAllNumberList();
    }
  }

  loadDashboard() async {
    try {
      dashboardLoading.value = true;
      final json = await buyLotteryService.loadResults(limit: 2, offset: 0);

      if (json.statusCode == 200) {
        isNotFound.value = false;
        errorMessage.value = 'Success';
        var response = LotteryHistoryModel.fromJson(json.data);
        dashboard.addAll(LotteryHistoryModel.fromJson(json.data).draws!);
        if (dashboard.isNotEmpty && response.drawTime != '' ||
            response.drawTime != null ||
            response.drawTime!.isNotEmpty) {
          String date = response.drawTime.toString();

          DateFormat format = DateFormat('dd/MM/yyyy hh:mm');
          getTimeCountDown(format.parse(date));
          if (dashboard.isNotEmpty && dashboard[0].winNumber != '') {
            clearAllNumberList();
          }
        }
      }
      dashboardLoading.value = false;
    } on DioException catch (error) {
      dashboardLoading.value = false;
      isNotFound.value = true;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
      errorMessage.value = apiException.message;
    }
  }

  Future<void> getTimeCountDown(DateTime due) async {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      DateTime startDate = await NTP.now();
      timeUntilDue = due.difference(startDate);
      daysUntil.value = timeUntilDue!.inDays;
      hoursUntil.value = timeUntilDue!.inHours - (daysUntil.value * 24);
      minutesUntil.value = timeUntilDue!.inMinutes -
          (daysUntil.value * 24 * 60) -
          (hoursUntil.value * 60);
      secondsUntil.value = timeUntilDue!.inSeconds - (minutesUntil.value * 60);
      millisecond.value = timeUntilDue!.inMilliseconds;
      second.value = secondsUntil.value.toString().length <= 2
          ? secondsUntil.toString()
          : secondsUntil
              .toString()
              .substring(secondsUntil.toString().length - 2);
      if (millisecond.value < 1) {
        timer.cancel();
      }
      closeSecond.value = millisecond.value;
    });
  }

  void scrollToBottom() {
    if (scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 500)).then((value) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      });
    }
  }

  Set<String> invalidChars = {
    '.',
    '-',
    ' ',
    ':',
    ';',
    '+',
    '(',
    ')',
    '=',
    '/',
    '\\',
    '|',
    '&',
    '%',
    '\$',
    '@',
    '!',
    '~',
    '`',
    '*',
    '#'
  };
  void addNumberToList({bool fromAnother = false}) {
    if (txtUpdateNumber.text.length < 1) {
      Get.dialog(
          ErrorAlertWidget(message: Translates.NUMBER_NOT_ALLOW_EMPTY.tr));
    } else if (double.parse(txtUpdateAmount.text) < 1000) {
      Get.dialog(ErrorAlertWidget(
          message:
              Translates.AMOUNT_SHOULD_MORE_THAN_OR_EQUAL_ONE_THOUSAND.tr));
    } else if (double.parse(txtUpdateAmount.text) % 1000 != 0) {
      Get.dialog(ErrorAlertWidget(message: Translates.INVALID_AMOUNT.tr));
    } else {
      String str = txtUpdateNumber.text;
      List<String> numberArray = str.split(',');
      for (int i = 0; i < numberArray.length; i++) {
        if (numberArray[i].length > 6) {
          Get.dialog(ErrorAlertWidget(
              message: Translates.YOU_CAN_BUY_ONE_TO_SIX_DIGIT.tr));
          txtUpdateNumber.clear();
        } else if (numberArray[i].length == 0 ||
            invalidChars.any((char) => numberArray[i].contains(char))) {
          Get.dialog(ErrorAlertWidget(message: Translates.INVALID_NUMBER.tr));
          txtUpdateNumber.clear();
        } else {
          LotteryNumberItem number = LotteryNumberItem(
            number: numberArray[i],
            amount: int.parse(txtUpdateAmount.text),
          );
          addNumberToCart(number);
          selectedChoices.value = [];
        }
      }
    }
    scrollToBottom();
    if (fromAnother) {
      selectedChoices.value = [];
      inputNode.unfocus();
    } else {
      inputNode.requestFocus();
    }
  }

  void addNumberToCart(LotteryNumberItem item) {
    totalAmount.value = 0;
    // numberModel.add(item);
    String image =
        getAnimalImage(item.number!.substring(item.number!.length - 2));
    cartController.addCart(item.number!, item.amount!, image);
    txtUpdateNumber.clear();
    cartController.carts.forEach((element) {
      totalAmount.value += element.amount;
    });
    // numberModel.forEach((element) {
    //   totalAmount.value += element.amount!;
    // });
  }

  void editNumberFormCart(int index, String editNumber) {
    totalAmount.value = 0;
    String image = getAnimalImage(editNumber.substring(editNumber.length - 2));
    cartController.editNumber(index, editNumber, image);
    txtUpdateNumber.clear();
    cartController.carts.forEach((element) {
      totalAmount.value += element.amount;
    });
  }

  void editAmountFormCart(int index) {
    totalAmount.value = 0;
    cartController.editAmount(index, int.parse(txtEditAmount.text));
    txtUpdateNumber.clear();
    cartController.carts.forEach((element) {
      totalAmount.value += element.amount;
    });
  }

  void removeFromCart(int index) {
    totalAmount.value = 0;
    // numberModel.removeAt(index);
    cartController.deleteCart(index);
    // numberModel.forEach((element) {
    //   totalAmount.value += element.amount!;
    // });
    cartController.carts.forEach((element) {
      totalAmount.value += element.amount;
    });
  }

  void clearAllNumberList() {
    totalAmount.value = 0;
    cartController.clearCart();
    // numberModel.value = [];
    txtUpdateNumber.clear();
    inputNode.unfocus();
  }
}
