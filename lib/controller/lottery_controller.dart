import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:ntp/ntp.dart';
import 'package:pubnub/networking.dart';
import 'package:pubnub/pubnub.dart';
import 'package:scn_easy/app/modules/lottery_history/invoice/lottery_invoice_history_model.dart';
import 'package:scn_easy/data/api/api_checker.dart';
import 'package:scn_easy/data/model/body/lotto_animal_book.dart';
import 'package:scn_easy/data/model/response/lotto_history.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:scn_easy/view/screens/lottery/lottery_history/lotto_invoice_detail.dart';
import 'package:url_launcher/url_launcher.dart';

import '../data/model/body/lotto_amount_sugestion.dart';
import '../data/model/body/lotto_buy_number.dart';
import '../data/model/body/lotto_laoviet_payment.dart';
import '../data/model/body/lotto_payment_option.dart';
import '../data/model/body/m_money.dart';
import '../data/model/response/lottery_buy_reponse.dart';
import '../data/model/response/lotto_bank_payment_options.dart';
import '../data/model/response/lotto_bonus_detail.dart';
import '../data/model/response/lotto_bonus_model.dart';
import '../data/model/response/lotto_bonus_referral.dart';
import '../data/model/response/lotto_invoice.dart';
import '../data/model/response/lotto_point_statements.dart';
import '../data/model/response/lotto_reward_id_reponse_model.dart';
import '../data/repository/lottery_repo.dart';
import '../util/lotto_img.dart';
import '../util/styles.dart';
import '../view/base/m_money_confirm_dialog.dart';
import '../view/base/message_alert_message.dart';
import '../view/screens/lottery/widgets/lotto_custom_alert.dart';
import 'auth_controller.dart';

class LotteryController extends GetxController implements GetxService {
  final LotteryRepo lotteryRepo;

