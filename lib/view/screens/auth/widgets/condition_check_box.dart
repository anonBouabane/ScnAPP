import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/controller/user_controller.dart';

import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../policy/scn_policy.dart';

class ConditionCheckBox extends StatelessWidget {
  final UserController authController;

  ConditionCheckBox({required this.authController});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
        activeColor: Theme.of(context).primaryColor,
        value: authController.acceptTerms,
        onChanged: (bool? isChecked) => authController.toggleTerms(),
      ),
      InkWell(
          onTap: () {
            authController.toggleTerms();
          },
          child: Text('i_agree_with'.tr, style: robotoRegular)),
      InkWell(
        onTap: () {
          Get.to(() => PolicyScreen());
        },
        child: Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL), child: Text('terms_conditions'.tr, style: robotoMedium.copyWith(color: ColorResources.getYellow(context)))),
      ),
    ]);
  }
}
