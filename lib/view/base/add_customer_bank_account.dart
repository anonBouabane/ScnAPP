import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/util/dimensions.dart';

import '../../../../util/styles.dart';
import '../../controller/user_controller.dart';
import '../../data/model/response/update_profile.dart';
import '../../util/images.dart';
import '../screens/profile/widgets/selected_bank_dialog.dart';
import 'message_alert_message.dart';

class UpdateCustomerAccount extends StatefulWidget {
  const UpdateCustomerAccount({Key? key}) : super(key: key);

  @override
  State<UpdateCustomerAccount> createState() => _UpdateCustomerAccountState();
}

class _UpdateCustomerAccountState extends State<UpdateCustomerAccount> {
  final usernameController = TextEditingController();
  final mobileController = TextEditingController();
  String gender = "";

  @override
  void initState() {
    super.initState();
    // if (Get.find<UserController>().userInfoModel != null) {
    usernameController.text =
        "${Get.find<UserController>().userInfoModel.firstname} ${Get.find<UserController>().userInfoModel.lastname}";
    mobileController.text = "${Get.find<UserController>().userInfoModel.phone}";
    Get.find<UserController>().firstName.value.text =
        Get.find<UserController>().userInfoModel.firstname.toString();
    Get.find<UserController>().lastName.value.text =
        Get.find<UserController>().userInfoModel.lastname.toString();
    Get.find<UserController>().bankName.value.text = Get.find<UserController>()
        .userInfoModel
        .bankName
        .toString()
        .replaceAll("null", "");
    Get.find<UserController>().bankNo.value.text = Get.find<UserController>()
        .userInfoModel
        .accountNo
        .toString()
        .replaceAll("null", "");
    Get.find<UserController>().bankAccount.value.text =
        Get.find<UserController>()
            .userInfoModel
            .accountName
            .toString()
            .replaceAll("null", "");
    gender = Get.find<UserController>()
        .userInfoModel
        .gender
        .toString()
        .replaceAll("null", "m");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GetBuilder<UserController>(builder: (userController) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Text(
                      "ກະລຸນາໃສ່ເລກບັນຊີຮັບເງິນຖຶກເລກ",
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeOverLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "bank_name".tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.inputBg),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: TextFormField(
                            controller: userController.bankName.value,
                            keyboardType: TextInputType.text,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 5),
                            ),
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                            barrierDismissible: false,
                            context: Get.context!,
                            builder: (context) => BankListSelected(),
                          );
                        },
                        child: Container(
                            padding: EdgeInsets.only(left: 4, right: 4),
                            child: Icon(Icons.list_alt_outlined,
                                size: 40, color: Colors.redAccent.shade700),
                            height: 40,
                            width: 40),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("bank_account_name".tr,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(Images.inputBg),
                            fit: BoxFit.fill)),
                    child: TextFormField(
                        controller: userController.bankAccount.value,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(left: 5)),
                        style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge)),
                  ),
                  SizedBox(height: 10),
                  Text("bank_account_no".tr,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge)),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(Images.inputBg),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: TextFormField(
                      controller: userController.bankNo.value,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 5)),
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // ---------- start update by thin ------------- //
                        Expanded(
                          child: InkWell(
                            onTap: () => Get.back(),
                            child: Container(
                              // width: MediaQuery.of(context).size.width / 1.2,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              // margin: const EdgeInsets.only(bottom: 16),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.buttonBg),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              height: 50.0,
                              child: Center(
                                child: Text(
                                  'btnBack'.tr,
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeExtraLarge,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // ---------- end update by thin ------------- //
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              //
                              if (userController.firstName.value.text.isEmpty ||
                                  userController.lastName.value.text.isEmpty ||
                                  userController.bankNo.value.text.isEmpty ||
                                  userController
                                      .bankAccount.value.text.isEmpty ||
                                  userController.bankName.value.text.isEmpty) {
                                showDialog(
                                    context: context,
                                    builder: (context) => MessageAlertMsg(
                                        'error',
                                        'fillTheForm',
                                        Icons.error_outline,
                                        Colors.red));
                              } else {
                                UserProfile profile = UserProfile();
                                profile.firstname =
                                    userController.firstName.value.text;
                                profile.lastname =
                                    userController.lastName.value.text;
                                profile.bankName =
                                    userController.bankName.value.text;
                                profile.accountNo =
                                    userController.bankNo.value.text;
                                profile.accountName =
                                    userController.bankAccount.value.text;
                                profile.phone = mobileController.text;
                                profile.gender = gender;
                                profile.bankId = userController.bankId;
                                var response = await userController
                                    .updateUserInfo(profile);
                                if (response.isSuccess) {
                                  Get.back();
                                }
                              }
                            },
                            child: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.shade700,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                Translates.BUTTON_OK.tr,
                                style: robotoRegular.copyWith(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }),
          )),
    );
  }
}
