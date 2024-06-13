import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../controller/auth_controller.dart';
import '../../../util/images.dart';
import '../../base/message_alert_message.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      body: SafeArea(
        child: GetBuilder<AuthController>(builder: (authController) {
          return OverlayLoaderWithAppIcon(
            isLoading: authController.isLoading,
            appIcon: Image.asset(Images.loadingLogo),
            circularProgressColor: Colors.green.shade800,
            child: Stack(
              children: [
                Image(
                  image: AssetImage(Images.scnBackgroundPng),
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Image.asset(
                        Images.logo,
                        height: 160,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      SizedBox(height: 16),
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
                                    "phoneNo".tr,
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
                                      controller: authController.phoneNo.value,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        counterText: '',
                                        contentPadding:
                                            EdgeInsets.only(left: 10),
                                      ),
                                      onChanged: (newValue) {
                                        authController.getPhoneLength(newValue);
                                      },
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
                            Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Text(
                                "${authController.phoneLength.length}/8",
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // Get.to(() => RegisterScreen());
                          if (authController.phoneNo.value.text.isNotEmpty &&
                              authController.phoneNo.value.text.length == 8) {
                            var response = await authController.sendOTP(
                                authController.phoneNo.value.text.trim());
                            if (!response.isSuccess) {
                              showDialog(
                                context: Get.context!,
                                builder: (_context) => MessageAlertMsg(
                                  'error',
                                  response.message,
                                  Icons.error_outline,
                                  Colors.red,
                                ),
                              );
                            }
                          } else {
                            showDialog(
                              context: Get.context!,
                              builder: (_context) => MessageAlertMsg(
                                'error',
                                "enterPhoneNo8d".tr,
                                Icons.error_outline,
                                Colors.red,
                              ),
                            );
                          }
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width /
                              (context.isTablet ? 2 : 1.5),
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
          );
        }),
      ),
    );
  }
}
