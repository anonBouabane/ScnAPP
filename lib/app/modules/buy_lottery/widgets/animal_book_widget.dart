import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/buy_lottery/buy_lottery_controller.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../languages/translates.dart';

class AnimalBookWidget extends StatelessWidget {
  const AnimalBookWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 3),
      child: Stack(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 60),
              width: Get.width - 5,
              height: Get.height - 220,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: Colors.white,
              ),
              child: Scaffold(
                resizeToAvoidBottomInset: true,
                body: Container(
                  color: Colors.white,
                  child: GetBuilder<BuyLotteryController>(builder: (state) {
                    return ListView.builder(
                      itemCount: state.animalList.length,
                      shrinkWrap: false,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: Image.asset(state
                                        .animalList[index].img
                                        .toString())),
                                SizedBox(width: 5),
                                Text(
                                  state.animalList[index].name.toString().tr,
                                  style: robotoRegular,
                                ),
                                Spacer(),
                                for (int i = 0;
                                    i <
                                        state
                                            .getChoiceList()[index]
                                            .split(',')
                                            .length;
                                    i++)
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            state.addBySubList(index, i),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 4),
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            color: state.selectedChoices
                                                    .contains(state
                                                        .getChoiceList()[index]
                                                        .split(',')[i])
                                                ? Colors.pinkAccent.shade100
                                                : state.selectedChoices.contains(
                                                        state.getChoiceList()[
                                                            index])
                                                    ? Colors.pinkAccent.shade100
                                                    : Colors.grey.shade100,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, right: 4),
                                            child: Text(
                                              state
                                                  .getChoiceList()[index]
                                                  .split(',')[i],
                                              style: robotoRegular.copyWith(
                                                  color: state.selectedChoices
                                                          .contains(state
                                                              .getChoiceList()[
                                                                  index]
                                                              .split(',')[i])
                                                      ? Colors.white
                                                      : state.selectedChoices
                                                              .contains(state
                                                                      .getChoiceList()[
                                                                  index])
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey.shade100)),
                                    child: Text(
                                      Translates.FULL_SET.tr,
                                      style: robotoRegular.copyWith(
                                          color: Colors.black),
                                    ),
                                    onPressed: () => state.addByFullSet(index),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
