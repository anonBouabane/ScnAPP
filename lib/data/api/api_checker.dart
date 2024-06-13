import 'package:get/get.dart';
import 'package:scn_easy/controller/auth_controller.dart';

class ApiChecker {
  static void checkApi(Response response, String from) {
    if (response.statusCode == 401 || response.statusCode == 404 || response.statusCode == 500) {
      if (response.body['msg'] == "ກະລຸນາເຂົ້າສູ່ລະບົບ") {
        Get.find<AuthController>().clearSharedData();
      }
    }
  }
}
