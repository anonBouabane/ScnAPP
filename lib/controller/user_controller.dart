import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:scn_easy/data/model/response/response_model.dart';
import 'package:scn_easy/data/model/response/userinfo_model.dart';
import 'package:scn_easy/data/repository/user_repo.dart';
import 'package:scn_easy/helper/route_helper.dart';

import '../data/model/response/select_bank_model.dart';
import '../data/model/response/update_profile.dart';
import '../view/base/message_alert_message.dart';
import '../view/screens/lottery/widgets/lotto_custom_alert1.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({required this.userRepo});

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

  String _lengthOfLastName = "";
  String _lengthOfFirstName = "";

  String get lengthOfLastName => _lengthOfLastName;

  String get lengthOfFirstName => _lengthOfFirstName;

  void getFirstNameLength(newValue) {
    _lengthOfFirstName = newValue;
    update();
  }

  void getLastNameLength(newValue) {
    _lengthOfLastName = newValue;
    update();
  }

  bool _isEditProfile = false;

  bool get isEditProfile => _isEditProfile;

  void setIsEditProfile(bool edit) {
    _isEditProfile = edit;
    update();
  }

  String gender = "m";

  void setGender(s) {
    gender = s;
    update();
  }

  UserInfoModel _userInfoModel = UserInfoModel();
  bool _isLoading = false;

  UserInfoModel get userInfoModel => _userInfoModel;

  bool get isLoading => _isLoading;

  Future<ResponseModel> getUserInfo() async {
    ResponseModel _responseModel;
    _userInfoModel = UserInfoModel();
    _isLoading = true;
    update();
    Response response = await userRepo.getUserInfo();
    if (kDebugMode) {
      Logger().i(
          "statusCode: ${response.statusCode} getUserInfo: ${response.body}");
    }
    if (response.statusCode == 200) {
      _userInfoModel = UserInfoModel.fromJson(response.body);
      // if (_userInfoModel != null) {
      getBankNameAndId(
          _userInfoModel.bankId ?? 0, _userInfoModel.bankName.toString());
      // }

      _responseModel = ResponseModel(true, 'successful');
    } else {
      _isLoading = false;
      _responseModel = ResponseModel(false, response.statusText.toString());
      Get.offAllNamed(RouteHelper.signIn);
    }
    _isLoading = false;
    update();
    return _responseModel;
  }

  Future<ResponseModel> updateUserInfo(UserProfile updateUserModel) async {
    _isLoading = true;
    _pickedFile = null;
    _rawFile = null;
    update();
    ResponseModel _responseModel;
    Response response = await userRepo.updateProfile(updateUserModel);
    if (kDebugMode) {
      Logger().i('updateUserInfo: ${response.body}');
    }
    _isLoading = false;
    if (response.statusCode == 200) {
      _responseModel = ResponseModel(true, response.bodyString.toString());
      setIsEditProfile(false);
      getUserInfo();
      _bankId = 0;
      // print(response.bodyString);
    } else {
      _responseModel = ResponseModel(false, response.statusText.toString());
      // print(response.statusText);
    }
    update();
    return _responseModel;
  }

  void updateUserWithNewData(UserInfoModel user) async {
    _userInfoModel = user;
  }

  String _version = "";
  String _buildNumber = "";

  String get version => _version;

  String get buildNumber => _buildNumber;

  void getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version = packageInfo.version;
    _buildNumber = packageInfo.buildNumber;
    update();
  }

  XFile? _pickedFile;
  Uint8List? _rawFile;

  XFile? get pickedFile => _pickedFile;

  Uint8List? get rawFile => _rawFile;

  void pickImage() async {
    _pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      await updateUserProfileImage(_pickedFile!);
    }
    update();
  }

  Future<ResponseModel> updateUserProfileImage(XFile path) async {
    _isLoading = true;
    update();
    ResponseModel _responseModel;
    Response response = await userRepo.updateProfileImage(path);
    if (response.statusCode == 200) {
      getUserInfo();
      _responseModel = ResponseModel(true, response.bodyString!);
    } else {
      showDialog(
        context: Get.context!,
        builder: (context) => MessageAlertMsg(
          'error',
          response.body['msg'].toString(),
          Icons.error_outline,
          Colors.red,
        ),
      );
      _responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return _responseModel;
  }

  List<SelectBankModel> _bankList = [];

  List<SelectBankModel> get bankList => _bankList;

  Future<void> getBankList() async {
    Response response = await userRepo.getBankList();
    if (kDebugMode) {
      Logger().i(response.body);
    }
    if (response.statusCode == 200) {
      _bankList = [];
      response.body
          .forEach((bank) => _bankList.add(SelectBankModel.fromJson(bank)));
    } else {
      showDialog(
        barrierDismissible: false,
        context: Get.context!,
        builder: (context) => LottoCustomAlert1(
          message: response.statusText.toString(),
          isOkText: false,
        ),
      );
    }
    update();
  }

  int _selectedBankIndex = -1;

  int get selectedBank => _selectedBankIndex;
  int _bankId = 0;

  int get bankId => _bankId;

  void setSelectedBank(int index, int id, String name) {
    _selectedBankIndex = index;
    _bankId = id;
    bankName.value.text = name;
    Logger().w('--------- name: ${bankName.value.text}');
    update();
  }

  void getBankNameAndId(int id, String name) {
    _bankId = id;
    bankName.value.text = name;
    update();
  }

  bool _acceptTerms = false;
  bool get acceptTerms => _acceptTerms;
  void toggleTerms() {
    _acceptTerms = !_acceptTerms;
    update();
  }
}
