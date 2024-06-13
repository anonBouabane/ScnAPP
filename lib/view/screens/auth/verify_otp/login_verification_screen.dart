import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/data/model/response/response_model.dart';
import 'package:scn_easy/helper/route_helper.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/base/custom_button.dart';

import '../../../../helper/responsive_helper.dart';
import '../../../../util/images.dart';
import '../../../base/message_alert_message.dart';
import '../register_screen.dart';

class LoginVerificationScreen extends StatefulWidget {
  final String number;

  const LoginVerificationScreen({Key? key, required this.number})
      : super(key: key);

  @override
  State<LoginVerificationScreen> createState() =>
      _LoginVerificationScreenState();
}

class _LoginVerificationScreenState extends State<LoginVerificationScreen> {
  String? _number;
  Timer? _timer;
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    _number = widget.number;
    _startTimer();
  }

  void _startTimer() {
    _seconds = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _seconds = _seconds - 1;
      if (_seconds == 0) {
        timer.cancel();
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          SafeArea(child: GetBuilder<AuthController>(builder: (authController) {
        return Stack(
          children: [
            Image(
              image: AssetImage(Images.scnBackgroundPng),
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            OverlayLoaderWithAppIcon(
              isLoading: authController.isLoading,
              appIcon: Image.asset(Images.loadingLogo),
              circularProgressColor: Colors.green.shade800,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Image.asset(
                        Images.logo,
                        height: 160,
                        width: 150,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 18),
                      Text('${'please_enter_4_digit_code'.tr}\n$_number',
                          style: robotoBold.copyWith(
                            fontSize: 18,
                            color: Colors.redAccent.shade700,
                          ),
                          textAlign: TextAlign.center),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              ResponsiveHelper.isTab(context) ? 200 : 39,
                          vertical: 35,
                        ),
                        child: PinCodeTextField(
                          length: 4,
                          appContext: context,
                          keyboardType: TextInputType.number,
                          animationType: AnimationType.none,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            fieldHeight: 60,
                            fieldWidth: 60,
                            borderWidth: 1,
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
                            selectedColor:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            selectedFillColor: Colors.white,
                            inactiveFillColor: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.2),
                            inactiveColor:
                                Theme.of(context).primaryColor.withOpacity(0.2),
                            activeColor:
                                Theme.of(context).primaryColor.withOpacity(0.4),
                            activeFillColor: Theme.of(context)
                                .disabledColor
                                .withOpacity(0.2),
                          ),
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: true,
                          onChanged: authController.updateVerificationCode,
                          beforeTextPaste: (text) => true,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'did_not_receive_the_code'.tr,
                              style: robotoBold.copyWith(
                                  color: Colors.redAccent.shade700),
                            ),
                            TextButton(
                              onPressed: _seconds < 1
                                  ? () async {
                                      var response = await authController
                                          .sendOTP(_number!);
                                      if (response.isSuccess) {
                                        if (kDebugMode) {
                                          Logger().i(
                                              "sendOTP: ${response.message}");
                                        }
                                      }
                                      _startTimer();
                                    }
                                  : null,
                              child: Text(
                                '${'resend'.tr}${_seconds > 0 ? ' ($_seconds)' : ''}',
                                style: robotoBold.copyWith(
                                  color: Colors.redAccent.shade700,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ]),
                      authController.verificationCode.length == 4
                          ? buildConfirmVerifyButton(authController)
                          : const SizedBox.shrink(),
                    ]),
              ),
            ),
          ],
        );
      })),
    );
  }

  Widget buildConfirmVerifyButton(AuthController authController) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CustomButton(
        buttonText: 'verify'.tr,
        width: 270,
        height: 60,
        radius: 6,
        color: Colors.red.shade800,
        onPressed: () async {
          ResponseModel loginResponse = await authController.login(
              _number!, authController.verificationCode);
          if (loginResponse.isSuccess) {
            Map jsonResponse = json.decode(loginResponse.message);
            if (jsonResponse['login'] == false) {
              Get.to(() => RegisterScreen());
            } else {
              Get.offAllNamed(RouteHelper.getDashboardRoute());
            }
          } else {
            showDialog(
              context: Get.context!,
              builder: (_context) => MessageAlertMsg(
                'error',
                loginResponse.message,
                Icons.error_outline,
                Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
