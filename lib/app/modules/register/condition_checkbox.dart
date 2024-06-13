import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/policy/policy_lottery_view.dart';

import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../languages/translates.dart';
import 'register_controller.dart';

class ConditionCheckbox extends GetView<RegisterController> {
  const ConditionCheckbox({Key? key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        activeColor: Colors.red.shade900,
        value: controller.acceptTerms.value,
        onChanged: (bool? isChecked) => controller.acceptTerms.toggle(),
      ),
      InkWell(
          onTap: () => controller.acceptTerms.toggle(),
          child: Text(Translates.I_AGREE_WITH.tr, style: robotoRegular)),
      InkWell(
        onTap: () => Get.to(() => PolicyLotteryView()),
        child: Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
          child: Text(
            Translates.TERM_AND_CONDITIONS.tr,
            style: robotoMedium.copyWith(color: Color(0xFFFFAA47)),
          ),
        ),
      ),
    ]);
  }
}
