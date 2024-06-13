import 'package:get/get.dart';

import 'payment_controller.dart';
import 'payment_service.dart';

class PaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentController());
    Get.lazyPut(() => PaymentService());
  }
}
