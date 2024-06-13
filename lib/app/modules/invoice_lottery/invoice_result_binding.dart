import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import 'invoice_result_controller.dart';
import 'invoice_result_service.dart';

class InvoiceResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceResultController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => InvoiceResultService());
  }
}
