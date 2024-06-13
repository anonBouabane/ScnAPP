import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../util/images.dart';
import '../../languages/translates.dart';
import '../../widgets/error_alert_widget.dart';
import 'condition_checkbox.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image(
              image: AssetImage(Images.scnBackgroundPng),
              fit: BoxFit.fill,
              height: Get.height,
              width: Get.width,
            ),
            OverlayLoaderWithAppIcon(
              isLoading: controller.isDataLoading.value,
              appIcon: Image.asset(Images.loadingLogo),
              circularProgressColor: Colors.green.shade800,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(Images.logo,
                        height: 160, width: 150, fit: BoxFit.fill),
                    Container(
                      height: 290,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(Images.registerBg),
                              fit: BoxFit.fill)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(bottom: 25),
                                      child: Center(
                                        child: Text(
                                            Translates.TEXT_FIELD_FIRST_NAME.tr,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge)),
                                      ),
                                    ),
                                    // SizedBox(height: 30),
                                    Container(
                                      height: 50,
                                      child: Center(
                                        child: Text(
                                            Translates.TEXT_FIELD_LAST_NAME.tr,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge)),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      height: 50,
                                      padding: EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Text(
                                            Translates
                                                .TEXT_FIELD_PHONE_NUMBER.tr,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge)),
                                      ),
                                    ),
                                    Container(
                                      height: 70,
                                      padding: EdgeInsets.only(top: 32),
                                      child: Center(
                                        child: Text(Translates.GENDER.tr,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Images.inputBg),
                                                  fit: BoxFit.fill)),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller: controller.txtFirstName,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, top: 5, bottom: 5),
                                            ),
                                            // onChanged: (newValue) {
                                            //   controller
                                            //       .getFirstNameLength(newValue);
                                            // },
                                            keyboardType: TextInputType.text,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge),
                                            maxLength: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text(
                                            '${controller.txtFirstName.text.length}/30',
                                            style: robotoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall),
                                          ),
                                        )
                                      ],
                                    ),
                                    // SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      Images.inputBg),
                                                  fit: BoxFit.fill)),
                                          child: TextFormField(
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller: controller.txtLastName,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              counterText: '',
                                              contentPadding: EdgeInsets.only(
                                                  left: 10, top: 5, bottom: 5),
                                            ),
                                            // onChanged: (newValue) {
                                            //   controller
                                            //       .getLastNameLength(newValue);
                                            // },
                                            keyboardType: TextInputType.text,
                                            style: robotoBold.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeLarge),
                                            maxLength: 30,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text(
                                              '${controller.txtLastName.text.length}/30',
                                              style: robotoRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall)),
                                        )
                                      ],
                                    ),
                                    // SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 6.0),
                                              padding: EdgeInsets.only(top: 6),
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        Images.phonePrefixBox),
                                                    fit: BoxFit.fill),
                                              ),
                                              child: Center(
                                                child: Text('020',
                                                    style: robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeLarge)),
                                              ),
                                            ),
                                            Flexible(
                                              child: Container(
                                                height: 50,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                          Images.inputBg),
                                                      fit: BoxFit.fill),
                                                ),
                                                child: TextFormField(
                                                    readOnly: true,
                                                    controller:
                                                        controller.txtPhone,
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      // isDense: true,
                                                      counterText: '',
                                                      // contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10)
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 10,
                                                              top: 5,
                                                              bottom: 5),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    style: robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .fontSizeLarge),
                                                    maxLength: 8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: Text(
                                              '${controller.txtPhone.text.length}/8',
                                              style: robotoRegular.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall)),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: RadioListTile(
                                            title: Text(Translates.MALE.tr),
                                            value: 'm',
                                            groupValue: controller.gender.value,
                                            onChanged: (value) {
                                              controller.gender(value);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: RadioListTile(
                                            title: Text(Translates.FEMALE.tr),
                                            value: 'f',
                                            groupValue: controller.gender.value,
                                            onChanged: (value) {
                                              controller.gender(value);
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: ConditionCheckbox(),
                    ),
                    InkWell(
                      onTap: () async {
                        if (controller.acceptTerms.value) {
                          if (controller.txtFirstName.text.isNotEmpty &&
                              controller.txtLastName.text.isNotEmpty) {
                            controller.register();
                          } else {
                            Get.dialog(ErrorAlertWidget(
                                message: Translates.FILL_THE_FORM.tr));
                          }
                        }
                      },
                      child: controller.acceptTerms.value
                          ? Container(
                              height: 60,
                              width: Get.width / 1.5,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.registerBtn),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : Container(
                              height: 60,
                              width: Get.width / 1.5,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  Translates.BUTTON_REGISTER.tr,
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge1,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
