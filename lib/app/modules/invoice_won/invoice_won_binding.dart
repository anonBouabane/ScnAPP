import 'package:get/get.dart';

import 'invoice_won_controller.dart';

class InvoiceWonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceWonController());
  }
}
