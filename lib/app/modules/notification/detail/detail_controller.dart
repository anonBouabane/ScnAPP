import 'package:get/get.dart';

import '../notification_model.dart';

class NotificationDetailController extends GetxController {
  late NotificationModel notificationModel;

  @override
  void onInit() {
    super.onInit();
    notificationModel = Get.arguments;
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
