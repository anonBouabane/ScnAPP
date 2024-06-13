import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';

class LottoAnimalBook extends StatelessWidget {
  const LottoAnimalBook({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LotteryController>(builder: (lotCtrl) {
      return Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3),
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 60),
                width: MediaQuery.of(context).size.width - 5,
                height: MediaQuery.of(context).size.height - 220,
                decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0)), color: Colors.white),
                child: Scaffold(
                  resizeToAvoidBottomInset: true,
                  body: Container(
                      color: Colors.white,
                      child: GetBuilder<LotteryController>(builder: (lotCtrl) {
                        return ListView.builder(
                            itemCount: lotCtrl.animalList.length,
                            shrinkWrap: false,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 50, height: 50, child: Image.asset(lotCtrl.animalList[index].img.toString())),
                                      SizedBox(width: 5),
                                      Text(
                                        lotCtrl.animalList[index].name.toString().tr,
                                        style: robotoRegular,
                                      ),
                                      Spacer(),
                                      for (int i = 0; i < lotCtrl.getChoiceList()[index].split(',').length; i++)
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                lotCtrl.addBySubList(index, i);
                                                // lotCtrl.setAddInFrontNumber(false);
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(left: 4),
                                                padding: EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: lotCtrl.selectedChoices.contains(lotCtrl.getChoiceList()[index].split(',')[i])
                                                      ? Colors.pinkAccent.shade100
                                                      : lotCtrl.selectedChoices.contains(lotCtrl.getChoiceList()[index])
                                                          ? Colors.pinkAccent.shade100
                                                          : Colors.grey.shade100,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 4.0, right: 4),
                                                  child: Text(
                                                    lotCtrl.getChoiceList()[index].split(',')[i],
                                                    style: robotoRegular.copyWith(
                                                        color: lotCtrl.selectedChoices.contains(lotCtrl.getChoiceList()[index].split(',')[i])
                                                            ? Colors.white
                                                            : lotCtrl.selectedChoices.contains(lotCtrl.getChoiceList()[index])
                                                                ? Colors.white
                                                                : Colors.black),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      SizedBox(width: 5),
                                      Container(
                                          width: 80,
                                          height: 32,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
                                          child: ElevatedButton(
                                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.shade100)),
                                            child: Text(
                                              'full_set'.tr,
                                              style: robotoRegular.copyWith(color: Colors.black),
                                            ),
                                            onPressed: () {
                                              lotCtrl.addByFullSet(index);
                                              // lotCtrl.setAddInFrontNumber(true);
                                            },
                                          ))
                                    ],
                                  ),
                                  //index != lotCtrl.animalList.length - 1 ? Divider(color: Colors.red) : SizedBox()
                                ],
                              );
                            });
                      })),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
