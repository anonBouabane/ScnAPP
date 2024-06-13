import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/data/model/response/response_model.dart';
import 'package:scn_easy/data/model/response/userinfo_model.dart';
import 'package:scn_easy/helper/route_helper.dart';

import '../models/bank_model.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../widgets/custom_dialog_widget.dart';

class UserController extends GetxController {
  final UserService userService = Get.find<UserService>();

  @override
  void onInit() {
    super.onInit();
    getBankList();
  }

  @override
  void dispose() {
    super.dispose();
    firstName.value.dispose();
    lastName.value.dispose();
    bankName.value.dispose();
    bankNo.value.dispose();
    bankAccount.value.dispose();
  }

  final firstName = TextEditingController().obs;
  final lastName = TextEditingController().obs;
  final bankName = TextEditingController().obs;
  final bankNo = TextEditingController().obs;
  final bankAccount = TextEditingController().obs;

  RxString _lengthOfLastName = ''.obs;
  RxString _lengthOfFirstName = ''.obs;

  String get firstNameLength => _lengthOfLastName.value;

  String get lastNameLength => _lengthOfFirstName.value;

  set firstNameLength(newValue) {
    _lengthOfFirstName.value = newValue;
  }

  set lastNameLength(newValue) {
    _lengthOfLastName.value = newValue;
  }

  RxBool _isEditProfile = false.obs;
  bool get isEditProfile => _isEditProfile.value;
  set isEditProfile(bool newValue) {
    _isEditProfile.value = newValue;
  }

  RxString _gender = 'm'.obs;
  String get gender => _gender.value;
  set gender(String newValue) {
    _gender.value = newValue;
  }

  UserInfoModel _userInfoModel = UserInfoModel();
  UserInfoModel get userInfoModel => _userInfoModel;

  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool newValue) {
    _isLoading.value = newValue;
  }

  Future<ResponseModel> getUserInfo() async {
    ResponseModel _responseModel;
    _userInfoModel = UserInfoModel();
    isLoading = true;
    final response = await userService.getUserInfo();
    if (kDebugMode) {
      Logger().i(
        'statusCode: ${response.statusCode}\n'
        'getUserInfo: ${response.data}',
      );
    }
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.data);
      getBankNameAndId(
        _userInfoModel.bankId ?? 0,
        _userInfoModel.bankName.toString(),
      );

      _responseModel = ResponseModel(true, 'successful');
    } else {
      isLoading = false;
      _responseModel = ResponseModel(false, response.statusMessage.toString());
      Get.offAllNamed(RouteHelper.signIn);
    }
    isLoading = false;
    return _responseModel;
  }

  Future<ResponseModel> updateUserInfo(UserProfile updateUserModel) async {
    isLoading = true;
    _pickedFile = null;
    _rawFile = null;
    ResponseModel _responseModel;
    final response = await userService.updateProfile(updateUserModel);
    if (kDebugMode) {
      Logger().i('updateUserInfo: ${response.data}');
    }

    isLoading = false;
    if (response.statusCode == 200) {
      _responseModel = ResponseModel(true, response.data.toString());
      isEditProfile = false;
      getUserInfo();
      bankId = 0;
    } else {
      _responseModel = ResponseModel(false, response.statusMessage.toString());
    }
    return _responseModel;
  }

  void updateUserWithNewData(UserInfoModel user) async {
    _userInfoModel = user;
  }

  RxString _version = ''.obs;
  String get version => _version.value;
  RxString _buildNumber = ''.obs;
  String get buildNumber => _buildNumber.value;

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
    _buildNumber.value = packageInfo.buildNumber;
  }

  XFile? _pickedFile;
  Uint8List? _rawFile;
  XFile? get pickedFile => _pickedFile;
  Uint8List? get rawFile => _rawFile;

  // void pickImage() async {
  //   _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (_pickedFile != null) {
  //     await updateUserProfileImage(_pickedFile!);
  //   }
  //   update();
  // }

  // Future<ResponseModel> updateUserProfileImage(XFile path) async {
  //   isLoading = true;
  //   ResponseModel _responseModel;
  //   final response = await userService.updateProfileImage(path);
  //   if (response.statusCode == 200) {
  //     getUserInfo();
  //     _responseModel = ResponseModel(true, response.bodyString!);
  //   } else {
  //     showDialog(
  //       context: Get.context!,
  //       builder: (context) => MessageAlertMsg(
  //         'error',
  //         response.body['msg'].toString(),
  //         Icons.error_outline,
  //         Colors.red,
  //       ),
  //     );
  //     _responseModel = ResponseModel(false, response.statusText!);
  //   }
  //   isLoading = false;
  //   return _responseModel;
  // }

  RxList<BankItem> _bankList = <BankItem>[].obs;
  List<BankItem> get bankList => _bankList;

  Future<void> getBankList() async {
    final response = await userService.getBankList();
    if (kDebugMode) {
      Logger().i('getBankList: ${response.data}');
    }
    if (response.statusCode == 200) {
      _bankList.value = [];
      for (var item in response.data) {
        _bankList.add(BankItem.fromJson(item));
      }
      // response.data.forEach((bank) => _bankList.add(BankItem.fromJson(bank)));
    } else {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => CustomDialogWidget(
          title: Translates.ERROR.tr,
          message: response.statusMessage.toString(),
        ),
      );
    }
  }

  RxInt _selectedBankIndex = 0.obs;
  int get selectedBank => _selectedBankIndex.value;
  set selectedBank(int newValue) {
    _selectedBankIndex.value = newValue;
  }

  RxInt _bankId = 0.obs;
  int get bankId => _bankId.value;
  set bankId(int newValue) {
    _bankId.value = newValue;
  }

  void setSelectedBank(int index, int id, String name) {
    selectedBank = index;
    bankId = id;
    bankName.value.text = name;
    Logger().w('--------- name: ${bankName.value.text}');
  }

  void getBankNameAndId(int id, String name) {
    bankId = id;
    bankName.value.text = name;
  }

  RxBool _acceptTerms = false.obs;
  bool get acceptTerms => _acceptTerms.value;
  set acceptTerms(bool newValue) {
    _acceptTerms.value = newValue;
  }

  void toggleTerms() {
    acceptTerms = !_acceptTerms.value;
  }
}
