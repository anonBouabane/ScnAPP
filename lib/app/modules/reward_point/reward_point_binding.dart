import 'package:get/get.dart';

import '../../controllers/bonus_controller.dart';
import '../../controllers/user_controller.dart';
import 'reward_point_controller.dart';
import 'reward_point_service.dart';

class RewardPointBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RewardPointController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => BonusController());
    Get.lazyPut(() => RewardPointService());
  }
}
