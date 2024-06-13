import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:timer_count_down/timer_controller.dart';

import '../../controllers/storage_controller.dart';
import '../../routes/app_pages.dart';
import '../../services/auth_service.dart';
import '../../widgets/error_alert_widget.dart';

class VerifyOtpController extends GetxController {
  final AuthService authService = Get.find<AuthService>();
  final StorageController storageController = Get.find<StorageController>();
  final CountdownController countdownController =
      new CountdownController(autoStart: true);
  late TextEditingController pinController;

  RxBool isDataLoading = RxBool(false);
  RxBool isShowConfirmButton = RxBool(false);
  RxBool isShowResendButton = RxBool(false);
  RxBool isLoggedIn = RxBool(false);
  RxString phoneNumber = RxString('');
  RxString otpCode = RxString('');

  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = Get.arguments;
    pinController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    pinController.dispose();
  }

  verifyOTP() async {
    try {
      isDataLoading.value = true;
      final json = await authService.verifyOTP(
        phoneNumber: phoneNumber.value,
        otpCode: otpCode.value,
      );

      if (json.statusCode == 200) {
        isLoggedIn.value = json.data['login'];
        storageController.accessToken = json.data['token'];

        if (kDebugMode) {
          Logger().i('tokenResponse: ${json.data['token']}\n'
              'tokenStorage: ${storageController.accessToken}\n'
              'isLoggedIn: ${isLoggedIn.value}');
        }

        isLoggedIn.isTrue
            ? Get.offAllNamed(Routes.DASHBOARD)
            : Get.toNamed(Routes.REGISTER, arguments: phoneNumber.value);
      }
      isDataLoading.value = false;
    } on DioException catch (dioException) {
      isDataLoading.value = false;
      final apiException = ApiException.fromDioError(dioException);

      // showDialog(
      //   context: Get.context,
      //   builder: (_) => CustomDialogWidget(
      //     title: Translates.ERROR.tr,
      //     message: apiException.message,
      //     buttonText: Translates.BUTTON_CLOSE.tr,
      //   ),
      // );

      Get.dialog(ErrorAlertWidget(
        message: apiException.message,
      ));

      // Get.dialog(FadeAnimation(
      //   0.1,
      //   Container(
      //     child: AlertDialog(
      //       shape: const RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(32.0)),
      //       ),
      //       contentPadding: const EdgeInsets.only(top: 10.0),
      //       content: SizedBox(
      //         height: 270,
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.stretch,
      //           mainAxisSize: MainAxisSize.min,
      //           children: [
      //             Expanded(
      //               child: FadeAnimation(
      //                 0.2,
      //                 ClipOval(
      //                   child: Icon(Icons.error_outline,
      //                       size: 100, color: Colors.red),
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(4.0),
      //               child: Center(
      //                 child: SingleChildScrollView(
      //                   child: Column(
      //                     children: [
      //                       Text(
      //                         Translates.ERROR.tr,
      //                         style: OptionTextStyle().optionStyle(
      //                             20, Colors.red.shade900, FontWeight.bold),
      //                       ),
      //                       Text(
      //                         apiException.message,
      //                         style: OptionTextStyle()
      //                             .optionStyle(14, null, FontWeight.bold),
      //                         textAlign: TextAlign.center,
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ),
      //             ),
      //             GestureDetector(
      //               onTap: () => Get.back(),
      //               child: Container(
      //                 padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      //                 decoration: BoxDecoration(
      //                   color: Colors.red.shade800,
      //                   borderRadius: const BorderRadius.only(
      //                     bottomLeft: Radius.circular(32.0),
      //                     bottomRight: Radius.circular(32.0),
      //                   ),
      //                 ),
      //                 child: Text(
      //                   Translates.BUTTON_OK.tr,
      //                   style: OptionTextStyle()
      //                       .optionStyle(null, Colors.white, FontWeight.bold),
      //                   textAlign: TextAlign.center,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ));

      // showDialog(
      //   context: Get.context!,
      //   builder: (context) => MessageAlertMsg(
      //     Translates.ERROR.tr,
      //     apiException.message,
      //     Icons.error_outline,
      //     Colors.red,
      //   ),
      // );

      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }

  resendOTP() async {
    try {
      isDataLoading.value = true;
      isShowResendButton.value = false;
      pinController.clear();
      final json = await authService.requestOTP(
        phoneNumber: phoneNumber.value,
      );
      if (json.statusCode == 200) {
        if (kDebugMode) {
          Logger().d('response: ${json.data}');
        }

        countdownController.start();
      }
      isDataLoading.value = false;
    } on DioException catch (dioException) {
      isDataLoading.value = false;
      if (kDebugMode) {
        final apiException = ApiException.fromDioError(dioException);
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }
}
