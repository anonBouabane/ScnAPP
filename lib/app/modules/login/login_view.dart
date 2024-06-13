import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/app/routes/app_pages.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/base/message_alert_message.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/scn_logo_widget.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: OverlayLoaderWithAppIcon(
          isLoading: controller.isDataLoading.value,
          appIcon: LoadingWidget(),
          circularProgressColor: Colors.green.shade800,
          child: Stack(
            children: [
              BackgroundWidget(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    const Gap(56),
                    ScnLogoWidget(),
                    const Gap(16),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(Images.loginBg),
                          fit: BoxFit.fill,
                        ),
                      ),
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 4.0,
                                  right: 8,
                                ),
                                child: Text(
                                  Translates.PHONE_NUMBER.tr,
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 6.0),
                                padding: EdgeInsets.only(top: 6),
                                width: 50,
                                height: 48,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Images.phonePrefixBox),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '020',
                                    style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.inputBg),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: controller.phoneNumberCtrl,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      counterText: '',
                                      contentPadding: EdgeInsets.only(left: 10),
                                    ),
                                    keyboardType: TextInputType.phone,
                                    maxLength: 8,
                                    style: robotoBold.copyWith(
                                      fontSize: Dimensions.fontSizeExtraLarge,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Gap(16),
                    InkWell(
                      onTap: () async {
                        if (controller.phoneNumberCtrl.text.isNotEmpty &&
                            controller.phoneNumberCtrl.text.length == 8) {
                          final result = await controller.requestOTP();
                          if (result) {
                            Get.toNamed(
                              Routes.VERIFY_OTP,
                              arguments: controller.phoneNumberCtrl.text,
                            );
                          } else {
                            showDialog(
                              context: Get.context!,
                              builder: (_context) => MessageAlertMsg(
                                Translates.ERROR.tr,
                                Translates.SOMETHING_WRONG.tr,
                                Icons.error_outline,
                                Colors.red,
                              ),
                            );
                          }
                        } else {
                          showDialog(
                            context: Get.context!,
                            builder: (_context) => MessageAlertMsg(
                              Translates.ERROR.tr,
                              Translates.ENTER_PHONE_NUMBER_EIGHT_DIGITS.tr,
                              Icons.error_outline,
                              Colors.red,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 55,
                        width: Get.width / (context.isTablet ? 2 : 1.5),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.loginBtn),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
