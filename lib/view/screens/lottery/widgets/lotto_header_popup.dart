import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/textStyle.dart';

class LottoHeaderPopup extends StatelessWidget {
  const LottoHeaderPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(builder: (lotCtrl) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ຕື່ມຫຼັກ',
                style: OptionTextStyle().optionStyle(24, null, FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.only(top: 8, left: 8.0, right: 8.0),
                child: Text(
                  'ຖ້າທ່ານມີເລກ "91,51,11" ຖ້າຕື່ມເລກ 8 ໃສ່ຈະກາຍເປັນ "891,851,811',
                  style: OptionTextStyle().optionStyle(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextField(
                  controller: lotCtrl.headerNumberCtrl.value,
                  autofocus: true,
                  style: OptionTextStyle().optionStyle(),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop(false);
                          // lotCtrl.setAddInFrontNumber(true);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15.0)),
                          ),
                          child: Text(
                            'cancel'.tr,
                            style: OptionTextStyle().optionStyle(null, Colors.white, FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          lotCtrl.setAddInFrontNumber(true);
                          List<String> tempData = [];
                          for (int i = 0; i < lotCtrl.numberCtrl.value.text.split(',').length; i++) {
                            tempData.add(lotCtrl.headerNumberCtrl.value.text + lotCtrl.numberCtrl.value.text.split(',')[i]);
                          }
                          lotCtrl.numberCtrl.value.text = tempData.join(',');
                          Navigator.pop(context);
                          lotCtrl.headerNumberCtrl.value.clear();
                          // setState(() {
                          //   List<String> tempData = [];
                          //   // print(_inputLotteryNumberController.text
                          //   //     .split(',')
                          //   //     .length);
                          //   for (int i = 0; i < _inputLotteryNumberController.text.split(',').length; i++) {
                          //     tempData.add(_inputLotteryHeaderNumber.text + _inputLotteryNumberController.text.split(',')[i]);
                          //   }
                          //   _inputLotteryNumberController.text = tempData.join(',');
                          //   // print(_inputLotteryNumberController.text);
                          //   Navigator.pop(context);
                          //   _inputLotteryHeaderNumber.text = '';
                          // });
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                          decoration: BoxDecoration(
                            color: Colors.green.shade500,
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(15.0)),
                          ),
                          child: Text(
                            'ok'.tr,
                            style: OptionTextStyle().optionStyle(null, Colors.white, FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
