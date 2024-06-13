import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../services/bonus_service.dart';
import '../../services/user_service.dart';
import 'dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => BonusService());
  }
}
