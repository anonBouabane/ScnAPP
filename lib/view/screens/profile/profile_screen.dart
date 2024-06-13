import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/data/model/response/update_profile.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';
import 'package:scn_easy/view/screens/lottery/lotto_main_page_dashbaord.dart';

import '../../../util/images.dart';
import '../../base/message_alert_message.dart';
import 'widgets/selected_bank_dialog.dart';

class ProfileScreen extends StatefulWidget {
  // final VoidCallback? onButtonPressed; // update by thin
  const ProfileScreen({Key? key}) : super(key: key); // update by thin

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
  final usernameController = TextEditingController();
  final mobileController = TextEditingController();
  String gender = "";
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (_isLoggedIn) {
      // Get.find<UserController>().getVersion();
      // Get.find<LotteryController>()
      //     .getBonusPointReferral(Get.find<AuthController>().getUserNumber());
      Get.find<UserController>().getUserInfo();
      Get.find<UserController>().setIsEditProfile(false);

      // if (Get.find<UserController>().userInfoModel != null) {
      usernameController.text =
          "${Get.find<UserController>().userInfoModel.firstname} ${Get.find<UserController>().userInfoModel.lastname}";
      mobileController.text =
          "${Get.find<UserController>().userInfoModel.phone}";
      Get.find<UserController>().firstName.value.text =
          Get.find<UserController>().userInfoModel.firstname.toString();
      Get.find<UserController>().lastName.value.text =
          Get.find<UserController>().userInfoModel.lastname.toString();
      Get.find<UserController>().bankName.value.text =
          Get.find<UserController>()
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('ຂໍ້ມູນສ່ວນຕົວ'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.shade700,
      ),
      body: Stack(
        children: [
          Image(
            image: AssetImage(Images.scnBackgroundPng),
            fit: BoxFit.cover,
            width: Get.width,
            height: Get.height,
          ),
          GetBuilder<UserController>(
            builder: (userController) {
              return OverlayLoaderWithAppIcon(
                isLoading: userController.isLoading,
                appIcon: Image.asset(Images.loadingLogo),
                circularProgressColor: Colors.green.shade800,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      showUserProfileUpdate(userController)
                      // userController.userInfoModel == null
                      //     ? Center(child: CircularProgressIndicator())
                      //     : showUserProfileUpdate(userController),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget showUserProfileUpdate(UserController userController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset(
          Images.logo,
          height: 160,
          width: 150,
          fit: BoxFit.fill,
        ),
        !userController.isEditProfile
            ? buildWidgetBeforeEditProfile()
            : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(Images.profileBg),
                    fit: BoxFit.fill,
                  ),
                ),
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 30,
                  bottom: 20,
                ),
                height: 390,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ---------- start update by thin ---------- //
                      buildFirstNameTextFormField(userController),
                      SizedBox(height: 10),
                      buildLastNameTextFormField(userController),
                      SizedBox(height: 10),
                      buildPhoneTextFormField(userController),
                      SizedBox(height: 10),
                      buildBankNameTextFormField(userController),
                      SizedBox(height: 10),
                      buildBankAccountNameTextFormField(userController),
                      SizedBox(height: 10),
                      buildBankAccountNumberTextFormField(userController),
                      // ---------- end update by thin ---------- //
                    ],
                  ),
                ),
              ),
        // --------------- start update by thin --------------- //
        buildButton(userController),
        // ------------- end update by thin ------------ //
      ],
    );
  }

  Widget buildWidgetBeforeEditProfile() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(Images.profileBg),
          fit: BoxFit.fill,
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
      height: 180,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "firstName".tr,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 25),
                    Text(
                      "phoneNo".tr,
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.inputBg),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(Images.inputBg),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: TextFormField(
                          controller: mobileController,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFirstNameTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "firstName".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: userController.firstName.value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLastNameTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "lastName".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: userController.lastName.value,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPhoneTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "phoneNo".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: mobileController,
              keyboardType: TextInputType.phone,
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankNameTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_name".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
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
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (context) {
                return BankListSelected();
              },
            );
            userController.update();
            Logger().w(userController.bankName.value.text);
          },
          child: Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.only(left: 4, right: 4),
            child: Icon(
              Icons.list_alt_outlined,
              size: 40,
              color: Colors.redAccent.shade700,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankAccountNameTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_account_name".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.inputBg),
                fit: BoxFit.fill,
              ),
            ),
            child: TextFormField(
              controller: userController.bankAccount.value,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBankAccountNumberTextFormField(UserController userController) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            "bank_account_no".tr,
            style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
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
                contentPadding: EdgeInsets.only(
                  left: 5,
                ),
              ),
              style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
          ),
        ),
        Container(
          width: 40,
          height: 40,
          padding: EdgeInsets.only(left: 4, right: 4),
          child: Icon(
            userController.userInfoModel.accStatus != 0
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            size: 40,
            color: userController.userInfoModel.accStatus != 0
                ? Colors.green.shade700
                : Colors.redAccent.shade700,
          ),
        ),
      ],
    );
  }

  Widget buildButton(UserController userController) {
    return Padding(
      padding: EdgeInsets.only(
        left: userController.isEditProfile ? 10 : 50,
        right: userController.isEditProfile ? 10 : 50,
      ),
      child: Row(
        children: [
          userController.isEditProfile
              ? Expanded(
                  child: InkWell(
                    // onTap: () => widget.onButtonPressed!(),
                    onTap: () => Get.to(LotteryMainPage()),
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.2,
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      margin: const EdgeInsets.only(bottom: 16),
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
                )
              : const SizedBox(),
          SizedBox(width: userController.isEditProfile ? 10 : 0),
          Expanded(
            child: InkWell(
              onTap: () async {
                if (userController.isEditProfile == false) {
                  userController.setIsEditProfile(true);
                } else {
                  if (_formKey.currentState!.validate()) {
                    if (userController.firstName.value.text.isEmpty ||
                        userController.lastName.value.text.isEmpty ||
                        userController.bankNo.value.text.isEmpty ||
                        userController.bankAccount.value.text.isEmpty ||
                        userController.bankName.value.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (context) => MessageAlertMsg(
                          'error',
                          'fillTheForm',
                          Icons.error_outline,
                          Colors.red,
                        ),
                      );
                    } else {
                      UserProfile profile = UserProfile();
                      profile.firstname = userController.firstName.value.text;
                      profile.lastname = userController.lastName.value.text;
                      profile.bankName = userController.bankName.value.text;
                      profile.accountNo = userController.bankNo.value.text;
                      profile.accountName =
                          userController.bankAccount.value.text;
                      profile.phone = mobileController.text;
                      profile.gender = gender;
                      profile.bankId = userController.bankId;
                      userController.updateUserInfo(profile);
                    }
                  }
                  // userController.setIsEditProfile(false);
                }
              },
              child: Container(
                // width: MediaQuery.of(context).size.width / 1.2,
                height: 50.0,
                padding: const EdgeInsets.only(left: 8, right: 8),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.buttonBg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Text(
                    !userController.isEditProfile
                        ? 'edit_profile'.tr
                        : 'save'.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
// import 'package:scn_easy/controller/auth_controller.dart';
// import 'package:scn_easy/controller/user_controller.dart';
// import 'package:scn_easy/data/model/response/update_profile.dart';
// import 'package:scn_easy/util/dimensions.dart';
// import 'package:scn_easy/util/styles.dart';
//
// import '../../../controller/lottery_controller.dart';
// import '../../../util/images.dart';
// import '../../base/message_alert_message.dart';
// import 'widgets/selected_bank_dialog.dart';
//
// class ProfileScreen extends StatefulWidget {
//   final VoidCallback? onButtonPressed; // update by thin
//   const ProfileScreen({Key? key, this.onButtonPressed}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final bool _isLoggedIn = Get.find<AuthController>().isLoggedIn();
//   final usernameController = TextEditingController();
//   final mobileController = TextEditingController();
//   String gender = "";
//   final _formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     super.initState();
//     if (_isLoggedIn) {
//       Get.find<UserController>().getVersion();
//       Get.find<LotteryController>()
//           .getBonusPointReferral(Get.find<AuthController>().getUserNumber());
//       Get.find<UserController>().setIsEditProfile(false);
//
//       if (Get.find<UserController>().userInfoModel != null) {
//         usernameController.text =
//             "${Get.find<UserController>().userInfoModel.firstname} ${Get.find<UserController>().userInfoModel.lastname}";
//         mobileController.text =
//             "${Get.find<UserController>().userInfoModel.phone}";
//         Get.find<UserController>().firstName.value.text =
//             Get.find<UserController>().userInfoModel.firstname.toString();
//         Get.find<UserController>().lastName.value.text =
//             Get.find<UserController>().userInfoModel.lastname.toString();
//         Get.find<UserController>().bankName.value.text =
//             Get.find<UserController>()
//                 .userInfoModel
//                 .bankName
//                 .toString()
//                 .replaceAll("null", "");
//         Get.find<UserController>().bankNo.value.text =
//             Get.find<UserController>()
//                 .userInfoModel
//                 .accountNo
//                 .toString()
//                 .replaceAll("null", "");
//         Get.find<UserController>().bankAccount.value.text =
//             Get.find<UserController>()
//                 .userInfoModel
//                 .accountName
//                 .toString()
//                 .replaceAll("null", "");
//         gender = Get.find<UserController>()
//             .userInfoModel
//             .gender
//             .toString()
//             .replaceAll("null", "m");
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             Image(
//                 image: AssetImage(Images.scnBackgroundPng),
//                 fit: BoxFit.cover,
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width),
//             GetBuilder<UserController>(
//               builder: (userController) {
//                 return OverlayLoaderWithAppIcon(
//                   isLoading: userController.isLoading,
//                   appIcon: Image.asset(Images.loadingLogo),
//                   circularProgressColor: Colors.green.shade800,
//                   child: SingleChildScrollView(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         userController.userInfoModel == null
//                             ? Center(child: CircularProgressIndicator())
//                             : Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   SizedBox(height: 20),
//                                   Image.asset(Images.logo,
//                                       height: 160,
//                                       width: 150,
//                                       fit: BoxFit.fill),
//                                   !userController.isEditProfile
//                                       ? Container(
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(20),
//                                               image: DecorationImage(
//                                                   image: AssetImage(
//                                                       Images.profileBg),
//                                                   fit: BoxFit.fill)),
//                                           margin: EdgeInsets.all(10),
//                                           padding: EdgeInsets.only(
//                                               left: 20,
//                                               right: 20,
//                                               top: 30,
//                                               bottom: 20),
//                                           height: 170,
//                                           child: Form(
//                                             key: _formKey,
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Column(
//                                                       children: [
//                                                         Text("firstName".tr,
//                                                             style: robotoBold
//                                                                 .copyWith(
//                                                                     fontSize:
//                                                                         Dimensions
//                                                                             .fontSizeLarge)),
//                                                         SizedBox(height: 25),
//                                                         Text("phoneNo".tr,
//                                                             style: robotoBold
//                                                                 .copyWith(
//                                                                     fontSize:
//                                                                         Dimensions
//                                                                             .fontSizeLarge)),
//                                                       ],
//                                                     ),
//                                                     SizedBox(width: 10),
//                                                     Expanded(
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         Images
//                                                                             .inputBg),
//                                                                     fit: BoxFit
//                                                                         .fill)),
//                                                             child:
//                                                                 TextFormField(
//                                                                     controller:
//                                                                         usernameController,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     readOnly:
//                                                                         true,
//                                                                     decoration:
//                                                                         InputDecoration(
//                                                                       border: InputBorder
//                                                                           .none,
//                                                                     ),
//                                                                     style: robotoBold.copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge)),
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         Images
//                                                                             .inputBg),
//                                                                     fit: BoxFit
//                                                                         .fill)),
//                                                             child:
//                                                                 TextFormField(
//                                                                     controller:
//                                                                         mobileController,
//                                                                     textAlign:
//                                                                         TextAlign
//                                                                             .center,
//                                                                     readOnly:
//                                                                         true,
//                                                                     keyboardType:
//                                                                         TextInputType
//                                                                             .phone,
//                                                                     decoration:
//                                                                         InputDecoration(
//                                                                       border: InputBorder
//                                                                           .none,
//                                                                     ),
//                                                                     style: robotoBold.copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge)),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         )
//                                       : Container(
//                                           decoration: BoxDecoration(
//                                             borderRadius:
//                                                 BorderRadius.circular(20),
//                                             image: DecorationImage(
//                                               image: AssetImage(
//                                                 Images.profileBg,
//                                               ),
//                                               fit: BoxFit.fill,
//                                             ),
//                                           ),
//                                           margin: EdgeInsets.all(10),
//                                           padding: EdgeInsets.only(
//                                             left: 20,
//                                             right: 20,
//                                             top: 30,
//                                             bottom: 20,
//                                           ),
//                                           height: 390,
//                                           child: Form(
//                                             key: _formKey,
//                                             child: Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Row(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: [
//                                                     Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .start,
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .start,
//                                                       children: [
//                                                         SizedBox(height: 4),
//                                                         Text(
//                                                           "firstName".tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 32),
//                                                         Text(
//                                                           "lastName".tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 33),
//                                                         Text(
//                                                           "phoneNo".tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 33),
//                                                         Text(
//                                                           "bank_name".tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 32),
//                                                         Text(
//                                                           "bank_account_name"
//                                                               .tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 30),
//                                                         Text(
//                                                           "bank_account_no".tr,
//                                                           style: robotoBold
//                                                               .copyWith(
//                                                             fontSize: Dimensions
//                                                                 .fontSizeLarge,
//                                                           ),
//                                                         ),
//                                                         SizedBox(height: 4),
//                                                       ],
//                                                     ),
//                                                     SizedBox(width: 10),
//                                                     Expanded(
//                                                       child: Column(
//                                                         children: [
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         Images
//                                                                             .inputBg),
//                                                                     fit: BoxFit
//                                                                         .fill)),
//                                                             child: TextFormField(
//                                                                 controller:
//                                                                     userController
//                                                                         .firstName
//                                                                         .value,
//                                                                 decoration: InputDecoration(
//                                                                     border:
//                                                                         InputBorder
//                                                                             .none,
//                                                                     contentPadding:
//                                                                         EdgeInsets.only(
//                                                                             left:
//                                                                                 5)),
//                                                                 style: robotoBold
//                                                                     .copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge)),
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         Images
//                                                                             .inputBg),
//                                                                     fit: BoxFit
//                                                                         .fill)),
//                                                             child: TextFormField(
//                                                                 controller:
//                                                                     userController
//                                                                         .lastName
//                                                                         .value,
//                                                                 decoration: InputDecoration(
//                                                                     border:
//                                                                         InputBorder
//                                                                             .none,
//                                                                     contentPadding:
//                                                                         EdgeInsets.only(
//                                                                             left:
//                                                                                 5)),
//                                                                 style: robotoBold
//                                                                     .copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge)),
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               image:
//                                                                   DecorationImage(
//                                                                 image:
//                                                                     AssetImage(
//                                                                   Images
//                                                                       .inputBg,
//                                                                 ),
//                                                                 fit:
//                                                                     BoxFit.fill,
//                                                               ),
//                                                             ),
//                                                             child:
//                                                                 TextFormField(
//                                                               controller:
//                                                                   mobileController,
//                                                               keyboardType:
//                                                                   TextInputType
//                                                                       .phone,
//                                                               readOnly: true,
//                                                               decoration: InputDecoration(
//                                                                   border:
//                                                                       InputBorder
//                                                                           .none,
//                                                                   contentPadding:
//                                                                       EdgeInsets.only(
//                                                                           left:
//                                                                               5)),
//                                                               style: robotoBold
//                                                                   .copyWith(
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeLarge,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Row(
//                                                             children: [
//                                                               Expanded(
//                                                                 child:
//                                                                     Container(
//                                                                   decoration: BoxDecoration(
//                                                                       image: DecorationImage(
//                                                                           image: AssetImage(Images
//                                                                               .inputBg),
//                                                                           fit: BoxFit
//                                                                               .fill)),
//                                                                   child:
//                                                                       TextFormField(
//                                                                     controller:
//                                                                         userController
//                                                                             .bankName
//                                                                             .value,
//                                                                     keyboardType:
//                                                                         TextInputType
//                                                                             .text,
//                                                                     readOnly:
//                                                                         true,
//                                                                     decoration:
//                                                                         InputDecoration(
//                                                                       border: InputBorder
//                                                                           .none,
//                                                                       contentPadding:
//                                                                           EdgeInsets.only(
//                                                                               left: 5),
//                                                                     ),
//                                                                     style: robotoBold.copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge),
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               InkWell(
//                                                                 onTap: () {
//                                                                   showDialog(
//                                                                       barrierDismissible:
//                                                                           false,
//                                                                       context: Get
//                                                                           .context!,
//                                                                       builder:
//                                                                           (context) =>
//                                                                               BankListSelected());
//                                                                 },
//                                                                 child: Container(
//                                                                     padding: EdgeInsets.only(
//                                                                         left: 4,
//                                                                         right:
//                                                                             4),
//                                                                     child: Icon(
//                                                                         Icons
//                                                                             .list_alt_outlined,
//                                                                         size:
//                                                                             40,
//                                                                         color: Colors
//                                                                             .redAccent
//                                                                             .shade700),
//                                                                     height: 40,
//                                                                     width: 40),
//                                                               )
//                                                             ],
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Container(
//                                                             decoration: BoxDecoration(
//                                                                 image: DecorationImage(
//                                                                     image: AssetImage(
//                                                                         Images
//                                                                             .inputBg),
//                                                                     fit: BoxFit
//                                                                         .fill)),
//                                                             child: TextFormField(
//                                                                 controller:
//                                                                     userController
//                                                                         .bankAccount
//                                                                         .value,
//                                                                 keyboardType:
//                                                                     TextInputType
//                                                                         .text,
//                                                                 decoration: InputDecoration(
//                                                                     border:
//                                                                         InputBorder
//                                                                             .none,
//                                                                     contentPadding:
//                                                                         EdgeInsets.only(
//                                                                             left:
//                                                                                 5)),
//                                                                 style: robotoBold
//                                                                     .copyWith(
//                                                                         fontSize:
//                                                                             Dimensions.fontSizeLarge)),
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           Container(
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               image:
//                                                                   DecorationImage(
//                                                                 image: AssetImage(
//                                                                     Images
//                                                                         .inputBg),
//                                                                 fit:
//                                                                     BoxFit.fill,
//                                                               ),
//                                                             ),
//                                                             child:
//                                                                 TextFormField(
//                                                               controller:
//                                                                   userController
//                                                                       .bankNo
//                                                                       .value,
//                                                               keyboardType:
//                                                                   TextInputType
//                                                                       .number,
//                                                               decoration:
//                                                                   InputDecoration(
//                                                                 border:
//                                                                     InputBorder
//                                                                         .none,
//                                                                 contentPadding:
//                                                                     EdgeInsets
//                                                                         .only(
//                                                                   left: 5,
//                                                                 ),
//                                                               ),
//                                                               style: robotoBold
//                                                                   .copyWith(
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeLarge,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                   InkWell(
//                                     onTap: () async {
//                                       if (userController.isEditProfile ==
//                                           false) {
//                                         userController.setIsEditProfile(true);
//                                       } else {
//                                         if (_formKey.currentState!.validate()) {
//                                           if (userController.firstName.value
//                                                   .text.isEmpty ||
//                                               userController.lastName.value.text
//                                                   .isEmpty ||
//                                               userController
//                                                   .bankNo.value.text.isEmpty ||
//                                               userController.bankAccount.value
//                                                   .text.isEmpty ||
//                                               userController.bankName.value.text
//                                                   .isEmpty) {
//                                             showDialog(
//                                                 context: context,
//                                                 builder: (context) =>
//                                                     MessageAlertMsg(
//                                                         'error',
//                                                         'fillTheForm',
//                                                         Icons.error_outline,
//                                                         Colors.red));
//                                           } else {
//                                             UserProfile profile = UserProfile();
//                                             profile.firstname = userController
//                                                 .firstName.value.text;
//                                             profile.lastname = userController
//                                                 .lastName.value.text;
//                                             profile.bankName = userController
//                                                 .bankName.value.text;
//                                             profile.accountNo = userController
//                                                 .bankNo.value.text;
//                                             profile.accountName = userController
//                                                 .bankAccount.value.text;
//                                             profile.phone =
//                                                 mobileController.text;
//                                             profile.gender = gender;
//                                             profile.bankId =
//                                                 userController.bankId;
//                                             userController
//                                                 .updateUserInfo(profile);
//                                           }
//                                         }
//                                         // userController.setIsEditProfile(false);
//                                       }
//                                     },
//                                     child: Container(
//                                       width: MediaQuery.of(context).size.width /
//                                           1.2,
//                                       padding: const EdgeInsets.only(
//                                           left: 8, right: 8),
//                                       margin: const EdgeInsets.only(bottom: 16),
//                                       decoration: BoxDecoration(
//                                           image: DecorationImage(
//                                               image:
//                                                   AssetImage(Images.buttonBg),
//                                               fit: BoxFit.fill)),
//                                       height: 50.0,
//                                       child: Center(
//                                         child: Text(
//                                           !userController.isEditProfile
//                                               ? 'edit_profile'.tr
//                                               : 'save'.tr,
//                                           style: robotoBold.copyWith(
//                                               fontSize:
//                                                   Dimensions.fontSizeExtraLarge,
//                                               color: Colors.white),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
