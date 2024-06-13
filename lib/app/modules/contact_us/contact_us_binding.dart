import 'package:get/get.dart';
import 'package:scn_easy/app/modules/contact_us/contact_us_service.dart';

import 'contact_us_controller.dart';

class ContactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactUsController>(() => ContactUsController());
    Get.lazyPut<ContactUsService>(() => ContactUsService());
  }
}
