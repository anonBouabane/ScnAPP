import 'dart:async';
import 'package:get/get.dart';
import 'package:scn_easy/data/repository/splash_repo.dart';

class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;

  SplashController({required this.splashRepo});

  bool _firstTimeConnectionCheck = true;
  bool _hasConnection = true;
  String _htmlText = "";
  bool _isLoading = false;

  DateTime get currentTime => DateTime.now();

  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  bool get hasConnection => _hasConnection;

  String get htmlText => _htmlText;

  bool get isLoading => _isLoading;

  Future<void> initSharedData() async {
    splashRepo.initSharedData();
  }

  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }
}
