import 'package:get/get.dart';

import 'notification_controller.dart';
import 'notification_service.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
    Get.lazyPut<NotificationService>(() => NotificationService());
  }
}
