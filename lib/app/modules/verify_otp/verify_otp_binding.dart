import 'package:get/get.dart';

import '../../services/auth_service.dart';
import 'verify_otp_controller.dart';

class VerifyOtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyOtpController());
    Get.lazyPut(() => AuthService());
  }
}
