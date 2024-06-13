import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/apis/api_exception.dart';

import '../../widgets/error_alert_widget.dart';
import 'notify_model.dart';
import 'notify_service.dart';

class NotifyController extends GetxController with StateMixin<NotifyModel> {
  final NotifyService notificationService = Get.find<NotifyService>();

  RxBool isDataLoading = RxBool(false);
  RxList<NotifyItem> lstNotifications = RxList([]);

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
        change(NotifyModel.fromJson(json.data), status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on DioException catch (dioException) {
      change(null, status: RxStatus.error(dioException.message));
      final apiException = ApiException.fromDioError(dioException);
      Get.dialog(ErrorAlertWidget(message: apiException.message));
      if (kDebugMode) {
        Logger().d('apiException: ${apiException.message}');
      }
    }
  }
}
