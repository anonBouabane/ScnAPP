import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/data/model/response/response_model.dart';
import 'package:scn_easy/data/repository/auth_repo.dart';

import '../app/controllers/storage_controller.dart';
import '../view/screens/auth/verify_otp/login_verification_screen.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;

  AuthController({required this.authRepo});
  final StorageController storageController = Get.put(StorageController());

  final phoneNo = TextEditingController().obs;

  String _phoneLength = "";

  String get phoneLength => _phoneLength;

  void getPhoneLength(newValue) {
    _phoneLength = newValue;
    update();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // RxString _accessToken = ''.obs;
  // String get accessToken => _accessToken.value;
  // set accessToken(String newValue) => _accessToken.value = newValue;

  Future<ResponseModel> login(String phone, String password) async {
    _isLoading = true;
    update();
    Response response = await authRepo.login(phone: phone, password: password);
    if (kDebugMode) {
      Logger().i(response.body);
    }
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      authRepo.saveUserToken(response.body['token']);
      setUserPhone(phone);
      updateToken();
      storageController.accessToken = response.body['token'];
      // accessToken = authRepo.getAccessToken();
      responseModel = ResponseModel(true, response.bodyString.toString());
    } else {
      if (response.body['msg'] != null) {
        responseModel = ResponseModel(false, response.body['msg']);
      } else {
        responseModel =
            ResponseModel(false, response.statusText.toString().toString());
      }
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  void clearPhoneNo() {
    phoneNo.value.text = "";
    update();
  }

  ///Spite from login
  Future<ResponseModel> sendOTP(String phone) async {
    _isLoading = true;
    update();
    Response response = await authRepo.sendSms(phone: phone);
    if (kDebugMode) {
      Logger().i(response.body);
    }
    ResponseModel responseModel;
    if (response.statusCode == 200) {
      Get.to(() => LoginVerificationScreen(number: phone));
      responseModel = ResponseModel(true, 'success');
    } else if (response.statusCode == 502) {
      responseModel =
          ResponseModel(false, response.statusText.toString().toString());
    } else {
      responseModel =
          ResponseModel(false, response.statusText.toString().toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

  String _verificationCode = '';

  String get verificationCode => _verificationCode;

  void updateVerificationCode(String query) {
    _verificationCode = query;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  bool clearSharedData() {
    update();
    return authRepo.clearSharedData();
  }

  String getUserNumber() {
    return authRepo.getUserNumber();
  }

  void setUserPhone(String phone) async {
    authRepo.setUserPhone(phone);
  }
}
