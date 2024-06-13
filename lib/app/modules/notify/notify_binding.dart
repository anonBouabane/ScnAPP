import 'package:get/get.dart';

import 'notify_controller.dart';
import 'notify_service.dart';

class NotifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotifyController>(() => NotifyController());
    Get.lazyPut<NotifyService>(() => NotifyService());
  }
}
