import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../services/user_service.dart';
import 'buy_lottery_controller.dart';
import 'buy_lottery_service.dart';

class BuyLotteryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BuyLotteryController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => UserService());
    Get.lazyPut(() => BuyLotteryService());
  }
}
