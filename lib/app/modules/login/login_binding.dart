import 'package:get/get.dart';

import '../../services/auth_service.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => AuthService());
  }
}
