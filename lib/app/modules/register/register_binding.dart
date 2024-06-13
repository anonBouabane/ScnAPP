import 'package:get/get.dart';

import '../../services/user_service.dart';
import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => UserService());
  }
}
