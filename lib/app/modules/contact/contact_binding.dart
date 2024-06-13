import 'package:get/get.dart';

import 'contact_controller.dart';
import 'contact_service.dart';

class ContactBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactController>(() => ContactController());
    Get.lazyPut<ContactService>(() => ContactService());
  }
}
