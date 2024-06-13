import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import 'referral_controller.dart';
import 'referral_service.dart';

class ReferralBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReferralController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => ReferralService());
  }
}
