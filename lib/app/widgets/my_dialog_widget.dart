import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../languages/translates.dart';

class MyDialogWidget {
  static void showErrorDialog({
    required String title,
    required String message,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(message),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.red.shade500),
                ),
                child: Text(Translates.BUTTON_CLOSE.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showSuccessDialog({
    required String title,
    required String message,
  }) {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.red.shade500,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(Get.context!).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              const Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  message,
                  style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () => Get.back(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
                child: Text(Translates.BUTTON_OK.tr),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future showConfirmDialog({
    required String title,
    required String message,
    required Function onCancel,
    required Function onConfirm,
  }) {
    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        backgroundColor: Colors.red.shade500,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => onCancel(),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber),
                ),
                child: Text(Translates.BUTTON_CANCEL.tr),
              ),
              ElevatedButton(
                onPressed: () => onConfirm(),
                child: Text(Translates.BUTTON_OK.tr),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void showProgressDialog() {
    Get.dialog(
      barrierDismissible: false,
      const Center(child: CircularProgressIndicator()),
      barrierColor:
          Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
      useSafeArea: true,
    );
  }

  static void hideProgressDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  static void showInfoSnackBar({
    required String title,
    required String message,
  }) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      titleText: Text(
        title,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!).textTheme.titleLarge!.copyWith(
            fontSize: 14, fontWeight: FontWeight.normal, color: Colors.white),
      ),
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(8),
      icon: const Icon(Icons.info_outline, size: 40, color: Colors.white),
      shouldIconPulse: true,
      duration: const Duration(seconds: 4),
    );
  }

  static void showSuccessSnackBar({
    required String title,
    required String message,
  }) {
    if (Get.isSnackbarOpen) Get.back();
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade700,
      titleText: Text(
        title,
        style: Theme.of(Get.context!)
            .textTheme
            .titleSmall
            ?.copyWith(color: Colors.white),
      ),
      messageText: Text(
        message,
        style: Theme.of(Get.context!)
            .textTheme
            .bodySmall
            ?.copyWith(color: Colors.white),
      ),
      colorText: Colors.white,
      borderRadius: 8,
      // margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      icon: const Icon(
        Icons.check_circle_outline,
        size: 40,
        color: Colors.white,
      ),
      shouldIconPulse: true,
      duration: const Duration(seconds: 4),
    );
  }
}
