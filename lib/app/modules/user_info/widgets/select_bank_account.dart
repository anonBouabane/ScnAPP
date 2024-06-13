import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../languages/translates.dart';
import '../../../models/bank_model.dart';
import '../user_info_controller.dart';

class SelectBankCompanyWidget extends GetView<UserInfoController> {
  const SelectBankCompanyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 0.0),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.red.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32.0),
                topRight: Radius.circular(32.0),
              ),
            ),
            child: Text(
              Translates.SELECT_BANK_COMPANY.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: Get.width * 0.7,
            height: Get.height * 0.35,
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Expanded(
                  child: controller.userController.bankList.isNotEmpty
                      ? ListView.builder(
                          itemCount: controller.userController.bankList.length,
                          physics: AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            BankItem item =
                                controller.userController.bankList[i];
                            return InkWell(
                              onTap: () {
                                controller.bankId.value = item.id!;
                                controller.bankName.value = item.bankName!;
                                controller.txtBankName.text = item.bankName!;

                                Logger().i(
                                  'bankIdSelected: ${controller.bankId.value}\n'
                                  'bankNameSelected: ${controller.bankName.value}',
                                );
                                Get.back();
                              },
                              child: Card(
                                  color: controller.bankId.value == item.id!
                                      ? Colors.redAccent.shade700
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${item.bankName}",
                                      style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color:
                                            controller.bankId.value == item.id!
                                                ? Colors.white
                                                : Colors.red.shade700,
                                      ),
                                    ),
                                  )),
                            );
                          })
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
