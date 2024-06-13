import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../util/dimensions.dart';

class BankListSelected extends StatelessWidget {
  const BankListSelected();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: GetBuilder<UserController>(
        builder: (userController) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.red.shade800,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                ),
                child: Text('select_bank'.tr,
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Colors.white),
                    textAlign: TextAlign.center),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height / 3.5,
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: userController.bankList.isNotEmpty
                          ? ListView.builder(
                              itemCount: userController.bankList.length,
                              physics: AlwaysScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              itemBuilder: (context, i) {
                                return InkWell(
                                  onTap: () {
                                    userController.setSelectedBank(
                                        i,
                                        userController.bankList[i].id!,
                                        userController.bankList[i].bankName
                                            .toString());
                                    Get.back();
                                  },
                                  child: Card(
                                      color: userController.selectedBank == i ||
                                              userController.bankId ==
                                                  userController.bankList[i].id!
                                          ? Colors.redAccent.shade700
                                          : Colors.white,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${userController.bankList[i].bankName}",
                                          style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge,
                                              color: userController
                                                              .selectedBank ==
                                                          i ||
                                                      userController.bankId ==
                                                          userController
                                                              .bankList[i].id!
                                                  ? Colors.white
                                                  : Colors.red.shade700),
                                        ),
                                      )),
                                );
                              })
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
              // const Divider(),
              // InkWell(
              //   onTap: () {
              //     Navigator.of(context).pop(false);
              //   },
              //   child: Container(
              //     padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              //     decoration: BoxDecoration(
              //       color: Colors.red.shade800,
              //       borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
              //     ),
              //     child: Text('ok'.tr, style: robotoBold, textAlign: TextAlign.center),
              //   ),
              // ),
            ],
          );
        },
      ),
    );
  }
}
