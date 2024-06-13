import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../api/api_client_lottery.dart';
import '../model/response/update_profile.dart';

class UserRepo {
  final ApiClientLottery apiClient;

  UserRepo({required this.apiClient});

  Future<Response> getUserInfo() async {
    return await apiClient.lottoGet(AppConstants.CUSTOMER_INFO_URI);
  }

  Future<Response> updateProfile(UserProfile userInfoModel) async {
    return await apiClient.lottoPut(AppConstants.CUSTOMER_INFO_URI, userInfoModel.toJson());
  }

  Future<Response> updateProfileImage(XFile path) async {
    return await apiClient.putMultipartData("${AppConstants.UPDATE_CUSTOMER_PROFILE}", [MultipartBody("image", path)]);
  }
  Future<Response> getBankList() async {
    return await apiClient.lottoGet("${AppConstants.BANK_LIST}");
  }
}
