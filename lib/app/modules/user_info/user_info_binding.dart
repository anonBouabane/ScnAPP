import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import '../../services/user_service.dart';
import 'user_info_controller.dart';
import 'user_info_service.dart';

class UserInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserInfoController());
    Get.lazyPut(() => UserController());
    Get.lazyPut(() => UserInfoService());
    Get.lazyPut(() => UserService());
  }
}
