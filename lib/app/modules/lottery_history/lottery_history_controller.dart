import 'package:get/get.dart';

class LotteryHistoryController extends GetxController {
  RxInt tabIndex = RxInt(0);

  void setTabIndex(int value) {
    tabIndex.value = value;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
