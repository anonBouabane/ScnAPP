import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';
import 'package:scn_easy/app/modules/notification/notification_model.dart';

import 'notification_service.dart';

class NotificationController extends GetxController
    with StateMixin<NotificationModel> {
  final NotificationService notificationService =
      Get.put(NotificationService());

  RxBool isDataLoading = RxBool(false);
  RxList<NotificationItem> lstNotifications = RxList([]);

  @override
  void onInit() async {
    super.onInit();
    getNotifications();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getNotifications() async {
    change(null, status: RxStatus.loading());
    try {
      var json = await notificationService.loadNotifications();
      if (json.statusCode == 200) {
        change(NotificationModel.fromJson(json.data),
            status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on DioException catch (dioException) {
      change(null, status: RxStatus.error(dioException.message));
      final apiException = ApiException.fromDioError(dioException);
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }

  // getNotifications() async {
  //   try {
  //     isDataLoading.value = true;
  //     update();
  //     final json = await notificationService.loadNotifications();
  //     if (json.statusCode == 200) {
  //       lstNotifications.clear();
  //       update();
  //       final test = jsonEncode(json.data);
  //       final items = notificationModelFromJson(test);
  //       if (items.notifications!.length > 0) {
  //         for (NotificationItem item in items.notifications!) {
  //           lstNotifications.add(item);
  //         }
  //         update();
  //       }
  //     }
  //     isDataLoading.value = false;
  //     update();
  //   } on DioException catch (dioException) {
  //     isDataLoading.value = false;
  //     update();
  //     final apiException = ApiException.fromDioError(dioException);
  //     if (kDebugMode) {
  //       Logger().d('apiException: ${apiException.message}');
  //     }
  //   }
  // }
}