  LotteryController({required this.lotteryRepo});
  RxString accessToken = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setLottoIndex(true);
    checkLotOpenClose();
    getBankPaymentOptions();
    // getPoints(Get.find<AuthController>().getUserNumber());
    checkResponse(Get.find<AuthController>().getUserNumber());
    // accessToken.value = Get.find<AuthController>().accessToken;
  }

  @override
  void dispose() {
    super.dispose();
    numberCtrl.value.dispose();
    headerNumberCtrl.value.dispose();
    amountCtrl.value.dispose();
    editAmountCtrl.value.dispose();
    editNumberCtrl.value.dispose();
    referralCode.value.dispose();

    sixDigitNumber.value.dispose();
    fiveDigitNumber.value.dispose();
    fourDigitNumber.value.dispose();
    threeDigitNumber.value.dispose();
    twoDigitNumber.value.dispose();
    inputNumberTobuyController.value.dispose();
    inputAmountTobuyController.value.dispose();

    scrollController.dispose();
    setLottoIndex(true);
  }

  int _topNavSelectedIndex = 0;
  int get topNavSelectedIndex => _topNavSelectedIndex;
  PageController? _pageController;
  void setTopNavSelectedIndex(value) {
    _topNavSelectedIndex = value;
    _pageController!.jumpToPage(value);
    update();
  }

  List<LottoNumber> _numberModel = [];

  int _totalAmount = 0;

  int get totalAmount => _totalAmount;

  List<LottoNumber> get numberModel => _numberModel;

  get viewVisible => _numberModel.isEmpty ? true : false;

  final referralCode = TextEditingController().obs;

  final numberCtrl = TextEditingController().obs;
  final headerNumberCtrl = TextEditingController().obs;
  final amountCtrl = TextEditingController(text: '1000').obs;
  final editAmountCtrl = TextEditingController().obs;
  final editNumberCtrl = TextEditingController().obs;
  final amountNode = FocusNode().obs;
  final inputNode = FocusNode().obs;

  bool _isOpenAddFrontNumber = false;

  bool get isOpenAddFrontNumber => _isOpenAddFrontNumber;

  setAddInFrontNumber(bool add) {
    _isOpenAddFrontNumber = add;
    update();
  }

  String? _onChangeSelectField;

  String? get onChangeSelectField => _onChangeSelectField;

  List<LottoAnimalBookModel> animalList = [
    LottoAnimalBookModel(
        name: 'small_fish',
        lotteryNo: '01,41,81',
        img: 'assets/lotto/img/goldfish.png'),
    LottoAnimalBookModel(
        name: 'snail',
        lotteryNo: '02,42,82',
        img: 'assets/lotto/img/snail.png'),
    LottoAnimalBookModel(
        name: 'goose',
        lotteryNo: '03,43,83',
        img: 'assets/lotto/img/goose.png'),
    LottoAnimalBookModel(
        name: 'peacock',
        lotteryNo: '04,44,84',
        img: 'assets/lotto/img/poem.png'),
    LottoAnimalBookModel(
        name: 'lion', lotteryNo: '05,45,85', img: 'assets/lotto/img/lion.png'),
    LottoAnimalBookModel(
        name: 'tiger',
        lotteryNo: '06,46,86',
        img: 'assets/lotto/img/tiger.png'),
    LottoAnimalBookModel(
        name: 'pig', lotteryNo: '07,47,87', img: 'assets/lotto/img/pig.png'),
    LottoAnimalBookModel(
        name: 'rabbit',
        lotteryNo: '08,48,88',
        img: 'assets/lotto/img/rabit.png'),
    LottoAnimalBookModel(
        name: 'buffalo',
        lotteryNo: '09,49,89',
        img: 'assets/lotto/img/buffalo.png'),
    LottoAnimalBookModel(
        name: 'otter', lotteryNo: '10,50,90', img: 'assets/lotto/img/seal.png'),
    LottoAnimalBookModel(
        name: 'dog', lotteryNo: '11,51,91', img: 'assets/lotto/img/dog.png'),
    LottoAnimalBookModel(
        name: 'horse',
        lotteryNo: '12,52,92',
        img: 'assets/lotto/img/horse.png'),
    LottoAnimalBookModel(
        name: 'elephant',
        lotteryNo: '13,53,93',
        img: 'assets/lotto/img/elephant.png'),
    LottoAnimalBookModel(
        name: 'cat', lotteryNo: '14,54,94', img: 'assets/lotto/img/cat.png'),
    LottoAnimalBookModel(
        name: 'rat', lotteryNo: '15,55,95', img: 'assets/lotto/img/rat.png'),
    LottoAnimalBookModel(
        name: 'bee', lotteryNo: '16,56,96', img: 'assets/lotto/img/bee.png'),
    LottoAnimalBookModel(
        name: 'egret',
        lotteryNo: '17,57,97',
        img: 'assets/lotto/img/bird3.png'),
    LottoAnimalBookModel(
        name: 'bobcat',
        lotteryNo: '18,58,98',
        img: 'assets/lotto/img/eurasian.png'),
    LottoAnimalBookModel(
        name: 'butterfly',
        lotteryNo: '19,59,99',
        img: 'assets/lotto/img/buterfly.png'),
    LottoAnimalBookModel(
        name: 'centipede',
        lotteryNo: '20,60,00',
        img: 'assets/lotto/img/chinese_red_headed.png'),
    LottoAnimalBookModel(
        name: 'swallow',
        lotteryNo: '21,61',
        img: 'assets/lotto/img/swallow.png'),
    LottoAnimalBookModel(
        name: 'pigeon', lotteryNo: '22,62', img: 'assets/lotto/img/bird1.png'),
    LottoAnimalBookModel(
        name: 'monkey', lotteryNo: '23,63', img: 'assets/lotto/img/monkey.png'),
    LottoAnimalBookModel(
        name: 'frog', lotteryNo: '24,64', img: 'assets/lotto/img/fog.png'),
    LottoAnimalBookModel(
        name: 'falcon', lotteryNo: '25,65', img: 'assets/lotto/img/bird2.png'),
    LottoAnimalBookModel(
        name: 'flying_otter',
        lotteryNo: '26,66',
        img: 'assets/lotto/img/dragon.png'),
    LottoAnimalBookModel(
        name: 'turtle', lotteryNo: '27,67', img: 'assets/lotto/img/turtle.png'),
    LottoAnimalBookModel(
        name: 'rooster',
        lotteryNo: '28,68',
        img: 'assets/lotto/img/chicken.png'),
    LottoAnimalBookModel(
        name: 'eel', lotteryNo: '29,69', img: 'assets/lotto/img/eel.png'),
    LottoAnimalBookModel(
        name: 'big_fish', lotteryNo: '30,70', img: 'assets/lotto/img/fish.png'),
    LottoAnimalBookModel(
        name: 'praw', lotteryNo: '31,71', img: 'assets/lotto/img/shrimps.png'),
    LottoAnimalBookModel(
        name: 'snake', lotteryNo: '32,72', img: 'assets/lotto/img/snack.png'),
    LottoAnimalBookModel(
        name: 'spider', lotteryNo: '33,73', img: 'assets/lotto/img/spider.png'),
    LottoAnimalBookModel(
        name: 'deer', lotteryNo: '34,74', img: 'assets/lotto/img/deer.png'),
    LottoAnimalBookModel(
        name: 'goat', lotteryNo: '35,75', img: 'assets/lotto/img/goat.png'),
    LottoAnimalBookModel(
        name: 'palm_civet',
        lotteryNo: '36,76',
        img: 'assets/lotto/img/pngtree_civet.png'),
    LottoAnimalBookModel(
        name: 'pangolin', lotteryNo: '37,77', img: 'assets/lotto/img/ecad.png'),
    LottoAnimalBookModel(
        name: 'hedgehog',
        lotteryNo: '38,78',
        img: 'assets/lotto/img/exhibition.png'),
    LottoAnimalBookModel(
        name: 'crab',
        lotteryNo: '39,79',
        img: 'assets/lotto/img/blue-crab.png'),
    LottoAnimalBookModel(
        name: 'eagle', lotteryNo: '40,80', img: 'assets/lotto/img/orel.png'),
  ];

  List<String> getSuggestions(String query, {bool isSelected = false}) {
    List<String> matches = [];
    for (int i = 0; i < animalList.length; i++) {
      matches.add(animalList[i].lotteryNo!);
    }
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
    // return matches;
  }

  ///multi choice
  List<String> getChoiceList() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].lotteryNo!);
    }
    return choiceList;
  }

  ///multi choice Image
  List<String> getChoiceListImg() {
    List<String> choiceList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceList.add(animalList[i].img!);
    }
    return choiceList;
  }

  ///Get Name for Result Screen
  List<String> getNameList() {
    List<String> choiceNameList = [];
    for (int i = 0; i < animalList.length; i++) {
      choiceNameList.add(animalList[i].name.toString());
    }
    return choiceNameList;
  }

  final List<LottoAmountSuggestion> amountSuggestionList = [
    LottoAmountSuggestion(amount: "10000"),
    LottoAmountSuggestion(amount: "9000"),
    LottoAmountSuggestion(amount: "8000"),
    LottoAmountSuggestion(amount: "7000"),
    LottoAmountSuggestion(amount: "6000"),
    LottoAmountSuggestion(amount: "5000"),
    LottoAmountSuggestion(amount: "4000"),
    LottoAmountSuggestion(amount: "3000"),
    LottoAmountSuggestion(amount: "2000"),
    LottoAmountSuggestion(amount: "1000"),
  ];

  List<String> getAmountSuggestions() {
    List<String> matches = [];
    for (int i = 0; i < amountSuggestionList.length; i++) {
      matches.add(amountSuggestionList[i].amount.toString());
    }
    return matches;
  }

  ///Add Lottery
  ///--------------------------------------------------------------------------------
  void addNumber(LottoNumber number) {
    _totalAmount = 0;
    _numberModel.add(number);
    lotteryRepo.addToNumberList(_numberModel);
    numberCtrl.value.clear();
    _numberModel.forEach((element) {
      _totalAmount += element.amount!;
    });
    update();
  }

  // bool isNumeric(String s) {
  //   if (s == null) {
  //     return false;
  //   }
  //   return double.tryParse(s) != null;
  // }

  void addNumberToList({bool fromAnother = false}) {
    if (numberCtrl.value.text.length < 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          "number_not_allow_empty",
          Icons.error_outline,
          Colors.red,
        ),
      );
    } else if (double.parse(amountCtrl.value.text) < 1000) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          "amount_should_than_1000",
          Icons.error_outline,
          Colors.red,
        ),
      );
    } else if (double.parse(amountCtrl.value.text) % 1000 != 0) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          "invalid_amount",
          Icons.error_outline,
          Colors.red,
        ),
      );
    } else {
      String str = numberCtrl.value.text;
      List<String> numberArray = str.split(",");
      for (int i = 0; i < numberArray.length; i++) {
        if (numberArray[i].length > 6) {
          showDialog(
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              "you_can_buy_123456",
              Icons.error_outline,
              Colors.red,
            ),
          );
          numberCtrl.value.clear();
        } else if (numberArray[i].contains(".") ||
            numberArray[i].contains("-") ||
            numberArray[i].contains(" ") ||
            numberArray[i].contains(":") ||
            numberArray[i].contains(";") ||
            numberArray[i].contains("+") ||
            numberArray[i].contains("(") ||
            numberArray[i].contains(")") ||
            numberArray[i].contains("=") ||
            numberArray[i].contains("/") ||
            numberArray[i].contains("\\") ||
            numberArray[i].contains("|") ||
            numberArray[i].contains("&") ||
            numberArray[i].contains("%") ||
            numberArray[i].contains("\$") ||
            numberArray[i].contains("@") ||
            numberArray[i].contains("!") ||
            numberArray[i].contains("~") ||
            numberArray[i].contains("`") ||
            numberArray[i].contains("*") ||
            numberArray[i].contains("#") ||
            numberArray[i].length == 0) {
          showDialog(
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              "invalid_number",
              Icons.error_outline,
              Colors.red,
            ),
          );
          numberCtrl.value.clear();
          // } else if (!isNumeric(numberArray[i])) {
          //   showDialog(
          //     context: Get.context!,
          //     builder: (context) => MessageAlertMsg(
          //       'error',
          //       "invalid_number",
          //       Icons.error_outline,
          //       Colors.red,
          //     ),
          //   );
        } else {
          LottoNumber number = LottoNumber(
              number: numberArray[i], amount: int.parse(amountCtrl.value.text));
          addNumber(number);
          _selectedChoices = [];
        }
      }
    }
    scrollToBottom();
    if (fromAnother) {
      clearAnimalSelectedBox();
      inputNode.value.unfocus();
    } else {
      inputNode.value.requestFocus();
    }
  }

  void showErrorDialog({String? title, String? msg}) {
    Get.defaultDialog(
      title: title.toString().tr,
      content: Column(
        children: [
          Icon(Icons.info_outline_rounded),
          Text(msg.toString().tr, style: robotoBlack),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text(
          'close'.tr,
          style: robotoRegular,
        ),
      ),
      barrierDismissible: false,
      titleStyle: robotoBlack.copyWith(color: Colors.red),
      middleTextStyle: robotoBlack,
      radius: 10,
    );
  }

  ///Clear Lottery List
  void clearAllNumberList() {
    _totalAmount = 0;
    lotteryRepo.clearNumber();
    _numberModel = [];
    numberCtrl.value.clear();
    inputNode.value.unfocus();
    update();
  }

  ///Get Lottery List
  void getNumberList() {
    _numberModel = [];
    _totalAmount = 0;
    _numberModel.addAll(lotteryRepo.getNumberList());
    _numberModel.forEach((element) {
      _totalAmount += element.amount!;
    });
  }

  List<LottoNumber> numberToPay() {
    List<LottoNumber> numberModel = [];
    List<LottoNumber> newNumberModel = [];
    numberModel.addAll(lotteryRepo.getNumberList());

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
      newNumberModel.add(LottoNumber(number: key, amount: value));
    });

    return newNumberModel;
  }

  ///Remove from cart with position index
  ///--------------------------------------------------------------------------------
  void removeFromCart(int index) {
    _totalAmount = 0;
    _numberModel.removeAt(index);
    lotteryRepo.addToNumberList(_numberModel);
    _numberModel.forEach((element) {
      _totalAmount += element.amount!;
    });
    update();
  }

  void decrementOneAmountFromCart(int index) {
    if (_numberModel[index].amount! > 1000) {
      _totalAmount = 0;
      _numberModel[index].amount = _numberModel[index].amount! - 1000;
      lotteryRepo.addToNumberList(_numberModel);
      _numberModel.forEach((element) {
        _totalAmount += element.amount!;
      });
    }

    update();
  }

  void incrementOneAmountFromCart(int index) {
    _totalAmount = 0;
    _numberModel[index].amount = _numberModel[index].amount! + 1000;
    lotteryRepo.addToNumberList(_numberModel);
    _numberModel.forEach((element) {
      _totalAmount += element.amount!;
    });

    update();
  }

  // void editNumberInCart(int index) {
  //   if (editNumberCtrl.value.text.isNotEmpty) {
  //     String str = editNumberCtrl.value.text;
  //     if (str.length > 6) {
  //       Get.back();
  //       showDialog(barrierDismissible: true, context: Get.context!, builder: (context) => LottoCustomAlert(message: "you_can_buy_123456", isOkText: true));
  //     } else if (str.contains(".") || str.contains(",")) {
  //       Get.back();
  //       showDialog(barrierDismissible: false, context: Get.context!, builder: (context) => LottoCustomAlert(message: "invalid_number", isOkText: true));
  //     } else {
  //       _numberModel[index].number = editNumberCtrl.value.text.toString().trim();
  //       lotteryRepo.addToNumberList(_numberModel);
  //       editNumberCtrl.value.clear();
  //       Get.back();
  //     }
  //   }
  //   update();
  // }

  ///Listview jump to last
  ///--------------------------------------------------------------------------------
  ScrollController scrollController = ScrollController();

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

  void setOnChangeSelectField(String onChange) {
    _onChangeSelectField = onChange;
    if (_onChangeSelectField == "") {
      _onChangeSelectField = null;
    }
    update();
  }

  ///Animal books List Popup section
  ///--------------------------------------------------------------------------------
  List<String> _selectedChoices = [];
  List<String> _selectedChoicesList = [];

  List<String> get selectedChoices => _selectedChoices;

  List<String> get selectedChoicesList => _selectedChoicesList;

  void addBySubList(int index, int i) {
    if (_selectedChoices.contains(getChoiceList()[index].split(',')[i])) {
      _selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      _selectedChoices.remove(getChoiceList()[index]);
    } else {
      _selectedChoices.remove(getChoiceList()[index]);
      _selectedChoices.add(getChoiceList()[index].split(',')[i]);
    }
    _selectedChoicesList = _selectedChoices;
    numberCtrl.value.text = _selectedChoicesList.join(',');
    setAddInFrontNumber(true);
    update();
  }

  void addByFullSet(int index) {
    if (_selectedChoices.contains(getChoiceList()[index])) {
      _selectedChoices.remove(getChoiceList()[index]);
      for (int i = 0; i < getChoiceList()[index].split(',').length; i++) {
        _selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      }
    } else {
      for (int i = 0; i < getChoiceList()[index].split(',').length; i++) {
        _selectedChoices.remove(getChoiceList()[index].split(',')[i]);
      }
      _selectedChoices.add(getChoiceList()[index]);
    }
    _selectedChoicesList = _selectedChoices;
    numberCtrl.value.text = _selectedChoicesList.join(',');
    _isOpenAddFrontNumber = true;
    update();
  }

  void clearAnimalSelectedBox() {
    _selectedChoices = [];
    update();
  }

  ///Random Lottery Numbers
  ///--------------------------------------------------------------------------------
  String _selectedChoice = "";

  final inputNumberTobuyController = TextEditingController(text: '10').obs;
  final inputAmountTobuyController = TextEditingController(text: '1000').obs;
  final sixDigitNumber = TextEditingController(text: "").obs;
  final sixDigitNumberFocus = FocusNode().obs;
  final fiveDigitNumber = TextEditingController(text: "").obs;
  final fiveDigitNumberFocus = FocusNode().obs;
  final fourDigitNumber = TextEditingController(text: "").obs;
  final fourDigitNumberFocus = FocusNode().obs;
  final threeDigitNumber = TextEditingController(text: "").obs;
  final threeDigitNumberFocus = FocusNode().obs;
  final twoDigitNumber = TextEditingController(text: "").obs;
  final twoDigitNumberFocus = FocusNode().obs;
  final oneDigitNumber = TextEditingController(text: "").obs;
  final oneDigitNumberFocus = FocusNode().obs;

  int _lotteryHeader = 6;
  int _lotteryMinNumber = 1;

  int get lotteryHeader => _lotteryHeader;

  int get lotteryMinNumber => _lotteryMinNumber;

  String get selectedChoice => _selectedChoice;

  void setSelectedChoice(choice) {
    _selectedChoice = choice;
    update();
  }

  void onRandom() {
    var headNo = int.parse(_selectedChoice == "" ? "0" : _selectedChoice);
    var allNumbers = oneDigitNumber.value.text +
        twoDigitNumber.value.text +
        threeDigitNumber.value.text +
        fourDigitNumber.value.text +
        fiveDigitNumber.value.text +
        sixDigitNumber.value.text;
    var trailNo = allNumbers.length;
    var selectHeadAndTrail = headNo + trailNo;
    if (selectHeadAndTrail < 1) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "number_not_allow_empty",
          isOkText: true,
        ),
      );
    } else if (double.parse(inputAmountTobuyController.value.text) < 1000) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "amount_should_than_1000",
          isOkText: true,
        ),
      );
    } else if (double.parse(inputAmountTobuyController.value.text) % 1000 !=
        0) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "invalid_amount",
          isOkText: true,
        ),
      );
    } else {
      generateRandomLotteryNumber();
      amountCtrl.value.text = inputAmountTobuyController.value.text;
      addNumberToList(fromAnother: true);
      sixDigitNumber.value.clear();
      fiveDigitNumber.value.clear();
      fourDigitNumber.value.clear();
      threeDigitNumber.value.clear();
      twoDigitNumber.value.clear();
      oneDigitNumber.value.clear();
      Get.back();
    }
    update();
  }

  void generateRandomLotteryNumber() {
    var headNo = int.parse(_selectedChoice == "" ? "0" : _selectedChoice);
    var allNumbers = oneDigitNumber.value.text +
        twoDigitNumber.value.text +
        threeDigitNumber.value.text +
        fourDigitNumber.value.text +
        fiveDigitNumber.value.text +
        sixDigitNumber.value.text;

    var fourDigitFirstNumbers = twoDigitNumber.value.text +
        threeDigitNumber.value.text +
        fourDigitNumber.value.text +
        fiveDigitNumber.value.text;
    var fourDigitLastNumbers = threeDigitNumber.value.text +
        fourDigitNumber.value.text +
        fiveDigitNumber.value.text +
        sixDigitNumber.value.text;

    var threeDigitFirstNumbers = twoDigitNumber.value.text +
        threeDigitNumber.value.text +
        fourDigitNumber.value.text;
    var threeDigitLastNumbers = fourDigitNumber.value.text +
        fiveDigitNumber.value.text +
        sixDigitNumber.value.text;

    var twoDigitFirstNumbers =
        twoDigitNumber.value.text + threeDigitNumber.value.text;
    var twoDigitLastNumbers =
        fiveDigitNumber.value.text + sixDigitNumber.value.text;

    var oneDigitFirstNumbers = twoDigitNumber.value.text;
    var oneDigitLastNumbers = sixDigitNumber.value.text;

    var trailNo = allNumbers.length;
    var selectHeadAndTrail = headNo + trailNo;
    List<String> randomNumberList = [];
    for (int j = 0; j < int.parse(inputNumberTobuyController.value.text); j++) {
      var randomNumber = "";
      var randomAllNumber = "";
      var rnd = Random();
      if (allNumbers == "") {
        for (var i = 0; i < selectHeadAndTrail; i++) {
          randomNumber = randomNumber + rnd.nextInt(9).toString();
        }
        randomNumberList.add(randomNumber);
      } else {
        if (_selectedChoice != "" && allNumbers != "" && headNo == 6) {
          for (var i = 0; i < (headNo); i++) {
            randomNumber = randomNumber + rnd.nextInt(9).toString();
          }
          //1,2,3,4,5
          if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber.replaceRange(
                0,
                5,
                oneDigitNumber.value.text +
                    twoDigitNumber.value.text +
                    threeDigitNumber.value.text +
                    fourDigitNumber.value.text +
                    fiveDigitNumber.value.text);
          }
          //1,2,3,5,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0,
                    3,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,2,4,5,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,2,5,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,2,3,4
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "") {
            randomAllNumber = randomNumber.replaceRange(
                0,
                4,
                oneDigitNumber.value.text +
                    twoDigitNumber.value.text +
                    threeDigitNumber.value.text +
                    fourDigitNumber.value.text);
          }
          //1,2,3,5
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0,
                    3,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text);
          }
          //1,2,4,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,2,3,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0,
                    3,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,2,3
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "") {
            randomAllNumber = randomNumber.replaceRange(
                0,
                3,
                oneDigitNumber.value.text +
                    twoDigitNumber.value.text +
                    threeDigitNumber.value.text);
          }
          //1,2,4
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text);
          }
          //1,2,5
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text);
          }
          //1,2,6
          else if (oneDigitNumber.value.text != "" &&
              twoDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    0, 2, oneDigitNumber.value.text + twoDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,3,4,5,6
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,3,5,6
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,5,6
          else if (oneDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,3,4,5
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text);
          }
          //1,3,4,6
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }

          //1,3,6
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,3,5
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text);
          }
          //1,3,4
          else if (oneDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(2, 3, threeDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text);
          }
          //1,4,5,6
          else if (oneDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1,4,5
          else if (oneDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(4, 5, fiveDigitNumber.value.text);
          }

          //1,4,6
          else if (oneDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(0, 1, oneDigitNumber.value.text)
                .replaceRange(3, 4, fourDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //1
          else if (oneDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(0, 1, oneDigitNumber.value.text);
            if (twoDigitNumber.value.text != "") {
              randomAllNumber = randomNumber
                  .replaceRange(1, 2, twoDigitNumber.value.text)
                  .replaceRange(0, 1, oneDigitNumber.value.text);
            } else if (threeDigitNumber.value.text != "") {
              randomAllNumber = randomNumber
                  .replaceRange(2, 3, threeDigitNumber.value.text)
                  .replaceRange(0, 1, oneDigitNumber.value.text);
            } else if (fourDigitNumber.value.text != "") {
              randomAllNumber = randomNumber
                  .replaceRange(3, 4, fourDigitNumber.value.text)
                  .replaceRange(0, 1, oneDigitNumber.value.text);
            } else if (fiveDigitNumber.value.text != "") {
              randomAllNumber = randomNumber
                  .replaceRange(4, 5, fiveDigitNumber.value.text)
                  .replaceRange(0, 1, oneDigitNumber.value.text);
            } else if (sixDigitNumber.value.text != "") {
              randomAllNumber = randomNumber
                  .replaceRange(5, 6, sixDigitNumber.value.text)
                  .replaceRange(0, 1, oneDigitNumber.value.text);
            }
          }
          //2,3,4,5,6
          else if (twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber.replaceRange(1, 6, allNumbers);
          }
          //2,3,4,6
          else if (twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber = randomNumber
                .replaceRange(
                    1,
                    4,
                    twoDigitNumber.value.text +
                        threeDigitNumber.value.text +
                        fourDigitNumber.value.text)
                .replaceRange(5, 6, sixDigitNumber.value.text);
          }
          //2,3,4,5
          else if (twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(1, 5, fourDigitFirstNumbers);
          }
          //2,3,4
          else if (twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(1, 4, threeDigitFirstNumbers);
          }
          //2,3
          else if (twoDigitNumber.value.text != "" &&
              threeDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(1, 3, twoDigitFirstNumbers);
          } else if (twoDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(1, 2, oneDigitFirstNumbers);
            if (fourDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  3, 4, fourDigitNumber.value.text);
            }
            if (fiveDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  4, 5, fiveDigitNumber.value.text);
            }
            if (sixDigitNumber.value.text != "") {
              randomAllNumber =
                  randomAllNumber.replaceRange(5, 6, sixDigitNumber.value.text);
            }
          } else if (threeDigitNumber.value.text != "" &&
              fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(2, 6, fourDigitLastNumbers);
          } else if (fourDigitNumber.value.text != "" &&
              fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(3, 6, threeDigitLastNumbers);
          } else if (fiveDigitNumber.value.text != "" &&
              sixDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(4, 6, twoDigitLastNumbers);
          } else if (sixDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(5, 6, oneDigitLastNumbers);
            if (fourDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  3, 4, fourDigitNumber.value.text);
            }
            if (threeDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  2, 3, threeDigitNumber.value.text);
            }
          } else if (threeDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(2, 3, threeDigitNumber.value.text);
            if (fourDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  3, 4, fourDigitNumber.value.text);
            }
            if (fiveDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  4, 5, fiveDigitNumber.value.text);
            }
          } else if (fourDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(3, 4, fourDigitNumber.value.text);
            if (sixDigitNumber.value.text != "") {
              randomAllNumber =
                  randomAllNumber.replaceRange(5, 6, sixDigitNumber.value.text);
            }
            if (fiveDigitNumber.value.text != "") {
              randomAllNumber = randomAllNumber.replaceRange(
                  4, 5, fiveDigitNumber.value.text);
            }
          } else if (fiveDigitNumber.value.text != "") {
            randomAllNumber =
                randomNumber.replaceRange(4, 5, fiveDigitNumber.value.text);
          }
          randomNumberList.add(randomAllNumber);
        } else {
          if (trailNo > 0) {
            if (int.parse(_selectedChoice) == 5) {
              for (var i = 0; i < 5; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    0,
                    4,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text +
                        fourDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, oneDigitNumber.value.text)
                    .replaceRange(
                        2,
                        4,
                        threeDigitNumber.value.text +
                            fourDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(
                        0,
                        3,
                        oneDigitNumber.value.text +
                            twoDigitNumber.value.text +
                            threeDigitNumber.value.text)
                    .replaceRange(4, 5, fiveDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 2,
                        oneDigitNumber.value.text + twoDigitNumber.value.text)
                    .replaceRange(3, 4, fourDigitNumber.value.text)
                    .replaceRange(4, 5, fiveDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    0,
                    4,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text +
                        fourDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    0,
                    3,
                    oneDigitNumber.value.text +
                        twoDigitNumber.value.text +
                        threeDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, oneDigitNumber.value.text)
                    .replaceRange(2, 3, threeDigitNumber.value.text)
                    .replaceRange(4, 5, fiveDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, oneDigitNumber.value.text)
                    .replaceRange(1, 2, twoDigitNumber.value.text)
                    .replaceRange(4, 5, fiveDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, oneDigitNumber.value.text)
                    .replaceRange(1, 2, twoDigitNumber.value.text)
                    .replaceRange(3, 4, fourDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(0, 1, oneDigitNumber.value.text)
                    .replaceRange(3, 4, fourDigitNumber.value.text)
                    .replaceRange(4, 5, fiveDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, oneDigitNumber.value.text);
                if (twoDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, twoDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (threeDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, threeDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (fourDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, fourDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (fiveDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(4, 5, fiveDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                }
              } else if (twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    1,
                    5,
                    twoDigitNumber.value.text +
                        threeDigitNumber.value.text +
                        fourDigitNumber.value.text +
                        fiveDigitNumber.value.text);
              } else if (threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    2,
                    5,
                    threeDigitNumber.value.text +
                        fourDigitNumber.value.text +
                        fiveDigitNumber.value.text);
              } else if (fourDigitNumber.value.text != "" &&
                  fiveDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(3, 5,
                    fourDigitNumber.value.text + fiveDigitNumber.value.text);
              } else if (threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(2, 4,
                    threeDigitNumber.value.text + fourDigitNumber.value.text);
              } else if (twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    1,
                    4,
                    twoDigitNumber.value.text +
                        threeDigitNumber.value.text +
                        fourDigitNumber.value.text);
              } else if (twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(1, 3,
                    twoDigitNumber.value.text + threeDigitNumber.value.text);
              } else if (twoDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, twoDigitNumber.value.text);
                if (fourDigitNumber.value.text != "") {
                  randomAllNumber = randomAllNumber.replaceRange(
                      3, 4, fourDigitNumber.value.text);
                }
                if (fiveDigitNumber.value.text != "") {
                  randomAllNumber = randomAllNumber.replaceRange(
                      4, 5, fiveDigitNumber.value.text);
                }
              } else if (threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    2, 3, threeDigitNumber.value.text);
                if (fiveDigitNumber.value.text != "") {
                  randomAllNumber = randomAllNumber.replaceRange(
                      4, 5, fiveDigitNumber.value.text);
                }
              } else if (fourDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(3, 4, fourDigitNumber.value.text);
              } else if (fiveDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(4, 5, fiveDigitNumber.value.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(_selectedChoice) == 4) {
              for (var i = 0; i < 4; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(2, 3, threeDigitNumber.value.text)
                    .replaceRange(1, 2, twoDigitNumber.value.text)
                    .replaceRange(0, 1, oneDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  twoDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, fourDigitNumber.value.text)
                    .replaceRange(1, 2, twoDigitNumber.value.text)
                    .replaceRange(0, 1, oneDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, fourDigitNumber.value.text)
                    .replaceRange(2, 3, threeDigitNumber.value.text)
                    .replaceRange(0, 1, oneDigitNumber.value.text);
              } else if (twoDigitNumber.value.text != "" &&
                  threeDigitNumber.value.text != "" &&
                  fourDigitNumber.value.text != "") {
                randomAllNumber = randomNumber
                    .replaceRange(3, 4, fourDigitNumber.value.text)
                    .replaceRange(2, 3, threeDigitNumber.value.text)
                    .replaceRange(1, 2, twoDigitNumber.value.text);
              } else if (oneDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, oneDigitNumber.value.text);
                if (twoDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, twoDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (threeDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, threeDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (fourDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, fourDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                }
              } else if (twoDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, twoDigitNumber.value.text);
                if (threeDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, threeDigitNumber.value.text)
                      .replaceRange(1, 2, twoDigitNumber.value.text);
                } else if (fourDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, fourDigitNumber.value.text)
                      .replaceRange(1, 2, twoDigitNumber.value.text);
                }
              } else if (threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    2, 3, threeDigitNumber.value.text);
                if (fourDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(3, 4, fourDigitNumber.value.text)
                      .replaceRange(2, 3, threeDigitNumber.value.text);
                }
              } else if (fourDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(3, 4, fourDigitNumber.value.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(_selectedChoice) == 3) {
              for (var i = 0; i < 3; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }
              if (oneDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, oneDigitNumber.value.text);
                if (twoDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(1, 2, twoDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                } else if (threeDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, threeDigitNumber.value.text)
                      .replaceRange(0, 1, oneDigitNumber.value.text);
                }
              } else if (twoDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, twoDigitNumber.value.text);
                if (threeDigitNumber.value.text != "") {
                  randomAllNumber = randomNumber
                      .replaceRange(2, 3, threeDigitNumber.value.text)
                      .replaceRange(1, 2, twoDigitNumber.value.text);
                }
              } else if (threeDigitNumber.value.text != "") {
                randomAllNumber = randomNumber.replaceRange(
                    2, 3, threeDigitNumber.value.text);
              }
              randomNumberList.add(randomAllNumber);
            } else if (int.parse(_selectedChoice) == 2) {
              for (var i = 0; i < 2; i++) {
                randomNumber = randomNumber + rnd.nextInt(9).toString();
              }

              if (oneDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(0, 1, oneDigitNumber.value.text);
              } else if (twoDigitNumber.value.text != "") {
                randomAllNumber =
                    randomNumber.replaceRange(1, 2, twoDigitNumber.value.text);
              }
              // Get.back();
              randomNumberList.add(randomAllNumber);
            }
          }
        }
      }
    }
    numberCtrl.value.text = randomNumberList.join(',');
    update();
  }

  onDialogCancel() {
    sixDigitNumber.value.clear();
    fiveDigitNumber.value.clear();
    fourDigitNumber.value.clear();
    threeDigitNumber.value.clear();
    twoDigitNumber.value.clear();
  }

  ///Timer count down
  ///--------------------------------------------------------------------------------
  int _second = 0;

  int get closeSecond => _second;

  void setCloseSecond(int second) {
    _second = second;
    update();
  }

  Timer? _timer;
  Duration? _timeUntilDue;
  int _daysUntil = 0;
  int _hoursUntil = 0;
  int _minUntil = 0;

  int _secUntil = 0;
  int _milliSec = 0;
  String? _s;

  Timer get timer => _timer!;

  Duration get timeUntilDue => _timeUntilDue!;

  int get daysUntil => _daysUntil;

  int get hoursUntil => _hoursUntil;

  int get minUntil => _minUntil;

  int get secUntil => _secUntil;

  int get milliSec => _milliSec;

  String get s => _s!;

  Future<void> getTimeCountDown(DateTime due) async {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      DateTime startDate = await NTP.now();
      _timeUntilDue = due.difference(startDate);
      _daysUntil = _timeUntilDue!.inDays;
      _hoursUntil = _timeUntilDue!.inHours - (_daysUntil * 24);
      _minUntil = _timeUntilDue!.inMinutes -
          (_daysUntil * 24 * 60) -
          (_hoursUntil * 60);
      _secUntil = _timeUntilDue!.inSeconds - (_minUntil * 60);
      _milliSec = _timeUntilDue!.inMilliseconds;
      _s = _secUntil.toString().length <= 2
          ? _secUntil.toString()
          : _secUntil.toString().substring(_secUntil.toString().length - 2);
      if (_milliSec < 1) {
        timer.cancel();
      }
      setCloseSecond(_milliSec);
      // setCloseSecond(360);
    });
  }

  ///Buying Lottery
  ///-----------------------------------------------------------------------------------

  bool _buyLoading = false;
  bool get buyLoading => _buyLoading;

  Future<LottoBuyResponse?> buyingLotto(LottoBuyNumber lottoBuyNumber) async {
    _buyLoading = true;
    LottoBuyResponse? lottoBuyResponse;
    Response _response = await lotteryRepo.buyLottery(lottoBuyNumber);
    if (kDebugMode) {
      Logger().i("buy response:: ${_response.body}");
    }
    update();
    if (_response.statusCode == 200) {
      lottoBuyResponse = LottoBuyResponse.fromJson(_response.body);
    } else if (_response.statusCode == 400) {
      _buyLoading = false;
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          _response.body['msg'],
          Icons.error_outline,
          Colors.red,
        ),
      );
      // showDialog(barrierDismissible: false, context: Get.context!, builder: (context) => LottoCustomAlert(message: _response.body['msg'].toString(), isError: true));
    } else if (_response.statusCode == 401) {
      _buyLoading = false;
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          "Unauthorized",
          Icons.error_outline,
          Colors.red,
        ),
      );
      // showDialog(barrierDismissible: false, context: Get.context!, builder: (context) => LottoCustomAlert(message: "Unauthorized", isError: true));
    } else if (_response.statusCode == 504) {
      _buyLoading = false;
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          "504 Gateway Time-out",
          Icons.error_outline,
          Colors.red,
        ),
      );
      // showDialog(barrierDismissible: false, context: Get.context!, builder: (context) => LottoCustomAlert(message: _response.body['msg'], isError: true));
    } else if (_response.statusCode == 404) {
      _buyLoading = false;
      if (_response.body['status'] == 025) {
        showDialog(
          context: Get.context!,
          builder: (context) => MessageAlertMsg(
            'error',
            "ບໍ່ສາມາດຂາຍເລກ ລໍຖ້າເປີດການຂາຍ",
            Icons.error_outline,
            Colors.red,
          ),
        );
      } else {
        showDialog(
          context: Get.context!,
          builder: (context) => MessageAlertMsg(
            'error',
            _response.body['msg'],
            Icons.error_outline,
            Colors.red,
          ),
        );
      }
    }
    _buyLoading = false;
    update();
    return lottoBuyResponse;
  }

  void pointPayment(String custPhone, String ticketId) async {
    _buyLoading = true;
    Response _response = await lotteryRepo.pointPayment(custPhone, ticketId);
    if (kDebugMode) {
      Logger().i(
        'Point payment ticketId: $ticketId\n'
        'status: ${_response.statusCode}\n'
        'body: ${_response.body}',
      );
    }
    if (_response.statusCode == 200) {
      _buyLoading = false;
      Future.delayed(Duration(seconds: 1), () async {
        await getInvoiceDetail(custPhone, ticketId);
        getPoints(custPhone);
        clearAllNumberList();
      });
      update();
    } else if (_response.statusCode == 400) {
      _buyLoading = false;
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: _response.body['msg'].toString(),
          isError: true,
        ),
      );
    }
    _buyLoading = false;
    update();
  }

  void setBuyLoading() {
    _buyLoading = true;
    update();
  }

  ///Check reward id exist or not and save it
  LottoRewardIdResponse? _lottoRewardIdResponse;

  LottoRewardIdResponse? get lottoRewardIdResponse => _lottoRewardIdResponse;

  Future<LottoRewardIdResponse?> checkResponse(String phone) async {
    Response response = await lotteryRepo.checkRewardId(phone);
    if (kDebugMode) {
      Logger().i("expired date:1: ${response.body}");
    }
    if (response.statusCode == 200) {
      if (kDebugMode) {
        Logger().w("expired date:: ${json.encode(response.body)}");
      }
      _lottoRewardIdResponse = LottoRewardIdResponse.fromJson(response.body);
      if (_lottoRewardIdResponse!.rewardId != null ||
          _lottoRewardIdResponse!.rewardId != "") {
        referralCode.value.text = _lottoRewardIdResponse!.rewardId!;
      }
    } else {
      _lottoRewardIdResponse =
          LottoRewardIdResponse(custId: 0, rewardId: null, expAt: null);
      referralCode.value.text = "";
    }

    update();
    return _lottoRewardIdResponse;
  }

  bool _isSaveComplete = false;

  bool get isSaveSuccess => _isSaveComplete;

  Future<bool> saveRewardId(String phone, String referralId) async {
    Response response = await lotteryRepo.saveRewardId(phone, referralId);
    if (kDebugMode) {
      Logger().i(
        'save referral code ${response.statusCode}\n'
        'completed ${json.encode(response.body)}',
      );
    }

    if (response.statusCode == 200) {
      _isSaveComplete = true;
      checkResponse(phone);
    } else {
      _isSaveComplete = false;
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          response.body['msg'],
          Icons.error_outline,
          Colors.red,
        ),
      );
    }
    update();
    return _isSaveComplete;
  }

  ///Check Lot open or close
  bool _checkLot = true; // default: false

  bool get checkLot => _checkLot;

  setCheckLot(bool isClose) {
    _checkLot = isClose;
    update();
  }

  //22541426

  Future<void> checkLotOpenClose() async {
    Response response = await lotteryRepo.checkLotOpenClose();
    if (kDebugMode) {
      Logger().i(
        'check status: ${response.statusCode}\n'
        'close: ${response.body}',
      );
    }
    if (response.statusCode == 200) {
      setCheckLot(true);
    } else if (response.statusCode == 404) {
      setCheckLot(false);
      // setCheckLot(true);
      clearAllNumberList();
    }
    update();
  }

  ///Lottery History
  ///-----------------------------------------------------------------------------------
  List<LotteryHistoryModel> _lotteryHistoryModel = [];
  List<Draw> _drawModel = [];

  List<LotteryHistoryModel> get lotteryHistoryModel => _lotteryHistoryModel;

  List<Draw> get drawModel => _drawModel;

  bool _paginate = false;
  int _pageSize = 0;
  int _offset = 1;

  bool get paginate => _paginate;

  int get pageSize => _pageSize;

  int get offset => _offset;
  bool _historyLoading = false;

  bool get historyLoading => _historyLoading;

  void getLotteryHistory(int offset, reload) async {
    if (reload) {
      offset = 0;
      _drawModel = [];
      _historyLoading = true;
      update();
    }
    Response _response = await lotteryRepo.lotteryHistory(offset);
    if (_response.statusCode == 200) {
      _drawModel.addAll(LotteryHistoryModel.fromJson(_response.body).draws!);
      _pageSize = _response.body['totalSize'];
    }
    _historyLoading = false;
    update();
  }

  void showBottomLoader() {
    _paginate = true;
    update();
  }

  void setOffset(int offset) {
    _offset = offset;
  }

  ///Lottery Dashboard
  ///--------------------------------------------------------------------------------
  List<Draw> _dashboard = [];

  List<Draw> get dashboard => _dashboard;
  bool _dashboardLoading = false;

  bool get dashboardLoading => _dashboardLoading;

  void setDashboardLoading(bool load) {
    _dashboardLoading = load;
    update();
  }

  bool _isNotFound = false;

  bool get isNotFound => _isNotFound;
  String _errorMessage = "";

  String get errorMessage => _errorMessage;

  void setNotFound(bool notFound, String message) {
    _isNotFound = notFound;
    _errorMessage = message;
    update();
  }

  Future<void> getDashboard() async {
    setDashboardLoading(true);
    Response _response = await lotteryRepo.lotteryDashboard();
    if (kDebugMode) {
      Logger().i('getDashboard: ${_response.body}');
    }

    // bypass begin
    // String date = '27/03/2024 16:32';
    // DateFormat format = DateFormat("dd/MM/yyyy hh:mm");
    // getTimeCountDown(format.parse(date));
    // bypass end

    if (_response.statusCode == 200) {
      setNotFound(false, "Success");
      _dashboard = [];
      var response = LotteryHistoryModel.fromJson(_response.body);
      setDashboardLoading(false);
      _dashboard.addAll(LotteryHistoryModel.fromJson(_response.body).draws!);
      if (_dashboard.isNotEmpty && response.drawtime != "" ||
          response.drawtime != null ||
          response.drawtime!.isNotEmpty) {
        String date = response.drawtime.toString();

        Logger().w('DrawTime: ${response.drawtime}');

        DateFormat format = DateFormat("dd/MM/yyyy hh:mm");
        getTimeCountDown(format.parse(date));
        if (_dashboard.isNotEmpty && _dashboard[0].winNumber != "") {
          clearAllNumberList();
        }
      }
    } else {
      setNotFound(true, _response.body['msg'].toString());
      setDashboardLoading(false);
    }
    update();
  }

  ///Get lottery result and Lot Opening or close
  BonusReferralModel? _bprModel;

  BonusReferralModel? get bprModel => _bprModel;

  void getBonusPointReferral(String phoneNo) async {
    Response _response = await lotteryRepo.bonusPointReferral(phoneNo);
    if (_response.statusCode == 200) {
      _bprModel = BonusReferralModel.fromJson(_response.body);
    }
    update();
  }

  ///Get Point from navigator to point screen
  ///--------------------------------------------------------------------------------
  PointsModel? _pointModel;

  PointsModel? get pointModel => _pointModel;

  List<Statement> _pointStatement = [];

  List<Statement> get pointStatement => _pointStatement;
  bool _pointLoading = false;

  bool get pointLoading => _pointLoading;

  Future<void> getPoints(String phoneNo) async {
    _pointLoading = true;
    Response _response = await lotteryRepo.points(phoneNo);
    update();
    if (kDebugMode) {
      Logger().i(_response.body);
    }
    if (_response.statusCode == 200) {
      _pointStatement = [];
      _pointModel = PointsModel.fromJson(_response.body);
      _pointStatement.addAll(PointsModel.fromJson(_response.body).statements!);
    }
    _pointLoading = false;
    update();
  }

  ///Get Reward from navigator to reward screen
  ///--------------------------------------------------------------------------------

  bool _rewardPaginate = false;
  int _rewardPageSize = 0;
  int _rewardOffset = 1;

  bool get rewardPaginate => _rewardPaginate;

  int get rewardPageSize => _rewardPageSize;

  int get rewardOffset => _rewardOffset;
  List<DrawModel> _bonusDraw = [];
  BonusModel? _bonuses;

  BonusModel? get bonuses => _bonuses;

  List<DrawModel> get bonusDraw => _bonusDraw;

  Future<void> getBonus(bool reload, int offset, String phoneNo) async {
    if (reload) {
      _rewardOffset = offset;
      _bonusDraw = [];
      //update();
    }
    Response _response = await lotteryRepo.bonus(_rewardOffset, phoneNo);

    if (kDebugMode) {
      Logger().i(_response.body);
    }

    _bonuses = null;
    if (_response.statusCode == 200) {
      _bonuses = BonusModel.fromJson(_response.body);
      _rewardPageSize = BonusModel.fromJson(_response.body).limit!;
      _bonusDraw.addAll(BonusModel.fromJson(_response.body).draws!);
    } else {
      ApiChecker.checkApi(_response, _response.statusText.toString());
    }
    update();
  }

  void showRewardBottomLoader() {
    _rewardPaginate = true;
    update();
  }

  void setRewardOffset(int offset) {
    _rewardOffset = offset;
  }

  ///Bonus details
  ///--------------------------------------------------------------------------------
  BonusDetailModel _bonusDetail = BonusDetailModel();

  BonusDetailModel get bonusDetail => _bonusDetail;
  List<ItemModel> _items = [];

  List<ItemModel> get items => _items;
  bool _bonusDetailLoading = false;

  bool get bonusDetailLoading => _bonusDetailLoading;

  void getBonusDetail(int drawId, String phoneNo) async {
    _bonusDetailLoading = true;
    Response _response = await lotteryRepo.bonusDetail(drawId, phoneNo);
    if (kDebugMode) {
      Logger().i(
        'getBonusDetail: drawId: $drawId\n${_response.body}',
      );
    }
    if (_response.statusCode == 200) {
      _items = [];
      _bonusDetail = BonusDetailModel();
      _bonusDetail = BonusDetailModel.fromJson(_response.body);
      _items.addAll(BonusDetailModel.fromJson(_response.body).items!);
    }
    _bonusDetailLoading = false;
    update();
  }

  ///Invoice
  ///--------------------------------------------------------------------------------
  List<Invoicese> _invoiceModel = [];

  List<Invoicese> get invoiceModel => _invoiceModel;

  // bool _invoicePaginate = false;
  bool _invoiceLoading = false;
  int _invoicePageSize = 0;
  int _invoiceOffset = 0;

  // bool get invoicePaginate => _invoicePaginate;

  bool get invoiceLoading => _invoiceLoading;

  int get invoicePageSize => _invoicePageSize;

  int get invoiceOffset => _invoiceOffset;

  void setInvoiceLoading(bool load) {
    _invoiceLoading = load;
    // _invoicePaginate = load;
    update();
  }

  Future<void> getInvoice(bool reload, int offset, String phone) async {
    if (reload) {
      offset = 0;
      _invoiceModel = [];
      _invoiceLoading = true;
    }

    Response _response = await lotteryRepo.lotteryInvoice(offset, phone);
    if (_response.statusCode == 200) {
      _invoicePageSize = LottoInvoice.fromJson(_response.body).totalSize!;
      _invoiceOffset = LottoInvoice.fromJson(_response.body).offset!;
      _invoiceModel.addAll(LottoInvoice.fromJson(_response.body).invoicese!);
    }
    _invoiceLoading = false;
    update();
  }

  Future<void> getInvoiceDetail(String customPhone, String ticketId) async {
    Response _response = await lotteryRepo.lotteryInvoiceDetail(
      customPhone,
      ticketId,
    );

    if (kDebugMode) {
      Logger().i(_response.body);
    }

    if (_response.statusCode == 200) {
      // Invoicese invoice = Invoicese.fromJson(_response.body);
      LotteryInvoiceHistoryItem invoice =
          LotteryInvoiceHistoryItem.fromJson(_response.body);
      Get.to(() => LotteryHistoryDetail(invoice: invoice, fromPayment: true));
    } else if (_response.statusCode == 404) {
      Response response =
          await lotteryRepo.lotteryInvoiceDetail(customPhone, ticketId);
      if (response.statusCode == 200) {
        // Invoicese invoice = Invoicese.fromJson(response.body);
        LotteryInvoiceHistoryItem invoice =
            LotteryInvoiceHistoryItem.fromJson(response.body);
        Get.to(() => LotteryHistoryDetail(invoice: invoice, fromPayment: true));
      }
    } else {
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          _response.statusText.toString(),
          Icons.error_outline,
          Colors.red,
        ),
      );
    }
    update();
  }

  void setInvoiceOffset(int offset) {
    _invoiceOffset = offset;
  }

  ///Edit amount and lucky number
  void editAmountInCart(int index) {
    if (double.parse(editAmountCtrl.value.text) < 1000) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "amount_should_than_1000",
          isOkText: true,
        ),
      );
    } else if (double.parse(editAmountCtrl.value.text) % 1000 != 0) {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "invalid_amount",
          isOkText: true,
        ),
      );
    } else {
      _totalAmount = 0;
      _numberModel[index].amount =
          int.parse(editAmountCtrl.value.text.toString().trim());
      lotteryRepo.addToNumberList(_numberModel);
      _numberModel.forEach((element) {
        _totalAmount += element.amount!;
      });
      editAmountCtrl.value.clear();
      Get.back();
    }
    update();
  }

  void editNumberInCart(int index) {
    if (editNumberCtrl.value.text.isNotEmpty ||
        editNumberCtrl.value.text.isNotEmpty) {
      String str = editNumberCtrl.value.text;

      if (str.length > 6) {
        Get.back();
        showDialog(
          barrierDismissible: true,
          context: Get.context!,
          builder: (context) => LottoCustomAlert(
            message: "you_can_buy_123456",
            isOkText: true,
          ),
        );
      } else if (str.contains(".") || str.contains(",")) {
        Get.back();
        showDialog(
          barrierDismissible: false,
          context: Get.context!,
          builder: (context) => LottoCustomAlert(
            message: "invalid_number",
            isOkText: true,
          ),
        );
      } else {
        _numberModel[index].number =
            editNumberCtrl.value.text.toString().trim();
        lotteryRepo.addToNumberList(_numberModel);
        editNumberCtrl.value.clear();
        Get.back();
      }
    }
    update();
  }

  ///Payment options
  ///--------------------------------------------------------------------------------
  LottoPaymentOptions _walletPoint =
      LottoPaymentOptions(bankImg: LottoImages.wallet, bankName: "points");

  LottoPaymentOptions get walletPoint => _walletPoint;

  List<LottoBankPaymentOptions> _paymentOption = [];

  List<LottoBankPaymentOptions> get paymentOption => _paymentOption;
  bool _paymentOptionsLoading = false;

  bool get paymentOptionsLoading => _paymentOptionsLoading;

  Future<void> getBankPaymentOptions() async {
    _paymentOptionsLoading = true;
    Response response = await lotteryRepo.getBankPaymentOptions(1);
    if (kDebugMode) {
      Logger().i(
        'payment status: ${response.statusText}\n'
        'option: ${response.body}',
      );
    }

    update();
    if (response.statusCode == 200) {
      _paymentOption = [];
      _paymentOption.addAll(
          lottoBankPaymentOptionsFromJson(response.bodyString.toString()));
      _paymentOptionsLoading = false;
    } else {
      _paymentOptionsLoading = false;
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert(
          message: "unable_to_load_payment_option_due_to_api_issue".tr,
          isError: true,
        ),
      );
    }
    update();
  }

  ///LaoViet Bank Payment
  ///--------------------------------------------------------------------------------
  String _onePayMCID = "";

  String get onePayMCID => _onePayMCID;

  void setOnePayMCID(String mcid) {
    _onePayMCID = mcid;
    update();
  }

  Future<void> bankPayment(LottoLaoVietPaymentBody request) async {
    _buyLoading = true;
    update();
    Response response = await lotteryRepo.bankPayment(request);
    if (kDebugMode) {
      Logger().w("payment request:: ${request.toJson()}");
      Logger().e('get-payment-code: ${response.body}');
    }

    if (response.statusCode == 200) {
      if (request.bankId == 3) {
        ///BCEL Payment
        if (kDebugMode) {
          Logger().i('BCEL: $request');
          Logger().i('BCEL: ${response.body}');
        }
        String qrCode = response.body['paymentCode'];
        String uuidKey = response.body['paymentTransactionId'];
        String mcid = onePayMCID;
        var channel = '';
        var pubnub = PubNub(
          defaultKeyset: Keyset(
            subscribeKey: AppConstants.BCEL_SUBSCRIBE_KEY,
            userId: UserId(AppConstants.BCEL_USER_KEY),
          ),
          networking: NetworkingModule(ssl: true),
        );
        channel = 'uuid-$mcid-$uuidKey';
        var subscription = pubnub.subscribe(channels: {channel});
        subscription.messages.listen((envelope) async {
          switch (envelope.messageType) {
            case MessageType.normal:
              // final Map parsed = json.decode(envelope.payload);
              if (kDebugMode) {
                Logger().i("callback:: ${envelope.payload}");
              }

              update();
              Future.delayed(Duration(seconds: 2), () async {
                await getInvoiceDetail(
                  request.custPhone.toString(),
                  request.transactionNo.toString(),
                );
                clearAllNumberList();
              });
              break;
            default:
              if (kDebugMode) {
                Logger().d(
                    'default ${envelope.publishedAt} sent a message: ${envelope.content}');
              }
          }
        });
        if (await canLaunchUrl(Uri.parse("onepay://qr/$qrCode"))) {
          await launchUrl(Uri.parse("onepay://qr/$qrCode"));
        } else {
          showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              'can_not_launch_bank_payment'.tr,
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      } else if (request.bankId == 4) {
        ///Lao viet Bank payment
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        // final Uri url = Uri( host: response.body['paymentCode']);
        if (kDebugMode) {
          Logger().i('LVB: $request');
          Logger().i('LVB: ${response.body}');
        }
        if (response.body['paymentCode'] != null) {
          // await launchUrl(
          //   Uri.parse(response.body['paymentCode']),
          //   mode: LaunchMode.externalApplication,
          // );
          // if (await canLaunchUrl(Uri.parse(response.body['paymentCode']))) {
          await launchUrl(
            Uri.parse(response.body['paymentCode']),
            mode: LaunchMode.externalApplication,
          );
          // } else {
          //   _buyLoading = false;
          //   showDialog(
          //     barrierDismissible: false,
          //     context: Get.context!,
          //     builder: (context) => MessageAlertMsg(
          //       'error',
          //       'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ LVB\nກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.',
          //       Icons.error_outline,
          //       Colors.red,
          //     ),
          //   );
          // }
        } else {
          _buyLoading = false;
          showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              'can_not_launch_bank_payment'.tr,
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      } else if (request.bankId == 21) {
        /// LDB
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        if (kDebugMode) {
          Logger().i('LDB: ${request.toJson()}');
          Logger().i('LDB: ${response.body}');
        }
        if (response.body['paymentCode'] != null) {
          // if (await canLaunchUrl(Uri.parse(response.body['paymentCode']))) {
          await launchUrl(
            Uri.parse(response.body['paymentCode']),
            mode: LaunchMode.externalApplication,
          );
          // } else {
          //   _buyLoading = false;
          //   showDialog(
          //     barrierDismissible: false,
          //     context: Get.context!,
          //     builder: (context) => MessageAlertMsg(
          //       'error',
          //       'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ LDB Trust\nກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.',
          //       Icons.error_outline,
          //       Colors.red,
          //     ),
          //   );
          // }
        } else {
          _buyLoading = false;
          showDialog(
            barrierDismissible: false,
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              "can_not_launch_bank_payment".tr,
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
      } else if (request.bankId == 2) {
        /// APB
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        if (kDebugMode) {
          Logger().i('APB: $request');
          Logger().i('APB: ${response.body}');
        }

        if (response.body['paymentCode'] != null) {
          try {
            // await launchUrl(
            //   Uri.parse(
            //       "apb://mobile.apb.com.la/qr_payment?qr=${response.body['paymentCode']}"),
            //   mode: LaunchMode.externalApplication,
            // );
            if (await canLaunchUrl(Uri.parse(
                "apb://mobile.apb.com.la/qr_payment?qr=${response.body['paymentCode']}"))) {
              await launchUrl(
                Uri.parse(
                    "apb://mobile.apb.com.la/qr_payment?qr=${response.body['paymentCode']}"),
                mode: LaunchMode.externalApplication,
              );
            } else {
              _buyLoading = false;
              showDialog(
                barrierDismissible: false,
                context: Get.context!,
                builder: (context) => MessageAlertMsg(
                  'error',
                  'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ APB\nກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.',
                  Icons.error_outline,
                  Colors.red,
                ),
              );
            }
          } catch (e) {
            showDialog(
              context: Get.context!,
              builder: (context) => MessageAlertMsg(
                'error',
                "can_not_launch_bank_payment".tr,
                Icons.error_outline,
                Colors.red,
              ),
            );
          }
        } else {
          showDialog(
            context: Get.context!,
            builder: (context) => MessageAlertMsg(
              'error',
              "can_not_launch_bank_payment".tr,
              Icons.error_outline,
              Colors.red,
            ),
          );
        }
        update();
        _buyLoading = false;
      } else if (request.bankId == 1) {
        /// M-Money
        MMoneyCashOutBody cashOutBody = new MMoneyCashOutBody();
        cashOutBody.transCashOutId = response.body['transCashOutID'];
        cashOutBody.transId = response.body['paymentTransactionId'];
        cashOutBody.otpRefNo = response.body['otpRefNo'];
        cashOutBody.otpRefCode = response.body['otpRefCode'];
        cashOutBody.topUpTransactionId = request.transactionNo;
        showGeneralDialog(
          context: Get.context!,
          pageBuilder: (context, animation, secondaryAnimation) =>
              MMoneyConfirmDialog(request: cashOutBody),
        );
      }
      _buyLoading = false;
    } else {
      _buyLoading = false;
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          response.statusText.toString(),
          Icons.error_outline,
          Colors.red,
        ),
      );
    }
    _buyLoading = false;
    update();
  }

  void pubnubSubscript(String transactionId, String customerPhone) {
    var pubnub = PubNub(
      defaultKeyset: Keyset(
        publishKey: AppConstants.PUBNUB_PUBLIC_KEY,
        subscribeKey: AppConstants.PUBNUB_SUBSCRIBE_KEY,
        userId: UserId(AppConstants.PUBNUB_USER_ID),
      ),
      networking: NetworkingModule(ssl: true),
    );
    var subscription =
        pubnub.subscribe(channels: {'bank_callback_$transactionId'});
    subscription.messages.listen((envelope) async {
      if (kDebugMode) {
        Logger().w(envelope.payload);
      }
      switch (envelope.messageType) {
        case MessageType.normal:
          // final Map parsed = json.decode(envelope.payload);
          // if (kDebugMode) {
          //   Logger().i("callback:: $parsed");
          // }
          update();
          Future.delayed(Duration(seconds: 2), () async {
            await getInvoiceDetail(
              customerPhone,
              transactionId,
            );
            clearAllNumberList();
          });
          break;
        default:
          if (kDebugMode) {
            Logger().w(
              'default ${envelope.publishedAt} sent a message: ${envelope.content}',
            );
          }
      }
    });
  }

  ///Bonus screen
  ///--------------------------------------------------------------------------------
  bool _lotto = false;

  bool get lotto => _lotto;

  get lottoViewVisible => _lotto ? true : false;

  void setLottoIndex(bool onClick) {
    _lotto = onClick;
    update();
  }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  bool _cashOutLoading = false;

  bool get cashOutLoading => _cashOutLoading;

  void setCashOutLoading(bool cashOut) {
    _cashOutLoading = cashOut;
    update();
  }

  Future<bool> mMoneyCashOut(MMoneyCashOutBody request) async {
    setCashOutLoading(true);
    bool paymentCompleted = false;
    Response response = await lotteryRepo.mMoneyCashOut(request);
    if (response.statusCode == 200) {
      paymentCompleted = true;
      setCashOutLoading(false);
    } else {
      setCashOutLoading(false);
      paymentCompleted = false;
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          response.statusText.toString(),
          Icons.error_outline,
          Colors.red,
        ),
      );
    }
    return paymentCompleted;
  }

  // <p style="font-family: Roboto;">ແນະນຳໝູ່ລົງທະບຽນ ແລະ ໃຊ້ບໍລິການຕ່າງໆເພຶ່ອຮັບໂບນັດສູງເຖິງ 15% ຂອງຍອດຊື້ທັງໝົດ.</p>
  ///Bonus detail to get reward
  String bonusCondition = """
                        <p style="font-family: Roboto;">ໃນໜ້າຊຳລະເງິນ ຈະມີຫ້ອງໃຫ້ປ້ອນເລກຜູ້ແນະນຳ.
                            ໃຫ້ທ່ານແນະນຳໝູ່ຂອງທ່ານປ້ອນເລກທ່ານໃສ່ ທ່ານຈະໄດ້ຮັບໂບນັດສູງເຖິງ 15%
                            ຂອງຍອດຊື້ທັງໝົດ</p>
                        <ul style="font-family: Roboto;">
                            <li>ເງິນແນະນຳທີ່ທ່ານຈະໄດ້ຮັບຂັ້ນຕ່ຳ 1000 ກີບ/ງວດ. ຖ້າເງິນແນະນຳບໍ່ຮອດ 1000
                                ກີບ/ງວດ ແມ່ນຈະບໍ່ຖືກແຈກຈ່າຍ ແລະ ບໍ່ຖືກຍົກຍອດ (ໂມຄະ)</li>
                            <li>ເງິນແນະນຳຈະໂອນໃຫ້ທ່ານ ທຸກໆຕົ້ນເດືອນ.</li>
                            <li>ບໍລິສັດຂໍສະຫງວນສິດໃນການປ່ຽນແປງເງື່ອນໄຂ ໂດຍບໍ່ແຈ້ງໃຫ້ຊາບລ່ວງໜ້າ.</li>
                        </ul>
                        """;

  int _tabIndex = 0;

  get tabIndex => _tabIndex;

  void setTabIndex(int i) {
    _tabIndex = i;
    update();
  }
}
