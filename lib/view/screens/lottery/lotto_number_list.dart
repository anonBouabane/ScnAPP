import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../controller/lottery_controller.dart';
import 'widgets/lotto_edit_amount_and_number.dart';

class LottoNumberList extends StatelessWidget {
  const LottoNumberList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(builder: (lotCtrl) {
      return Container(
        margin: const EdgeInsets.only(bottom: 130.0),
        child: Column(
          children: [
            //Header
            Container(
              height: 50,
              decoration: BoxDecoration(color: Colors.red.shade800),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text('ເລກທີ່ທ່ານເລືອກ',
                        style: robotoBold.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeExtraLarge1)),
                  ),
                  Row(
                    children: [
                      Text('ຈຳນວນເງິນ',
                          style: robotoBold.copyWith(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeExtraLarge1)),
                      SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          lotCtrl.clearAllNumberList();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          child: Icon(Icons.clear, color: Colors.red, size: 25),
                        ),
                      ),
                      SizedBox(width: 25),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < lotCtrl.numberModel.length; i++)
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            lotCtrl.editNumberCtrl.value.text =
                                lotCtrl.numberModel[i].number.toString();
                            showDialog(
                                context: context,
                                builder: (context) => LottoEditAmountAndNumber(
                                    lotCtrl.numberModel[i].amount!, i,
                                    isNumber: true));
                          },
                          child: Row(
                            children: [
                              for (int j = 0;
                                  j < lotCtrl.getChoiceList().length;
                                  j++) ...[
                                if (lotCtrl.numberModel.isNotEmpty &&
                                    lotCtrl.numberModel[i].number
                                            .toString()
                                            .length ==
                                        1) ...[
                                  if (lotCtrl.getChoiceList()[j].contains('0' +
                                      lotCtrl.numberModel[i].number
                                          .toString()
                                          .substring(lotCtrl
                                                  .numberModel[i].number
                                                  .toString()
                                                  .length -
                                              1)))
                                    Container(
                                        height: 40.0,
                                        width: 40.0,
                                        child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              radius: 10,
                                              child: Image.asset(
                                                  lotCtrl.getChoiceListImg()[j],
                                                  fit: BoxFit.fill,
                                                  width: 40,
                                                  height: 40),
                                            )),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Colors.deepOrange,
                                                width: 2.0))),
                                ] else ...[
                                  if (lotCtrl.numberModel.isNotEmpty &&
                                      lotCtrl
                                          .numberModel[i].number!.isNotEmpty &&
                                      lotCtrl.getChoiceList()[j].contains(
                                          lotCtrl.numberModel[i].number
                                              .toString()
                                              .substring(lotCtrl
                                                      .numberModel[i].number
                                                      .toString()
                                                      .length -
                                                  2)))
                                    Container(
                                      height: 40.0,
                                      width: 40.0,
                                      child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.transparent,
                                            radius: 10,
                                            child: Image.asset(
                                                lotCtrl.getChoiceListImg()[j],
                                                fit: BoxFit.fill,
                                                width: 40,
                                                height: 40),
                                          )),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Colors.deepOrange,
                                              width: 2.0)),
                                    ),
                                ]
                              ],
                              const SizedBox(width: 10),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                    lotCtrl.numberModel[i].number.toString(),
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.fontSizeExtraLarge1)),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                lotCtrl.editAmountCtrl.value.text =
                                    lotCtrl.numberModel[i].amount.toString();
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                        LottoEditAmountAndNumber(
                                            lotCtrl.numberModel[i].amount!, i));
                              },
                              child: Text(
                                lotCtrl.numberModel.isEmpty
                                    ? "0"
                                    : PriceConverter.convertPriceNoCurrency(
                                        double.parse(lotCtrl
                                            .numberModel[i].amount
                                            .toString())),
                                style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge1),
                              ),
                            ),
                            SizedBox(width: 15),
                            InkWell(
                              onTap: () {
                                lotCtrl.removeFromCart(i);
                              },
                              child: Container(
                                margin: EdgeInsets.only(bottom: 8, right: 2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.redAccent.shade700),
                                child: Icon(Icons.clear,
                                    color: Colors.white, size: 25),
                              ),
                            ),
                            SizedBox(width: 25)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 28.0, right: 30),
                      child: const Divider()),
                ],
              ),
            SizedBox(height: 40)
          ],
        ),
      );
    });
  }
}
