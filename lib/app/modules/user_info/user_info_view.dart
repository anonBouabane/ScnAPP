import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../util/images.dart';
import '../../languages/translates.dart';
import '../../models/user_model.dart';
import '../../widgets/background_widget.dart';
import '../../widgets/error_alert_widget.dart';
import 'user_info_controller.dart';
import 'widgets/select_bank_account.dart';

class UserInfoView extends GetView<UserInfoController> {
  const UserInfoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text(Translates.APP_TITLE_USER_INFO.tr),
          centerTitle: true,
          backgroundColor: Colors.redAccent.shade700,
        ),
        body: Stack(
          children: [
            BackgroundWidget(),
            OverlayLoaderWithAppIcon(
              isLoading: controller.isLoading.value,
              appIcon: Image.asset(Images.loadingLogo),
              circularProgressColor: Colors.green.shade800,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    showUserProfileUpdate(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget showUserProfileUpdate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Image.asset(Images.logo, height: 160, width: 150, fit: BoxFit.fill),
        controller.isEditProfile.isFalse
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
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
                height: 390,
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ---------- start update by thin ---------- //
                      buildFirstNameTextFormField(),
                      SizedBox(height: 10),
                      buildLastNameTextFormField(),
                      SizedBox(height: 10),
                      buildPhoneTextFormField(),
                      SizedBox(height: 10),
                      buildBankNameTextFormField(),
                      SizedBox(height: 10),
                      buildBankAccountNameTextFormField(),
                      SizedBox(height: 10),
                      buildBankAccountNumberTextFormField(),
                      // ---------- end update by thin ---------- //
                    ],
                  ),
                ),
              ),
        // --------------- start update by thin --------------- //
        buildSaveButton(),
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
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    Translates.TEXT_FIELD_FIRST_NAME.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 25),
                  Text(
                    Translates.TEXT_FIELD_PHONE_NUMBER.tr,
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
                        controller: controller.txtUsername,
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
                        controller: controller.txtMobile,
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
    );
  }

  Widget buildFirstNameTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_FIRST_NAME.tr,
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
              controller: controller.txtFirstName,
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

  Widget buildLastNameTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_LAST_NAME.tr,
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
              controller: controller.txtLastName,
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

  Widget buildPhoneTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_PHONE_NUMBER.tr,
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
              controller: controller.txtMobile,
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

  Widget buildBankNameTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_BANK_COMPANY_NAME.tr,
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
              controller: controller.txtBankName,
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
        GestureDetector(
          onTap: () {
            Get.dialog(
              barrierDismissible: false,
              SelectBankCompanyWidget(),
            );
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

  Widget buildBankAccountNameTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_BANK_ACCOUNT_NAME.tr,
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
              controller: controller.txtBankAccountName,
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

  Widget buildBankAccountNumberTextFormField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            Translates.TEXT_FIELD_BANK_ACCOUNT_NUMBER.tr,
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
              controller: controller.txtBankAccountNumber,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 5),
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
            controller.bankAccountStatus.value != 0
                ? Icons.check_circle_outline
                : Icons.cancel_outlined,
            size: 40,
            color: controller.bankAccountStatus.value != 0
                ? Colors.green.shade700
                : Colors.redAccent.shade700,
          ),
        ),
      ],
    );
  }

  Widget buildSaveButton() {
    return Padding(
      padding: EdgeInsets.only(left: 50, right: 50),
      child: InkWell(
        onTap: () async {
          if (controller.isEditProfile.value == false) {
            controller.isEditProfile.value = true;
          } else {
            if (controller.formKey.currentState!.validate()) {
              if (controller.txtFirstName.text.isEmpty ||
                  controller.txtLastName.text.isEmpty ||
                  controller.txtBankAccountNumber.text.isEmpty ||
                  controller.txtBankAccountName.text.isEmpty ||
                  controller.txtBankName.text.isEmpty) {
                Get.dialog(ErrorAlertWidget(message: 'ກະລຸນາໃສ່ຂໍ້ມູນໃຫ້ຄົບ'));
              } else {
                UserModel profile = UserModel();
                profile.firstName = controller.txtFirstName.text;
                profile.lastName = controller.txtLastName.text;
                profile.bankName = controller.txtBankName.text;
                profile.accountNumber = controller.txtBankAccountNumber.text;
                profile.accountName = controller.txtBankAccountName.text;
                profile.phone = controller.txtMobile.text;
                profile.gender = controller.gender.value;
                profile.bankId = controller.bankId.value;
                controller.updateUserInfo(profile);
              }
            }
          }
        },
        child: Container(
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
              !controller.isEditProfile.value
                  ? Translates.BUTTON_EDIT_PROFILE.tr
                  : Translates.BUTTON_SAVE.tr,
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
