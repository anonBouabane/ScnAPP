import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../base/message_alert_message.dart';

class LottoRandomNumber extends StatelessWidget {
  const LottoRandomNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: GetBuilder<LotteryController>(builder: (lotCtrl) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(32.0), topRight: Radius.circular(32.0)),
                    ),
                    child: Text('random_number'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeHugeLarge1, color: Colors.white), textAlign: TextAlign.center),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('choose_prefix'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (int i = 0; i < lotCtrl.lotteryHeader; i++)
                          GestureDetector(
                            onTap: () {
                              lotCtrl.setSelectedChoice((i + lotCtrl.lotteryMinNumber).toString());
                            },
                            child: Container(
                                margin: EdgeInsets.all(2),
                                padding: EdgeInsets.only(top: 4),
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: lotCtrl.selectedChoice == (i + lotCtrl.lotteryMinNumber).toString() ? Colors.redAccent.shade700 : Colors.white,
                                    border: Border.all(color: Colors.redAccent.shade700),
                                    borderRadius: BorderRadius.all(Radius.circular(8))),
                                child: Center(
                                  child: Text(
                                    '${(i + lotCtrl.lotteryMinNumber)}',
                                    style: robotoBold.copyWith(
                                        color: lotCtrl.selectedChoice == (i + lotCtrl.lotteryMinNumber).toString() ? Colors.white : Colors.black, fontSize: Dimensions.fontSizeExtraLarge1),
                                  ),
                                )),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('set_number'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (lotCtrl.selectedChoice == "6") ...[
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.oneDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.oneDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.oneDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.twoDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.twoDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.oneDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextField(
                              controller: lotCtrl.threeDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.threeDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                } else if (value.length == 0) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextField(
                              controller: lotCtrl.fourDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.fourDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fiveDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextField(
                              controller: lotCtrl.fiveDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.fiveDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.fiveDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.sixDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.fiveDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextField(
                              controller: lotCtrl.sixDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.sixDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length == 0) {
                                  lotCtrl.sixDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fiveDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.sixDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fiveDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(border: OutlineInputBorder(), hintText: '?', counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                        ] else if (lotCtrl.selectedChoice == "5") ...[
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.oneDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.oneDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.oneDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.twoDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              focusNode: lotCtrl.twoDigitNumberFocus.value,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.oneDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.threeDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              focusNode: lotCtrl.threeDigitNumberFocus.value,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.fourDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.fourDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fiveDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.fiveDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.fiveDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length == 0) {
                                  lotCtrl.fiveDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.fiveDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                        ] else if (lotCtrl.selectedChoice == "4") ...[
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.oneDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.oneDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.oneDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.twoDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.twoDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.oneDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.threeDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.threeDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.fourDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.fourDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.fourDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length == 0) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.fourDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                        ] else if (lotCtrl.selectedChoice == "3") ...[
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.oneDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.oneDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.oneDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.twoDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.twoDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.twoDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.threeDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.threeDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.threeDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length == 0) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                } else if (value.length == 0 && value.isEmpty) {
                                  lotCtrl.threeDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                        ] else if (lotCtrl.selectedChoice == "2") ...[
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.oneDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.oneDigitNumberFocus.value,
                              maxLength: 1,
                              onChanged: (value) {
                                if (value.length > 0) {
                                  lotCtrl.oneDigitNumberFocus.value.unfocus();
                                  FocusScope.of(context).requestFocus(lotCtrl.twoDigitNumberFocus.value);
                                }
                              },
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2),
                            child: TextFormField(
                              controller: lotCtrl.twoDigitNumber.value,
                              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1),
                              textAlign: TextAlign.center,
                              focusNode: lotCtrl.twoDigitNumberFocus.value,
                              maxLength: 1,
                              keyboardType: TextInputType.number,
                              decoration:
                                  const InputDecoration(border: OutlineInputBorder(), hintText: '?', isDense: true, counterText: "", contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                  Container(
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
                                  'total_number'.tr,
                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                ),
                                Container(
                                  height: 60,
                                  padding: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.inputBg), fit: BoxFit.fill)),
                                  child: TextFormField(
                                    controller: lotCtrl.inputNumberTobuyController.value,
                                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(border: InputBorder.none, isDense: true),
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
                                  'amount'.tr,
                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                                ),
                                Container(
                                  height: 60,
                                  padding: EdgeInsets.only(top: 2),
                                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage(Images.inputBg), fit: BoxFit.fill)),
                                  child: TextFormField(
                                    controller: lotCtrl.inputAmountTobuyController.value,
                                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge),
                                    textAlign: TextAlign.center,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(border: InputBorder.none, isDense: true, contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 2)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10, right: 20, left: 20),
                    margin: EdgeInsets.all(6),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                              lotCtrl.onDialogCancel();
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
                                  'cancel'.tr,
                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1, color: Colors.white),
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
                              if (lotCtrl.selectedChoice == "6") {
                                if (lotCtrl.oneDigitNumber.value.text != "" &&
                                    lotCtrl.twoDigitNumber.value.text != "" &&
                                    lotCtrl.threeDigitNumber.value.text != "" &&
                                    lotCtrl.fourDigitNumber.value.text != "" &&
                                    lotCtrl.fiveDigitNumber.value.text != "" &&
                                    lotCtrl.sixDigitNumber.value.text != "") {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => MessageAlertMsg('error', "ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${lotCtrl.selectedChoice} ຫຼັກ", Icons.error_outline, Colors.red));
                                } else {
                                  lotCtrl.onRandom();
                                }
                              } else if (lotCtrl.selectedChoice == "5") {
                                if (lotCtrl.oneDigitNumber.value.text != "" &&
                                    lotCtrl.twoDigitNumber.value.text != "" &&
                                    lotCtrl.threeDigitNumber.value.text != "" &&
                                    lotCtrl.fourDigitNumber.value.text != "" &&
                                    lotCtrl.fiveDigitNumber.value.text != "") {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => MessageAlertMsg('error', "ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${lotCtrl.selectedChoice} ຫຼັກ", Icons.error_outline, Colors.red));
                                } else {
                                  lotCtrl.onRandom();
                                }
                              } else if (lotCtrl.selectedChoice == "4") {
                                if (lotCtrl.oneDigitNumber.value.text != "" &&
                                    lotCtrl.twoDigitNumber.value.text != "" &&
                                    lotCtrl.threeDigitNumber.value.text != "" &&
                                    lotCtrl.fourDigitNumber.value.text != "") {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => MessageAlertMsg('error', "ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${lotCtrl.selectedChoice} ຫຼັກ", Icons.error_outline, Colors.red));
                                } else {
                                  lotCtrl.onRandom();
                                }
                              } else if (lotCtrl.selectedChoice == "3") {
                                if (lotCtrl.oneDigitNumber.value.text != "" && lotCtrl.twoDigitNumber.value.text != "" && lotCtrl.threeDigitNumber.value.text != "") {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => MessageAlertMsg('error', "ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${lotCtrl.selectedChoice} ຫຼັກ", Icons.error_outline, Colors.red));
                                } else {
                                  lotCtrl.onRandom();
                                }
                              } else if (lotCtrl.selectedChoice == "2") {
                                if (lotCtrl.oneDigitNumber.value.text != "" && lotCtrl.twoDigitNumber.value.text != "") {
                                  showDialog(
                                      context: Get.context!,
                                      builder: (context) => MessageAlertMsg('error', "ຈຳນວນເລກທີ່ຕ້ອງການສຸ່ມຕ້ອງບໍ່ເກີນ 1 ເລກ ສຳລັບເລກ ${lotCtrl.selectedChoice} ຫຼັກ", Icons.error_outline, Colors.red));
                                } else {
                                  lotCtrl.onRandom();
                                }
                              }
                              //  lotCtrl.onRandom();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.green.shade500,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  'ok'.tr,
                                  style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge1, color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          })),
    );
  }
}
