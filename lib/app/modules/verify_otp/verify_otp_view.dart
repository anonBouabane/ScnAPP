import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:pinput/pinput.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/base/custom_button.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../widgets/background_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/scn_logo_widget.dart';
import 'verify_otp_controller.dart';

class VerifyOtpView extends GetView<VerifyOtpController> {
  VerifyOtpView({super.key});

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 60,
    textStyle: const TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    decoration: BoxDecoration(
      color: Colors.red.shade100,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.transparent),
    ),
  );

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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Gap(56),
                    ScnLogoWidget(),
                    const Gap(32),
                    Text(
                      '${Translates.PLEASE_ENTER_FOUR_DIGIT_CODE.tr}\n${controller.phoneNumber.value}',
                      style: robotoBold.copyWith(
                        fontSize: 18,
                        color: Colors.redAccent.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(16),
                    Pinput(
                      length: 4,
                      defaultPinTheme: defaultPinTheme,
                      controller: controller.pinController,
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsUserConsentApi,
                      onCompleted: (pin) {
                        controller.otpCode.value = pin;
                        controller.isShowConfirmButton.value = true;
                      },
                    ),
                    const Gap(48),
                    // Pinput(
                    //   length: 4,
                    //   autofocus: true,
                    //   closeKeyboardWhenCompleted: true,
                    //   defaultPinTheme: defaultPinTheme,
                    //   focusedPinTheme: defaultPinTheme.copyWith(
                    //     decoration: defaultPinTheme.decoration!.copyWith(
                    //       border: Border.all(color: Colors.red),
                    //     ),
                    //   ),
                    //   onCompleted: (pin) {
                    //     controller.otpCode.value = pin;
                    //     controller.isShowConfirmButton.value = true;
                    //   },
                    // ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 39,
                    //     vertical: 35,
                    //   ),
                    //   child: Pinput(
                    //     length: 4,
                    //     appContext: context,
                    //     keyboardType: TextInputType.number,
                    //     animationType: AnimationType.none,
                    //     pinTheme: PinTheme(
                    //       shape: PinCodeFieldShape.box,
                    //       fieldHeight: 60,
                    //       fieldWidth: 60,
                    //       borderWidth: 1,
                    //       borderRadius:
                    //           BorderRadius.circular(Dimensions.RADIUS_SMALL),
                    //       selectedColor:
                    //           Theme.of(context).primaryColor.withOpacity(0.2),
                    //       selectedFillColor: Colors.white,
                    //       inactiveFillColor:
                    //           Theme.of(context).disabledColor.withOpacity(0.2),
                    //       inactiveColor:
                    //           Theme.of(context).primaryColor.withOpacity(0.2),
                    //       activeColor:
                    //           Theme.of(context).primaryColor.withOpacity(0.4),
                    //       activeFillColor:
                    //           Theme.of(context).disabledColor.withOpacity(0.2),
                    //     ),
                    //     animationDuration: const Duration(milliseconds: 300),
                    //     backgroundColor: Colors.transparent,
                    //     enableActiveFill: true,
                    //     onChanged: () {},
                    //     beforeTextPaste: (text) => true,
                    //   ),
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Translates.DID_NOT_RECEIVE_THE_CODE.tr,
                          style: robotoBold.copyWith(
                            color: Colors.redAccent.shade700,
                          ),
                        ),
                        const Gap(16),
                        controller.isShowResendButton.isFalse
                            ? Countdown(
                                seconds: 30,
                                controller: controller.countdownController,
                                build: (context, double time) => Text(
                                  time.round().toString(),
                                  style: robotoBold.copyWith(
                                    color: Colors.redAccent.shade700,
                                  ),
                                ),
                                interval: const Duration(seconds: 1),
                                onFinished: () {
                                  controller.isShowResendButton.value = true;
                                },
                              )
                            : TextButton(
                                onPressed: () => controller.resendOTP(),
                                child: Text(
                                  Translates.BUTTON_RESEND.tr,
                                  style: robotoBold.copyWith(
                                    color: Colors.redAccent.shade700,
                                  ),
                                ),
                              ),
                      ],
                    ),
                    const Gap(16),
                    controller.isShowConfirmButton.isTrue
                        ? buildConfirmButton(context)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildConfirmButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CustomButton(
        buttonText: Translates.BUTTON_VERIFY.tr,
        width: 270,
        height: 60,
        radius: 6,
        color: Colors.red.shade800,
        onPressed: () async {
          await controller.verifyOTP();
        },
      ),
    );
  }
}
